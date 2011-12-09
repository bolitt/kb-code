$timeInterval = 30 #每30s监测一次
$record = @{"上网" = 0; "编程" = 0; "文档" = 0; "聊天" = 0}
$count = 0
$date = date -u %y-%m-%d
$dir = "e:\Tools\log"
$log = $dir + "\TimeManager_" + $date + ".txt"
$start = date
if ( !(test-path $dir) ) { mkdir $dir }


while ($true)
{
	$cases = @{"上网" = $false; "编程" = $false; "文档" = $false; "聊天" = $false}
	$titles = ps | ? {$_.MainWindowTitle} | select ProcessName
	$titles | % { #这部分用来匹配窗口标题并进行统计，可以自由定义
		if ($_ -match "chrome") { 
			$cases["上网"] = $true
		}
		if ( ($_ -match "devenv") -or 
			 ($_ -match "iexplore")
			) { 
			$cases["编程"] = $true
		}
		if ( ($_ -match "googletalk") -or 
			 ($_ -match "QQ") -or
			 ($_ -match "communicator")
			) { 
			$cases["聊天"] = $true
		}
		if ( ($_ -match "WINWORD") -or 
			 ($_ -match "EXCEL") -or
			 ($_ -match "POWERPNT") -or
			 ($_ -match "OUTLOOK") -or
			 ($_ -match "ONENOTE") 
			) { 
			$cases["文档"] = $true
		}
	}
	foreach ($k in $cases.Keys) {
		if ($cases[$k]) { $record[$k] += $timeInterval }
	}
	
	# echo $record
	if ($count -eq 0)
	{
		$now = date
		echo ("==> start: " + $start) > $log
		echo ($record) >> $log
		echo ("==> end: " + $now) >> $log
	}
	$count = ($count + 1) % 10 #为了防止数据丢失，每10次记录写入文件一次
	sleep($timeInterval) #将线程转入睡眠，每30秒唤醒一次
}