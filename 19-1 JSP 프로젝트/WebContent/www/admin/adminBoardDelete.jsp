<%@ page contentType="text/html; charset=EUC-KR"%>
<html>
<head>
<%@page import="www.BoardBean"%>
<%
	 request.setCharacterEncoding("EUC-KR");
%>
<jsp:useBean id="bMgr" class="www.BoardMgr" />
<%
	  String nowPage = request.getParameter("nowPage");
	  int num = Integer.parseInt(request.getParameter("num"));
	    String inPass = request.getParameter("pass");
		BoardBean bBean = (BoardBean)session.getAttribute("bBean");
		String dbPass = bBean.getPass();
		bMgr.deleteBoard(num);
		String url = "BoardList.jsp?nowPage="+nowPage;
		//response.sendRedirect(url);
		
%>
		
</head>
<body bgcolor="#FFFFCC">
<div align="center">
<br><br>
<form name="delFrm" method="post" action="delete.jsp" >
<table width="70%" cellspacing="0" cellpadding="2">
 <tr>
  <td align="center">
   <table align="center" border="0" width=91%>
    <tr> 
     <td align="center">  
   	   	삭제되었습니다.
  	 </td> 
    </tr>
    <tr>
     <td><hr size="1" color="#eeeeee"></td>
    </tr>
    <tr>
     <td align="center">
      	<input type="button" value="뒤로" onClick="location.href='boardList.jsp'">
  	  </td>
    </tr> 
   </table>
  </td>
 </tr>
</table>
 <input type=hidden name="nowPage" value="<%=nowPage%>">
 <input type=hidden name="num" value="<%=num%>">
</form> 
</div>
</body>
</html>