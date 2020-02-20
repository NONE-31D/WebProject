<?php
session_start();

if(!(isset($_SESSION['userid'])&&isset($_SESSION['usernick']))){
  echo "<script>confirm('Not Allowed');location.href='board1.php'</script>";
}

?>
