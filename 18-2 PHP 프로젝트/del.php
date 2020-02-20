<?php
session_start();
$db = new mysqli("localhost","test","1111","project");


$id = $_GET['id'];
$no= $_GET['no'];

if($_SESSION['userid']!=$id){
  echo "<script>confirm('Not Allowed');location.href='board1.php'</script>";
}

$res = mysqli_query($db, " delete from board1 where No=$no;") or die("Query Error");
echo "<script>alert('Deleted');location.href='board1.php'</script>";
?>
