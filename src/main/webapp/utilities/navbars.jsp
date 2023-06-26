<%
    String username = (String) session.getAttribute("username");
	System.out.println(username);
    if (username == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!-- NAVBAR -->

<nav>
	<i class="fa-solid fa-bars"></i> <a href="#" class="profile"> <img src="resources/logo/user.png" />
	</a>
</nav>
<!-- NAVBAR -->
