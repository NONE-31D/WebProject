
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@page import="www.BoardBean, www.CommentBean, java.util.*"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<jsp:useBean id="bMgr" class="www.BoardMgr" />
<jsp:useBean id="cMgr" class="www.CommentMgr" />
<%
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  String keyField = request.getParameter("keyField");
	  String keyWord = request.getParameter("keyWord");
	  bMgr.upCount(num);//조회수 증가
	  BoardBean bBean = bMgr.getBoard(num);//게시물 가져오기
	  String name = bBean.getName();
	  String subject = bBean.getSubject();
      String regdate = bBean.getRegdate();
	  String content = bBean.getContent();
	  String filename = bBean.getFilename();
	  int filesize = bBean.getFilesize();
	  String ip = bBean.getIp();
	  int count = bBean.getCount();
	  int likes = bBean.getLike();
	  
	  Vector<CommentBean> clist = null;
	  int totalRecord=0; //전체레코드수
	  int numPerPage=10; // 페이지당 레코드 수 
	  int pagePerBlock=15;  //블럭당 페이지수 
	  
	  int totalPage=0; //전체 페이지 수
	  int totalBlock=0;  //전체 블럭수 

	  int nowCommentPage=1; // 현재페이지
	  int nowBlock=1;  //현재블럭
	  
	  int start=0; //디비의 select 시작번호
	  int end=10; //시작번호로 부터 가져올 select 갯수
	  int like=0;
	  int listSize= cMgr.getTotalCount(); //현재 읽어온 게시물의 수
%>
	  
<html>
<head>
<title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list(){
	 	document.listFrm.action="list.jsp";
	    document.listFrm.submit();
	 } 
	
	function down(filename){
		 document.downFrm.filename.value=filename;
		 document.downFrm.submit();
	}
	
</script>
</head>
<body bgcolor="#FFFFCC">
<br><br>
<table align="center" width="70%" border=0 cellspacing="3" cellpadding="0">
 <tr>
  <td bgcolor="#9CA2EE" height="25" align="center">글읽기</td>
 </tr>
 <tr>
  <td colspan="2">
   <table border="0" cellpadding="3" cellspacing="0" width=100%> 
    <tr> 
  <td align="center" bgcolor="#DDDDDD" width="10%"> 이 름 </td>
  <td bgcolor="#FFFFE8"><%=name%></td>
  <td align="center" bgcolor="#DDDDDD" width=10%> 등록날짜 </td>
  <td bgcolor="#FFFFE8"><%=regdate%></td>
 </tr>
 <tr> 
    <td align="center" bgcolor="#DDDDDD"> 제 목</td>
    <td bgcolor="#FFFFE8" colspan="3"><%=subject%></td>
   </tr>
   <tr>
   <td align="center" bgcolor="#DDDDDD" width="10%"> 공감수 </td>
  <td bgcolor="#FFFFE8"><%=likes%></td>
  <td align="center" bgcolor="#DDDDDD" width=10%> 공감 </td>
  <td bgcolor="#FFFFE8">
  <button id="button1" onclick="location.href='upLikes.jsp?num=<%=num%>'">공감하기</button>
  
  </td>
   
    </tr>
   <tr> 
     <td align="center" bgcolor="#DDDDDD">첨부파일</td>
     <td bgcolor="#FFFFE8" colspan="3">
     <% if( filename !=null && !filename.equals("")) {%>
  		<a href="javascript:down('<%=filename%>')"><%=filename%></a>
  		 &nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)</font>  
  		 <%} else{%> 등록된 파일이 없습니다.<%}%>
     </td>
   </tr>
   <tr> 
    <td colspan="4"><br><pre><%=content%></pre><br></td>
   </tr>
   <tr>
    <td colspan="4" align="right">
     <%=ip%>로 부터 글을 남기셨습니다./  조회수  <%=count%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align="center" colspan="2"> 
 <hr size="1">
 [ <a href="javascript:list()" >리스트</a> | 
 <a href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>" >수 정</a> |
 <a href="reply.jsp?nowPage=<%=nowPage%>" >답 변</a> |
 <a href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">삭 제</a> ]<br>
  </td>
 </tr>
</table>

<form name="downFrm" action="download.jsp" method="post">
	<input type="hidden" name="filename">
</form>

<% //댓글
				  clist = cMgr.getCommentList(num);
				  listSize = clist.size();//브라우저 화면에 보여질 게시물갯수
				  %>
				  
				  
				  <form name="CommentFrm" method="post" action="../comment/insertComment.jsp" enctype="multipart/form-data">
				  	<table align="center" width="70%" border=0 cellspacing="3" cellpadding="0">
				  	<tr>
				  	<td colspan = 2 align="center" bgcolor="#D0D0D0" height="120%">댓글 쓰기</td>
				  	</tr>
				  		<tr >
						<td align="center">이 름</td>
						<td ><input type="text" name="cname" size="10" maxlength="8"></td>
						</tr>
						<tr>	
						<td align="center" >내 용</td>
						<td ><input type="text" name="comment"></td>
						</tr>
						<tr>	
						<td align="center" >비밀번호</td>
						<td ><input type="text" name="pass"><input type="hidden" name="bnum" value=<%=num %>></td>
						</tr>
						<tr>
						<td colspan = 2 align="center" ><input type="submit" value="댓글쓰기"></td>
						</tr>
				  	</table>
				  </form>
				  
				  <table align="center" width="70%" border=0 cellspacing="3" cellpadding="0">				  
				  <%for (int i = 0;i<10000; i++) { %>
					
					<%
						  
							if (i == listSize) break;
							CommentBean cBean = clist.get(i);
							String cname = cBean.getName();
							String comment = cBean.getComment();
						
							
					%>
					<tr align="center" >
						<td bgcolor="#D0D0D0" height="120%">이 름</td>
						<td align="center"><%=cname%></td>
						
					</tr>
					<tr align="center">	
					<td bgcolor="#D0D0D0" height="120%">내 용</td>
					<td align="center"><%=comment%></td>
					</tr>
					<%}//for%>
				</table>
				  





<form name="listFrm" method="post">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<%if(!(keyWord==null || keyWord.equals("null"))){ %>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>
</body>
</html>