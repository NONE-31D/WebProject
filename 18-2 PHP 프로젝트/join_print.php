<?php

$name = $_GET['name'];
$pw = $_GET['pw'];
$gender = $_GET['gender'];
$hobby = $_GET['hobby'];

echo"<font size=20>ȸ������ ���<br></font>";
echo"ȸ�� �̸� : $name<br>";
echo"ȸ�� ��й�ȣ : $pw<br>";
echo"ȸ�� ���� : $gender<br>";
//echo str_replace("\n", "\r", "ȸ�� ��� :");
echo"ȸ�� ���:";
foreach($hobby as $s){
    echo"\t $s";
}

?>