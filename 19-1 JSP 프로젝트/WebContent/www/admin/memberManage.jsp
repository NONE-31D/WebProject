<%@ page contentType="text/html;charset=EUC-KR" %>
<%@page import="www.MemberBean"%>
<jsp:useBean id="mMgr" class="www.MemberMgr" />
<jsp:useBean id="bMgr" class="www.BoardMgr" />
<%
	String id = (String) session.getAttribute("idKey");
	MemberBean mBean = mMgr.getMember(id);
	String idval = mBean.getId();
%>
<html>
<head>
<title>ȸ������</title>
<link href="style.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br /> <br />
		
		<table border="1" cellpadding="2" align="center" width="600">
		<tr><td colspan="3" align="center"><a href="memberList.jsp"><input type="button" value="ȸ�� ��ȸ"></a></td></tr>
		<tr><td colspan="3" align="center"><a href="boardList.jsp"><input type="button" value="�Խñ� ��ȸ"></a></td></tr>
		</table>
		
		 
	</div>
</body>
</html>