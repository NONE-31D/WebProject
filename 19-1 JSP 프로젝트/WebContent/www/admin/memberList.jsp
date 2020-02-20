<%@ page contentType="text/html;charset=EUC-KR" %>
<%@page import="www.MemberBean, java.util.*"%>
<jsp:useBean id="mMgr" class="www.MemberMgr" />
<%	
	  int totalRecord=0; //전체레코드수
	  int numPerPage=10; // 페이지당 레코드 수 
	  int pagePerBlock=15;  //블럭당 페이지수 
	  
	  int totalPage=0; //전체 페이지 수
	  int totalBlock=0;  //전체 블럭수 

	  int nowPage=1; // 현재페이지
	  int nowBlock=1;  //현재블럭
	  
	  int start=0; //디비의 select 시작번호
	  int end=10; //시작번호로 부터 가져올 select 갯수
	  
	  int listSize=0; //현재 읽어온 게시물의 수

	Vector<MemberBean> vlist = null;
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	 start=(nowPage * numPerPage)-numPerPage;
	 end= start+numPerPage;
	 
	totalRecord = mMgr.getTotalCount();
	totalPage =(int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock= (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	  
	totalBlock =(int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
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
	<h2>회원 리스트</h2>
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
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("등록된 회원이 없습니다.");
				  } else {
			%>
				  <table border="0" width="100%" cellpadding="2" cellspacing="0">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>순 번</td>
						<td>아이디</td>
						<td>비밀번호</td>
						<td>이 름</td>
						<td>성 별</td>
						<td>생 일</td>
						<td>이메일</td>
						<td>우편번호</td>
						<td>주소</td>
						<td>취미</td>
						<td>직업</td>
						<td>정보수정</td>
						<td>회원탈퇴</td>
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
						String list[] = { "인터넷", "여행", "게임", "영화", "운동" };
						for(int j=0;j<5;j++){
							//out.print(hob[j]);
							if(hob[j].equals("1")) out.print(list[j]);
							out.print(" ");
						}
						
						%>
						</td>
						<td align="center"><%=job%></td>
						<td align="center"><form name="updateFrm" method="post" action="../member/memberUpdate.jsp">
						<input type="submit" value="수정">
						<input type="hidden" name=id value=<%=id%>>
						</form></td>
						<td align="center"><form name="deleteFrm" method="post" action="../member/memberDeleteProc.jsp">
						<input type="submit" value="삭제">
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
			<!-- 페이징 및 블럭 처리 Start--> 
			<%
   				  int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
   				  int pageEnd = ((pageStart + pagePerBlock ) < totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
   				  //하단 페이지 끝번호
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
 				<!-- 페이징 및 블럭 처리 End-->
				</td>
			</tr>
		</table>
	<hr width="80%"/>
	<form  name="searchFrm"  method="post" action="list.jsp">
	<table border="0" width="527" align="center" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<select name="keyField" size="1" >
    				<option value="name"> 이 름</option>
    				<option value="subject"> 제 목</option>
    				<option value="content"> 내 용</option>
   				</select>
   				<input type="text" size="16" name="keyWord">
   				<input type="button"  value="찾기" onClick="javascript:check()">
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