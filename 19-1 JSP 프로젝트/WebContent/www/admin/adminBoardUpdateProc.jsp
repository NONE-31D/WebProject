<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="bMgr" class="www.BoardMgr" />
<jsp:useBean id="bBean" class="www.BoardBean" scope="session"/>
<jsp:useBean id="upBean" class="www.BoardBean"/>
<jsp:setProperty property="*" name="upBean"/>
<%
	  String nowPage = request.getParameter("nowPage");
	  
	    bMgr.updateBoard(upBean);
		String url = "boardList.jsp";
		response.sendRedirect(url);
	  %>