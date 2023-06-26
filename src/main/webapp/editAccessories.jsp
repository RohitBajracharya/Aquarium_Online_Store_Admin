<%@ page import="java.lang.Integer"%>
<%@page import="java.util.List"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page
	import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="com.dao.AccessoriesDao"%>
<%@page import="com.entities.Accessories"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>The Aqua Infinity - Accessories</title>
<link rel="stylesheet" href="css/fish&access.css" />
<%@include file="all_css.jsp"%>
</head>
<body>

	<%@include file="utilities/sidebar.jsp"%>
	<section id="content">
		<%@include file="utilities/navbars.jsp"%>
		<main>
			<h1 class="main-heading">Edit Accessories</h1>
			<%
				int productId=Integer.parseInt(request.getParameter("product_id").trim());
				ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
				AccessoriesDao accessoriesDao = context.getBean("accessoriesDao", AccessoriesDao.class);
				Accessories a = accessoriesDao.getAccessories(productId);
			%>
			<form action="EditAccessoriesServlet" method="post"
				enctype="multipart/form-data">
				<input value="<%=a.getProductId()%>" name="product-id" type="hidden" />
				<div class="form-group">
					<label for="product-category">Category:</label> <input type="text"
						id="product-category" name="product-category"
						value="<%=a.getProductCategory()%>" required />
				</div>
				<div class="form-group">
					<label for="product-name">Product Name:</label> <input type="text"
						id="product-name" name="product-name"
						value="<%=a.getProductName()%>" required />
				</div>
				<div class="form-group">
					<label for="product-price">Price:</label> <input type="text"
						id="product-price" name="product-price"
						value="<%=a.getProductPrice()%>" required />
				</div>
				<div class="form-group">
					<label for="product-quantity">In Stock:</label> <input type="text"
						id="product-quantity" name="product-quantity"
						value="<%=a.getProductStock()%>" required />
				</div>
				<div class="form-group">
					<label for="product-unit">Unit:</label> <input type="text"
						id="product-unit" name="product-unit"
						value="<%=a.getProductUnit()%>" required />
				</div>
				<div class="form-group">
					<label for="product-image">Image:</label> <input type="file"
						id="product-image" name="product-image" onchange="readURL(this)"
						accept="Image/*" required />
				</div>
				<div class="form-group">
					<button type="submit">Update Accessories</button>
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