<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<%@ page import="www.BoardBean"%>
<jsp:useBean id="bMgr" class="www.BoardMgr" />

<jsp:useBean id="upBean" class="www.BoardBean"/>
<jsp:setProperty property="*" name="upBean"/>

<%		
//int nowPage = Integer.parseInt(request.getParameter("nowPage"));
int num = Integer.parseInt(request.getParameter("num"));
String  pass = request.getParameter("pass");
		BoardBean bBean = bMgr.getBoard(num);
	  String nowPage = request.getParameter("nowPage");
	  //bean�� �ִ� pass�� upBean pass�� ��(read.jsp)
	  
	  String inPass = bBean.getPass();
	  if(pass.equals( bBean.getPass())){
	    bMgr.updateBoard(upBean);
		String url = "read.jsp?nowPage="+nowPage+"&num="+num;
		response.sendRedirect(url);
	  }else{
%>
	<script type="text/javascript">
	alert(<%=pass%>)
		alert("�Է��Ͻ� ��й�ȣ�� �ƴմϴ�.");
		history.back();
	</script>
<%}%>