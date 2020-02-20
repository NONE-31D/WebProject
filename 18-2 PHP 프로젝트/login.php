<?php
session_start();

$con = mysqli_connect("localhost", "test", "1111", "project")or die(mysqli_error());

$id = $_GET['id'];
$pw = $_GET['passwd'];

$pw_q="select * from member where id='$id';";
$pw_check = mysqli_query($con, $pw_q);
$res = mysqli_fetch_array($pw_check);



if($res['PW']==NULL) {
  echo "Wrong ID";
  echo "<br><a href=\"login.html\">===Return to Login===</a>";
  //echo "<script>confirm($res[PW]);</script>";
}
else if($pw==$res['PW']) { 
  $_SESSION['userid']=$id;           //로그인 성공 시 세션 변수 만들기
  $_SESSION['usernick']=$res[Nick];
  if(isset($_SESSION['userid'])&&isset($_SESSION['usernick']))    //세션 변수가 참일 때
  {
    header('Location: ./index.html');   //로그인 성공 시 페이지 이동
    //echo "<script>confirm($res[PW]);</script>";
  }
    else{
      echo "세션 저장 실패";
     }            
  }
else{
        echo "Wrong PW";
        echo "<br><a href=\"login.html\">===Return to Login===</a>";
        //echo "<script>confirm($res[PW]);</script>";
    }




mysqli_close($con);

?>









