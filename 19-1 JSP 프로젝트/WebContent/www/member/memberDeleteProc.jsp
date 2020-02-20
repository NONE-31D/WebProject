<%@ page contentType="text/html; charset=EUC-KR" %>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mMgr" class="www.MemberMgr"/>
<jsp:useBean id="mBean" class="www.MemberBean"/>
<jsp:setProperty  name="mBean" property="*"/>
<%
String currId = (String) session.getAttribute("idKey");
String id = mBean.getId();
if(id.equals("admin")){
	%>
	<script type="text/javascript">
			alert("운영자 계정은 삭제할 수 없습니다.");
			history.back();
	</script>
	<%
}
else{
	boolean result = mMgr.deleteMember(mBean);
	  
	  
	 if(result){
%>
<script type="text/javascript">
		alert("회원 탈퇴에 성공하셨습니다.");</script>
<%
if(!currId.equals("admin")) session.invalidate(); 

%>
<script>
top.document.location.reload(); 
location.href="<%=request.getContextPath()%>/www/left.jsp";
</script>

<%}else{%>
<script type="text/javascript">
		alert(<%=id%> + "회원 탈퇴에 실패 하였습니다.");
		history.back();
</script>
<%} 
}%>