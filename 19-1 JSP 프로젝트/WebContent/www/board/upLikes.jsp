<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="bMgr" class="www.BoardMgr" />
<jsp:useBean id="bBean" class="www.BoardBean" scope="session"/>
<jsp:useBean id="upBean" class="www.BoardBean"/>
<%
		int num = Integer.parseInt(request.getParameter("num"));
		bMgr.upLikes(num);
		
%>


<form name="readFrm" method="get">
<input type="hidden" name="num" value=<%=num %>>
</form>
	
<script>
alert("공감하셨습니다.")
history.go(-1);
</script>