<?php
session_start();
session_destroy();
$_SESSION = [];
echo "<script>confirm('Log Out');location.href='index.html'</script>";
?>
