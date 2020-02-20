<?php
session_start();

if(isset($_SESSION['id'])&&isset($_SESSION['pw'])){
    $id = $_SESSION['id'];
    $pw = $_SESSION['pw'];
    echo "ID: $id<br>PW: $id<br><br>";
}
else header("Location:login.html");
?>