<?
session_start();
$con = mysqli_connect("localhost", "test", "1111", "project") or die(mysqli_error());

$no = $_GET['no'];
$title = $_REQUEST['title'];
$contents = $_REQUEST['contents'];

if($con) echo("connected");
else echo("failed");

$query_i="update board1 set title='$title', contents='$contents' where No = $no;";

mysqli_query($con, $query_i);

mysqli_close($con);
echo "<script>confirm('Post Modified');location.href='board1.php'</script>";
?>
