<%@ page import="java.util.Base64"%>
<%@page import="java.util.List"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page
	import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="com.dao.FishOrderDao"%>
<%@page import="com.entities.FishOrder"%>
<%@page import="com.dao.AccessoriesOrderDao"%>
<%@page import="com.entities.AccessoriesOrder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>The Aqua Infinity - Orders</title>
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
				<h1>Fish Order</h1>
			</section>
			<section class="table_body">
				<table>
					<thead>
						<tr>
							<th>S.No</th>
							<th>Username</th>
							<th>Fish Name</th>
							<th>Quantity</th>
							<th>Price</th>
							<th>Total</th>
							<th>Ordered Date</th>
							<th>Delivered Status</th>
							<th>Change Status</th>
						</tr>
					</thead>
					<tbody>
						<%
							ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
							FishOrderDao fishOrderDao = context.getBean("fishOrderDao", FishOrderDao.class);
							List<FishOrder> allFishOrder = fishOrderDao.getAllFishOrders();
							int i=1;
							for (FishOrder  f: allFishOrder) {
							%>
						<tr>
							<td><%=i%></td>
							<td><%=f.getUsername()%></td>
							<td><%=f.getFishName()%></td>
							<td><%=f.getQuantity()%></td>
							<td><%=f.getPrice()%></td>
							<td><%=f.getTotal()%></td>
							<td><%=f.getOrderDate()%></td>
							<td><%=f.getDeliveredStatus()%></td>
							<td class="operation-btn"><a
								href="EditFishOrderServlet?order_id=<%=f.getOrderId()%>&status=Delivered"
								class="status edit-btn">Delivered</a> <a
								href="EditFishOrderServlet?order_id=<%=f.getOrderId()%>&status=Cancelled"
								class="status delete-btn">Cancelled</a></td>
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
				<h1>Accessories Order</h1>
			</section>
			<section class="table_body">
				<table>
					<thead>
						<tr>
							<th>S.No</th>
							<th>Username</th>
							<th>Fish Name</th>
							<th>Quantity</th>
							<th>Price</th>
							<th>Total</th>
							<th>Ordered Date</th>
							<th>Delivered Status</th>
							<th>Change Status</th>
						</tr>
					</thead>
					<tbody>
						<%
							ApplicationContext context1 = new ClassPathXmlApplicationContext("config.xml");
							AccessoriesOrderDao accessoriesOrderDao = context1.getBean("accessoriesOrderDao", AccessoriesOrderDao.class);
							List<AccessoriesOrder> allAccessoriesOrder = accessoriesOrderDao.getAllAccessoriesOrders();
							int j=1;
							for (AccessoriesOrder  a: allAccessoriesOrder) {
							%>
						<tr>
							<td><%=j%></td>

							<td><%=a.getUsername()%></td>
							<td><%=a.getProductName()%></td>
							<td><%=a.getQuantity()%></td>
							<td><%=a.getPrice()%></td>
							<td><%=a.getTotal()%></td>
							<td><%=a.getOrderDate()%></td>
							<td><%=a.getDeliveredStatus()%></td>
							<td class="operation-btn"><a
								href="EditAccessoriesOrderServlet?order_id=<%=a.getOrderId()%>&status=Delivered"
								class="status edit-btn">Delivered</a> <a
								href="EditAccessoriesOrderServlet?order_id=<%=a.getOrderId()%>&status=Cancelled"
								class="status delete-btn">Cancelled</a></td>
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