<%@ page import="java.util.Base64"%>
<%@page import="java.util.List"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page
	import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="com.dao.CheckoutDao"%>
<%@page import="com.entities.Checkout"%>
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
				<h1>Payment Status</h1>
			</section>
			<section class="table_body">
				<table>
					<thead>
						<tr>
							<th>S.No</th>
							<th>Customer Name</th>
							<th>Grand Total</th>
							<th>Payment Method</th>
						</tr>
					</thead>
					<tbody>
						<%
							ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
							CheckoutDao checkoutDao = context.getBean("checkoutDao", CheckoutDao.class);
							List<Checkout> checkout = checkoutDao.getAllCheckoutDetails();
							int i=1;
							for (Checkout  c: checkout) {
							%>
						<tr>
							<td><%=i%></td>
							<td><%=c.getCustomerName()%></td>
							<td><%=c.getGrandTotal()%></td>
							<%
							String status=c.getPaymentMethod();
							if(status.equals("cash")){
							%>
							<td><div class="cash"><%=c.getPaymentMethod()%></div></td>
							<%
							}else{%>
							<td ><div class="khalti"><%=c.getPaymentMethod()%></div></td>
							<%}%>
						</tr>
						<%
							i++;
							}
							%>

					</tbody>
				</table>
			</section>
		</main>


	</section>

	<script src="js/script.js"></script>
</body>
</html>