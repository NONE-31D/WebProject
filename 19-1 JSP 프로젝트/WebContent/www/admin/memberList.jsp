<%@ page contentType="text/html;charset=EUC-KR" %>
<%@page import="www.MemberBean, java.util.*"%>
<jsp:useBean id="mMgr" class="www.MemberMgr" />
<%	
	  int totalRecord=0; //��ü���ڵ��
	  int numPerPage=10; // �������� ���ڵ� �� 
	  int pagePerBlock=15;  //���� �������� 
	  
	  int totalPage=0; //��ü ������ ��
	  int totalBlock=0;  //��ü ���� 

	  int nowPage=1; // ����������
	  int nowBlock=1;  //�����
	  
	  int start=0; //����� select ���۹�ȣ
	  int end=10; //���۹�ȣ�� ���� ������ select ����
	  
	  int listSize=0; //���� �о�� �Խù��� ��

	Vector<MemberBean> vlist = null;
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	 start=(nowPage * numPerPage)-numPerPage;
	 end= start+numPerPage;
	 
	totalRecord = mMgr.getTotalCount();
	totalPage =(int)Math.ceil((double)totalRecord / numPerPage);  //��ü��������
	nowBlock= (int)Math.ceil((double)nowPage/pagePerBlock); //����� ���
	  
	totalBlock =(int)Math.ceil((double)totalPage / pagePerBlock);  //��ü�����
%>
<html>
<head>
<title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list() {
		document.listFrm.action = "../member/memberList.jsp";
		document.listFrm.submit();
	}
	
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(value){
		 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
		 document.readFrm.submit();
	} 
	
	function read(num){
		document.readFrm.num.value=num;
		document.readFrm.action="read.jsp";
		document.readFrm.submit();
	}
	
</script>
</head>
<body bgcolor="#FFFFCC">
<div align="center">
	<br/>
	<h2>ȸ�� ����Ʈ</h2>
	<br>
	<table align="center" border="0" width="80%">
			<tr>
				<td>Total : <%=totalRecord%>Articles(<font color="red">
				<%=nowPage%>/<%=totalPage%>Pages</font>)</td>
			</tr>
	</table>
	<table align="center" width="80%" border="0" cellspacing="0" cellpadding="3">
		<tr>
			<td align="center" colspan="2">
			<%
				  vlist = mMgr.getMemberList(start, end);
				  listSize = vlist.size();//������ ȭ�鿡 ������ �Խù�����
				  if (vlist.isEmpty()) {
					out.println("��ϵ� ȸ���� �����ϴ�.");
				  } else {
			%>
				  <table border="0" width="100%" cellpadding="2" cellspacing="0">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>�� ��</td>
						<td>���̵�</td>
						<td>��й�ȣ</td>
						<td>�� ��</td>
						<td>�� ��</td>
						<td>�� ��</td>
						<td>�̸���</td>
						<td>�����ȣ</td>
						<td>�ּ�</td>
						<td>���</td>
						<td>����</td>
						<td>��������</td>
						<td>ȸ��Ż��</td>
					</tr>
					<%
						  for (int i = 0;i<numPerPage; i++) {
							if (i == listSize) break;
							MemberBean mBean = vlist.get(i);
							String id = mBean.getId();
							String pwd = mBean.getPwd();
							String name = mBean.getName();
							String gender = mBean.getGender();
							String birthday = mBean.getBirthday();
							String email = mBean.getEmail();
							String zipcode = mBean.getZipcode();
							String address = mBean.getAddress();
							String hobby = "";//mBean.getHobby();
							String job = mBean.getJob();
							String update = "";
							String delete = "";
							
					%>
					<tr>
						<td align="center">
							<%=i+((nowPage-1)*numPerPage+1)%>
						</td>
						<td align="center"><%=id%></td>
						<td align="center"><%=pwd%></td>
						<td align="center"><%=name%></td>
						<td align="center"><%=gender%></td>
						<td align="center"><%=birthday%></td>
						<td align="center"><%=email%></td>
						<td align="center"><%=zipcode%></td>
						<td align="center"><%=address%></td>
						<td align="center">
						<%
						String[] hob = mBean.getHobby();
						String list[] = { "���ͳ�", "����", "����", "��ȭ", "�" };
						for(int j=0;j<5;j++){
							//out.print(hob[j]);
							if(hob[j].equals("1")) out.print(list[j]);
							out.print(" ");
						}
						
						%>
						</td>
						<td align="center"><%=job%></td>
						<td align="center"><form name="updateFrm" method="post" action="../member/memberUpdate.jsp">
						<input type="submit" value="����">
						<input type="hidden" name=id value=<%=id%>>
						</form></td>
						<td align="center"><form name="deleteFrm" method="post" action="../member/memberDeleteProc.jsp">
						<input type="submit" value="����">
						<input type="hidden" name=id value=<%=id%>>
						</form></td>
						</tr>
					<%}//for%>
				</table> <%
 			}//if
 		%>
			</td>
		</tr>
		<tr>
			<td colspan="2"><br /><br /></td>
		</tr>
		<tr>
			<td>
			<!-- ����¡ �� �� ó�� Start--> 
			<%
   				  int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //�ϴ� ������ ���۹�ȣ
   				  int pageEnd = ((pageStart + pagePerBlock ) < totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
   				  //�ϴ� ������ ����ȣ
   				  if(totalPage !=0){
    			  	if (nowBlock > 1) {%>
    			  		<a href="javascript:block('<%=nowBlock-1%>')">prev...</a><%}%>&nbsp; 
    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>
     			     	<a href="javascript:pageing('<%=pageStart %>')"> 
     					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
     					[<%=pageStart %>] 
     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
    					<%}//for%>&nbsp; 
    					<%if (totalBlock > nowBlock ) {%>
    					<a href="javascript:block('<%=nowBlock+1%>')">.....next</a>
    				<%}%>&nbsp;  
   				<%}%>
 				<!-- ����¡ �� �� ó�� End-->
				</td>
			</tr>
		</table>
	<hr width="80%"/>
	<form  name="searchFrm"  method="post" action="list.jsp">
	<table border="0" width="527" align="center" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<select name="keyField" size="1" >
    				<option value="name"> �� ��</option>
    				<option value="subject"> �� ��</option>
    				<option value="content"> �� ��</option>
   				</select>
   				<input type="text" size="16" name="keyWord">
   				<input type="button"  value="ã��" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
  			</td>
 		</tr>
	</table>
	</form>
	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>
	<form name="readFrm" method="get">
		<input type="hidden" name="num"> 
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		
	</form>
</div>
</body>
</html>