<?php
	session_start();
	header('Content-Type: text/html; charset=utf-8'); // utf-8인코딩

	$db = new mysqli("localhost","test","1111","project");
	$db->set_charset("utf8");

	function mq($sql)
	{
		global $db;
		return $db->query($sql);
	}
?>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>업서 죽었어</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
    <link rel="stylesheet" type="text/css" href="board.css">
</head>
<body>
	<div class="menubar">
			<ul>
					<li><a href="index.html">Home</a></li>
					<li>
							<a href="#" id="current">Board</a>
							<ul>
									<li><a href="Board1.php">Free Board</a></li>
									<li><a href="#">Galleries</a></li>
									<li><a href="#">Apps</a></li>
									<li><a href="#">Extensions</a></li>
							</ul>
					</li>


					<li_r><a href="logout.php">Logout</a></li_r>
					<li_r><a href="join.html">Sign Up</a></li_r>
					<li_r><a href="login.html">Login</a></li_r>
			</ul>
	</div>
	<hr>
    <div id="board_area">
			<br><br><br>
        <h1>Free Board</h1>
        <table class="list-table">
            <thead>
                <tr>
                    <th width="70">번호</th>
                    <th width="500">제목</th>
                    <th width="120">글쓴이</th>
                    <th width="100">작성일</th>
                    <th width="100">조회수</th>
                </tr>
            </thead>
            <?php
						$res = mysqli_query($db, "select * from board1 order by No desc limit 0,10;") or die("Query Error");
            /*여기서부터 쿼리문으로 board테이블 내부 데이터 뜯어와야함 어떻게 수정할지는 미래의 나에게 맡기자
						미래의 나가 뜯어는 왔음 근데 무한루프 걸림 자살각이다 */

            while($board = mysqli_fetch_array($res)){
            	/*if(strlen($title)>30){
            		$title=str_replace($board["title"],mb_substr($board["title"],0,30,"utf-8")."...",$board["title"]); //title이 30을 넘어서면 ...표시
            	}*/

            	echo "<tbody>
                		<tr>
                    		<td width=\"70\">$board[No]</td>
                    	<td width=\"500\"><a href=\"\">$board[title]</a></td>
                    	<td width=\"120\"> $board[nick]</td>
                    	<td width=\"100\">$board[time]</td>
											<td width=\"100\">$board[hit]</td>
                	</tr>
            	</tbody>";
            }
						mysqli_close($db);
						?>

        </table>
        <div id="write_btn">
            <a href="write.html"><button>글쓰기</button></a>
        </div>
    </div>
</body>
</html>
