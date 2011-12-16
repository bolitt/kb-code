#$str = "
#var win = window.open('http://www.google.com');
#var doc = win.document;
#document.writeln(doc);
#"
$str = "
myWindow = window;//.open('','','width=200,height=100');
//myWindow.document.write('This is myWindow');
myWindow.focus();
alert(0);
"
$str = "javascript:" + $str + ""
echo "[Echo]" ($str)

C:\Windows\System32\mshta $str