<%@ page import="java.util.Base64"%>
<%@page import="java.util.List"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page
	import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="com.dao.FishDao"%>
<%@page import="com.entities.Fish"%>
<%@page import="com.dao.AccessoriesDao"%>
<%@page import="com.entities.Accessories"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>The Aqua Infinity - Stock</title>
<link rel="stylesheet" href="css/customer.css" />
<link rel="stylesheet" href="css/index.css" />
<%@include file="all_css.jsp"%>
</head>
<body>

	<%@include file="utilities/sidebar.jsp"%>
	<section id="content">
		<%@include file="utilities/navbars.jsp"%>

		<main class="table">
			<section class="table_header">
				<h1>Fish Details</h1>
			</section>
			<section class="table_body">
				<table>
					<thead>
						<tr>
							<th>S.No</th>
							<th>Type</th>
							<th>Name</th>
							<th>Price</th>
							<th>In Stock</th>
							<th>Unit</th>
							<th>Image</th>
							<th>Operation</th>
						</tr>
					</thead>
					<tbody>
						<%
							ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
							FishDao fishDao = context.getBean("fishDao", FishDao.class);
							List<Fish> allfishes = fishDao.getAllFishes();
							int i=1;
							for (Fish  f: allfishes) {
							%>
						<tr>
							<td><%=i%></td>
							<td><%=f.getFishType()%></td>
							<td><%=f.getFishName()%></td>
							<td><%=f.getFishPrice()%></td>
							<td><%=f.getFishStock()%></td>
							<td><%=f.getFishUnit()%></td>
							<%
 									byte[] imageData = f.getFishImage();
									String base64Image=Base64.getEncoder().encodeToString(imageData);
								%>
							<td><img class="table-img"
								src="data:image/jpeg;base64,<%=base64Image%>" alt="" /></td>
							<td class="operation-btn"><a
								href="editFish.jsp?fish_id=<%=f.getFishId()%>" class="edit-btn">Edit</a>
								<a href="DeleteFishServlet?fish_id=<%=f.getFishId()%>"
								class="delete-btn">Delete</a></td>
						</tr>
						<%
							i++;
							}
							%>

					</tbody>
				</table>
			</section>
		</main>
		<main class="table">
			<section class="table_header">
				<h1>Accessories Details</h1>
			</section>
			<section class="table_body">
				<table>
					<thead>
						<tr>
							<th>S.No</th>
							<th>Category</th>
							<th>Name</th>
							<th>Price</th>
							<th>In Stock</th>
							<th>Unit</th>
							<th>Image</th>
							<th>Operation</th>
						</tr>
					</thead>
					<tbody>
						<%
							AccessoriesDao accessoriesDao = context.getBean("accessoriesDao", AccessoriesDao.class);
							List<Accessories> allaccessories = accessoriesDao.getAllAccessories();
							int j=1;
							for (Accessories  a: allaccessories) {
							%>
						<tr>
							<td><%=j%></td>
							<td><%=a.getProductCategory()%></td>
							<td><%=a.getProductName()%></td>
							<td><%=a.getProductPrice()%></td>
							<td><%=a.getProductStock()%></td>
							<td><%=a.getProductUnit()%></td>
							<%
 									byte[] imageData = a.getProductImage();
									String base64Image=Base64.getEncoder().encodeToString(imageData);
								%>
							<td><img class="table-img"
								src="data:image/jpeg;base64,<%=base64Image%>" alt="" /></td>
							<td class="operation-btn"><a
								href="editAccessories.jsp?product_id=<%=a.getProductId()%>"
								class="edit-btn">Edit</a> <a
								href="DeleteAccessoriesServlet?product_id=<%=a.getProductId()%>"
								class="delete-btn">Delete</a></td>
						</tr>
						<%
							j++;
							}
((ClassPathXmlApplicationContext) context).close();
							%>
					</tbody>
				</table>
			</section>
		</main>

	</section>

	<script src="js/script.js"></script>
</body>
</html>