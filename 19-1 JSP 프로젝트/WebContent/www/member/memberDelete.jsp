<%@ page contentType="text/html;charset=EUC-KR" %>
<%@page import="www.MemberBean"%>
<jsp:useBean id="mMgr" class="www.MemberMgr" />
<%
	String id = (String) session.getAttribute("idKey");
	MemberBean mBean = mMgr.getMember(id);
	String idval = mBean.getId();
%>
<html>
<head>
<title>회원가입</title>
<link href="style.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br /> <br />
		<form name="deleteFrm" method="post" action="memberDeleteProc.jsp">
		<table border="1" cellpadding="2" align="center" width="600">
		<tr><td colspan="3" align="center"><input type="submit" value="회원 탈퇴"> &nbsp; &nbsp;</td></tr>
		<tr><td>삭제할 아이디</td><td><input name="id" size="15" value="<%=idval%>" readonly></td></tr>
		</table>
		</form>
		 
	</div>
</body>
</html>