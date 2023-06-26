<%@ page import="java.lang.Integer"%>
<%@page import="java.util.List"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page
	import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="com.dao.FishDao"%>
<%@page import="com.entities.Fish"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>The Aqua Infinity - Fish</title>
<link rel="stylesheet" href="css/fish&access.css" />
<%@include file="all_css.jsp"%>
</head>
<body>

	<%@include file="utilities/sidebar.jsp"%>
	<section id="content">
		<%@include file="utilities/navbars.jsp"%>
		<main>
			<h1 class="main-heading">Edit Fish</h1>
			<%
				int fishId=Integer.parseInt(request.getParameter("fish_id").trim());
				ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
				FishDao fishDao = context.getBean("fishDao", FishDao.class);
				Fish f = fishDao.getFish(fishId);
			%>
			<form action="EditFishServlet" method="post"
				enctype="multipart/form-data">
				<input value="<%=f.getFishId()%>" name="fish-id" type="hidden" />
				<div class="form-group">
					<label for="fish-type">Fish Type:</label> <input type="text"
						id="fish-type" name="fish-type" value="<%=f.getFishType()%>"
						required />
				</div>
				<div class="form-group">
					<label for="fish-name">Fish Name:</label> <input type="text"
						id="fish-name" name="fish-name" value="<%=f.getFishName()%>"
						required />
				</div>
				<div class="form-group">
					<label for="fish-price">Price:</label> <input type="text"
						id="fish-price" name="fish-price" value="<%=f.getFishPrice()%>"
						required />
				</div>
				<div class="form-group">
					<label for="fish-quantity">In Stock:</label> <input type="text"
						id="fish-quantity" name="fish-quantity"
						value="<%=f.getFishStock()%>" required />
				</div>
				<div class="form-group">
					<label for="fish-unit">In Stock:</label> <input type="text"
						id="fish-unit" name="fish-unit"
						value="<%=f.getFishUnit()%>" required />
				</div>
				<div class="form-group">
					<label for="fish-image">Image:</label> <input type="file"
						id="fish-image" name="fish-image" onchange="readURL(this)"
						accept="Image/*" required />
				</div>
				<div class="form-group">
					<button type="submit">Update Fish</button>
				</div>
			</form>
			<%
((ClassPathXmlApplicationContext) context).close();
			%>
		</main>
	</section>

	<script src="js/script.js"></script>
</body>
</html>