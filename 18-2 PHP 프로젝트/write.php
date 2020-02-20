<html>
<head>
    <meta charset="utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
    <link rel="stylesheet" type="text/css" href="board.css">

</head>
<body>
  <?php include_once("sessioncheck.php") ?>
      <div class="menubar">
          <ul>
              <li><a href="index.html">Home</a></li>
              <li>
                  <a href="#">Board</a>
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

      <div id="board_area">
  			<br><br><br>
          <h1>Free Board</h1>
          <br><br>
          <form action="write1.php" method="post">
            <?
            echo "Writer: ";
            echo $_SESSION['userid'];
            ?>
            <br>
            TITLE : <input type="text" name="title" />
             <br />CONTENTS : <br />
             <textarea name="contents"></textarea>
             <br />
             <input type="submit" value="submit" />
         </form>
      </div>


</body>
</html>
