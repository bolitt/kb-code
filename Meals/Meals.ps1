## Step1: �ѱ�ѡ�Ĳ�����ӵ�ѡ���
$meals = @(
    "�Ͼ�԰ | Tel: 62771660 | 6:30-13:00��16:30-19:30";
    "����԰ | 6:30-13:15, 16:50-19:30";
    "����԰ | 7:00-9:00, 11:00-13:00, 17:00-19:00";
    "������ | Tel: 62782865 | 10:30-22:30")

## Step2: ���ѡ��һ������
$choice = "���˶��ͣ� " + $meals[ (get-random) % ($meals.count) ]
echo $choice

## ����UI��
function Show-MessageBox ([string]$message) { 
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null 
    [Windows.Forms.MessageBox]::Show($message) | Out-Null
}

## Step3: �����û�ѡ�����
Show-MessageBox $choice