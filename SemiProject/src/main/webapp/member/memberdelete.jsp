<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
	String mnum = request.getParameter("mnum");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String password = request.getParameter("password");

	System.out.println(mnum);
	System.out.println(name);
	System.out.println(email);
	System.out.println(password);
	
	MemberDao dao = new MemberDao();
	
	boolean b = dao.ismemNameEmailPass(name, email, password);
			
	if(b){
		dao.deleteMember(mnum);
		
		session.removeAttribute("loginok");	
		response.sendRedirect("../index.jsp?boramMain=layout/main.jsp");
	}else{%>
		<script type="text/javascript">
			alert("계정정보가 맞지 않습니다");
			history.back();
		</script>
	<%}
%>
</body>
</html>