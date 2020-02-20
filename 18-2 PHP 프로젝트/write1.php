<?
session_start();
$con = mysqli_connect("localhost", "test", "1111", "project") or die(mysqli_error());

$id = $_SESSION['userid'];
$nick = $_SESSION['usernick'];
$title = $_REQUEST['title'];
$contents = $_REQUEST['contents'];

if($con) echo("connected");
else echo("failed");

$query_i="insert into board1 (title, contents, writer, nick) values ('$title', '$contents', '$id', '$nick');";

mysqli_query($con, $query_i);

mysqli_close($con);
echo "<script>confirm('Post Registered');location.href='board1.php'</script>";
?>
