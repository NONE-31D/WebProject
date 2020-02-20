<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="cMgr" class="www.CommentMgr"/>
<%
	cMgr.insertComment(request);
	//String url = //.jsp?nowPage="+nowPage;
	response.sendRedirect("../board/list.jsp?nowPage=1");
%>