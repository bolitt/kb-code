$timeInterval = 30 #ÿ30s���һ��
$record = @{"����" = 0; "���" = 0; "�ĵ�" = 0; "����" = 0}
$count = 0
$date = date -u %y-%m-%d
$dir = "."
$log = $dir + "\TimeManager_" + $date + ".txt"
$start = date
if ( !(test-path $dir) ) { mkdir $dir }


Function Say($msg)
{
	$voice = (New-Object -ComObject SAPI.SpVoice)
	$vlist = $voice.getVoices()
	$voice.Voice = $vlist.item(3)
	$voice.Speak($msg)
}


while ($true)
{
	$cases = @{"����" = $false; "���" = $false; "�ĵ�" = $false; "����" = $false}
	$titles = ps | ? {$_.MainWindowTitle} | select ProcessName
	$titles | % { #�ⲿ������ƥ�䴰�ڱ��Ⲣ����ͳ�ƣ��������ɶ���
		if ($_ -match "chrome") { 
			$cases["����"] = $true
			Say("�������������벻Ҫ���˹�����")
		}
		if ( ($_ -match "devenv") -or 
			 ($_ -match "iexplore")
			) { 
			$cases["���"] = $true
			Say("�����ڱ�̡���ע�����ݽ�ϣ�")
		}
		if ( ($_ -match "googletalk") -or 
			 ($_ -match "QQ") -or
			 ($_ -match "communicator")
			) { 
			$cases["����"] = $true
			Say("���������졣�벻Ҫ���˹�����")
		}
		if ( ($_ -match "WINWORD") -or 
			 ($_ -match "EXCEL") -or
			 ($_ -match "POWERPNT") -or
			 ($_ -match "OUTLOOK") -or
			 ($_ -match "ONENOTE") 
			) { 
			$cases["�ĵ�"] = $true
			Say("�����ڱ༭�ĵ�����ע�����ݽ�ϣ�")
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
	$count = ($count + 1) % 10 #Ϊ�˷�ֹ���ݶ�ʧ��ÿ10�μ�¼д���ļ�һ��
	sleep($timeInterval) #���߳�ת��˯�ߣ�ÿ30�뻽��һ��
}