<?
$con = mysqli_connect("localhost", "test", "1111", "project")or die(mysqli_error());

$id = $_GET['id'];
$pw = $_GET['pw'];
$nick = $_GET['nick'];

if($con) echo("connected");
else echo("failed");

$query_i="insert into member values('','$id', '$pw','$nick');";
mysqli_query($con, $query_i);

mysqli_close($con);

header("Location: index.html");
?>

