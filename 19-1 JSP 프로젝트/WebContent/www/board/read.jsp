
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
	  bMgr.upCount(num);//��ȸ�� ����
	  BoardBean bBean = bMgr.getBoard(num);//�Խù� ��������
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
	  int totalRecord=0; //��ü���ڵ��
	  int numPerPage=10; // �������� ���ڵ� �� 
	  int pagePerBlock=15;  //���� �������� 
	  
	  int totalPage=0; //��ü ������ ��
	  int totalBlock=0;  //��ü ���� 

	  int nowCommentPage=1; // ����������
	  int nowBlock=1;  //�����
	  
	  int start=0; //����� select ���۹�ȣ
	  int end=10; //���۹�ȣ�� ���� ������ select ����
	  int like=0;
	  int listSize= cMgr.getTotalCount(); //���� �о�� �Խù��� ��
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
  <td bgcolor="#9CA2EE" height="25" align="center">���б�</td>
 </tr>
 <tr>
  <td colspan="2">
   <table border="0" cellpadding="3" cellspacing="0" width=100%> 
    <tr> 
  <td align="center" bgcolor="#DDDDDD" width="10%"> �� �� </td>
  <td bgcolor="#FFFFE8"><%=name%></td>
  <td align="center" bgcolor="#DDDDDD" width=10%> ��ϳ�¥ </td>
  <td bgcolor="#FFFFE8"><%=regdate%></td>
 </tr>
 <tr> 
    <td align="center" bgcolor="#DDDDDD"> �� ��</td>
    <td bgcolor="#FFFFE8" colspan="3"><%=subject%></td>
   </tr>
   <tr>
   <td align="center" bgcolor="#DDDDDD" width="10%"> ������ </td>
  <td bgcolor="#FFFFE8"><%=likes%></td>
  <td align="center" bgcolor="#DDDDDD" width=10%> ���� </td>
  <td bgcolor="#FFFFE8">
  <button id="button1" onclick="location.href='upLikes.jsp?num=<%=num%>'">�����ϱ�</button>
  
  </td>
   
    </tr>
   <tr> 
     <td align="center" bgcolor="#DDDDDD">÷������</td>
     <td bgcolor="#FFFFE8" colspan="3">
     <% if( filename !=null && !filename.equals("")) {%>
  		<a href="javascript:down('<%=filename%>')"><%=filename%></a>
  		 &nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)</font>  
  		 <%} else{%> ��ϵ� ������ �����ϴ�.<%}%>
     </td>
   </tr>
   <tr> 
    <td colspan="4"><br><pre><%=content%></pre><br></td>
   </tr>
   <tr>
    <td colspan="4" align="right">
     <%=ip%>�� ���� ���� ����̽��ϴ�./  ��ȸ��  <%=count%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align="center" colspan="2"> 
 <hr size="1">
 [ <a href="javascript:list()" >����Ʈ</a> | 
 <a href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>" >�� ��</a> |
 <a href="reply.jsp?nowPage=<%=nowPage%>" >�� ��</a> |
 <a href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">�� ��</a> ]<br>
  </td>
 </tr>
</table>

<form name="downFrm" action="download.jsp" method="post">
	<input type="hidden" name="filename">
</form>

<% //���
				  clist = cMgr.getCommentList(num);
				  listSize = clist.size();//������ ȭ�鿡 ������ �Խù�����
				  %>
				  
				  
				  <form name="CommentFrm" method="post" action="../comment/insertComment.jsp" enctype="multipart/form-data">
				  	<table align="center" width="70%" border=0 cellspacing="3" cellpadding="0">
				  	<tr>
				  	<td colspan = 2 align="center" bgcolor="#D0D0D0" height="120%">��� ����</td>
				  	</tr>
				  		<tr >
						<td align="center">�� ��</td>
						<td ><input type="text" name="cname" size="10" maxlength="8"></td>
						</tr>
						<tr>	
						<td align="center" >�� ��</td>
						<td ><input type="text" name="comment"></td>
						</tr>
						<tr>	
						<td align="center" >��й�ȣ</td>
						<td ><input type="text" name="pass"><input type="hidden" name="bnum" value=<%=num %>></td>
						</tr>
						<tr>
						<td colspan = 2 align="center" ><input type="submit" value="��۾���"></td>
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
						<td bgcolor="#D0D0D0" height="120%">�� ��</td>
						<td align="center"><%=cname%></td>
						
					</tr>
					<tr align="center">	
					<td bgcolor="#D0D0D0" height="120%">�� ��</td>
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