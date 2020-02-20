<?php

$name = $_GET['name'];
$pw = $_GET['pw'];
$gender = $_GET['gender'];
$hobby = $_GET['hobby'];

echo"<font size=20>회원정보 출력<br></font>";
echo"회원 이름 : $name<br>";
echo"회원 비밀번호 : $pw<br>";
echo"회원 성별 : $gender<br>";
//echo str_replace("\n", "\r", "회원 취미 :");
echo"회원 취미:";
foreach($hobby as $s){
    echo"\t $s";
}

?>