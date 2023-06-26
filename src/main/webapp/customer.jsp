<%@page import="org.springframework.context.ApplicationContext"%>
<%@page
	import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.CustomerDao"%>
<%@page import="com.entities.Customer"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>The Aqua Infinity - Customer</title>
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
				<h1>Customers Details</h1>
			</section>
			<section class="table_body">
			<table>
						<thead>
							<tr>
								<th>S.No</th>
								<th>Name</th>
								<th>Email</th>
								<th>Phone Number</th>
								<th>Operation</th>
							</tr>
						</thead>
						<tbody>
							<%
							ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
							CustomerDao customerDao = context.getBean("customerDao", CustomerDao.class);
							List<Customer> allCustomers = customerDao.getAllCustomers();
							int i=1;
							for (Customer  c: allCustomers) {
							%>
							<tr>
								<td><%=i%></td>
								<td><%=c.getUsername()%></td>
								<td><%=c.getEmail()%></td>
								<td><%=c.getPhoneNo()%></td>
								<td class="operation-btn"><a
									href="DeleteCustomerServlet?customer_id=<%=c.getCustomerId()%>"
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

	</section>

	<script src="js/script.js"></script>
</body>
</html>