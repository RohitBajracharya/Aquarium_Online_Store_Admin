
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page
	import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.CustomerDao"%>
<%@page import="com.entities.Customer"%>
<%@page import="com.dao.FishDao"%>
<%@page import="com.dao.AccessoriesDao"%>
<%@page import="com.dao.FishOrderDao"%>
<%@page import="com.dao.CheckoutDao"%>
<%@page import="com.dao.AccessoriesOrderDao"%>
<%@page import="com.entities.Fish"%>
<%@page import="com.entities.FishOrder"%>
<%@page import="com.entities.AccessoriesOrder"%>
<%@page import="com.entities.Accessories"%>
<%@page import="com.entities.TopSoldFish"%>
<%@page import="com.entities.TopSoldAccessories"%>
<%@page import="com.entities.Checkout"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>The Aqua Infinity - Dashboard</title>
<link rel="stylesheet" href="css/index.css" />
<link rel="stylesheet" href="css/customer.css" />
<%@include file="all_css.jsp"%>
</head>
<body>
	<!-- sidebar -->
	<%@include file="utilities/sidebar.jsp"%>
	<section id="content">
		<!-- navbar -->
		<%@include file="utilities/navbars.jsp"%>
		<!-- main -->
		<main>
			<div class="head-title">
				<div class="left">
					<h1>Dashboard</h1>
				</div>
			</div>
			<%
							ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
							CustomerDao customerDao = context.getBean("customerDao", CustomerDao.class);
							int noOfCustomer = customerDao.countCustomers();
							CheckoutDao checkoutDao=context.getBean("checkoutDao",CheckoutDao.class);
							int noOfOrder=checkoutDao.countOrders();
							double revenue=checkoutDao.calculateGrandTotalSum();
							%>
			<ul class="box-info">
				<li><i class="fa-solid fa-cart-plus"></i> <span class="text">
						<h3><%=noOfOrder%></h3>
						<p>New Order</p>
				</span></li>
				<li><i class="fa-solid fa-user"></i> <span class="text">
						<h3><%=noOfCustomer%></h3>
						<p>Customers</p>
				</span></li>
				<li><i class="fa-solid fa-money-bill"></i> <span class="text">
						<h3>
							Rs
							<%=revenue%></h3>
						<p>Total Revenue</p>
				</span></li>
			</ul>
			<%
							((ClassPathXmlApplicationContext) context).close();
				%>
		</main>

		<main class="table">
			<section class="table-header">
				<h1>Recent Fish Orders</h1>
			</section>
			<section class="table_body">
				<table>
					<thead>
						<tr>
							<th>S.No</th>
							<th>User</th>
							<th>Product Name</th>
							<th>Quantity</th>
							<th>Order Date</th>
						</tr>
					</thead>
					<tbody>
						<%
							ApplicationContext context3 = new ClassPathXmlApplicationContext("config.xml");
							FishOrderDao fishOrderDao2 = context3.getBean("fishOrderDao", FishOrderDao.class);
							List<FishOrder> fishOrders = fishOrderDao2.getCheckoutFishDetails();
							int r=1;
System.out.println("orders:"+fishOrders);
							for(FishOrder fishOrder:fishOrders)	
							{
							%>
						<tr>
							<td><%=r%></td>
							<td>
								<p><%=fishOrder.getUsername()%></p>
							</td>
							<td>
								<p><%=fishOrder.getFishName()%></p>
							</td>
							<td>
								<p><%=fishOrder.getQuantity()%></p>
							</td>
							<td>
								<p><%=fishOrder.getOrderDate()%></p>
							</td>
						</tr>
						<%
							r++;
							}
							%>
					</tbody>
				</table>
			</section>
		</main>
		<main class="table">
			<section class="table-header">
				<h1>Recent Accessories Orders</h1>
			</section>
			<section class="table_body">
				<table>
					<thead>
						<tr>
							<th>S.No</th>
							<th>User</th>
							<th>Product Name</th>
							<th>Quantity</th>
							<th>Order Date</th>
						</tr>
					</thead>
					<tbody>
						<%
							ApplicationContext context4 = new ClassPathXmlApplicationContext("config.xml");
							AccessoriesOrderDao accessoriesOrderDao3 = context4.getBean("accessoriesOrderDao", AccessoriesOrderDao.class);
							List<AccessoriesOrder> accessoriesOrders1 = accessoriesOrderDao3.getCheckoutAccessoriesDetails();
							int s=1;
System.out.println("orders:"+fishOrders);
							for(AccessoriesOrder accessoriesOrder1:accessoriesOrders1)	
							{
							%>
						<tr>
							<td><%=s%></td>
							<td>
								<p><%=accessoriesOrder1.getUsername()%></p>
							</td>
							<td>
								<p><%=accessoriesOrder1.getProductName()%></p>
							</td>
							<td>
								<p><%=accessoriesOrder1.getQuantity()%></p>
							</td>
							<td>
								<p><%=accessoriesOrder1.getOrderDate()%></p>
							</td>
						</tr>
						<%
							s++;
							}
							%>
					</tbody>
				</table>
			</section>
		</main>
		<main>
			<div class="table-data">
				<div class="chart-container">
					<h1>Top 5 Sold Fish</h1>
					<canvas id="fishChart"></canvas>
				</div>
				<div class="chart-container">
					<h1>Top 5 Sold Accessories</h1>
					<canvas id="accessChart"></canvas>
				</div>
			</div>
			<!-- pie chart -->
		</main>
	</section>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
	<%	
		ApplicationContext context1=new ClassPathXmlApplicationContext("config.xml");
		FishOrderDao fishOrderDao=context1.getBean("fishOrderDao",FishOrderDao.class);
		List<TopSoldFish> topFishList=fishOrderDao.getTopFiveSoldFish();
		List<Object[]> data = new ArrayList<Object[]>();
		for (TopSoldFish topFish : topFishList) {
        	Object[] item = new Object[2];
        	item[0] = topFish.getFishName();
        	item[1] = topFish.getFishCount();
        	data.add(item);
    	}
	%>
	new Chart(document.getElementById("fishChart"), {
		type : "pie",
		data : {
			labels : [ <% for (int i = 0; i < data.size(); i++) { %>"<%=data.get(i)[0]%>"<% if (i < data.size() - 1) { %>, <% } } %>],
			datasets : [
					{
						backgroundColor : [ "#e63946", "#254BDD",
								"#ffbe0b", "#1d3557", "#326998", ],
						data : [ <% for (int i = 0; i < data.size(); i++) { %><%=data.get(i)[1]%><% if (i < data.size() - 1) { %>, <% } } %>],
					}, ],
		},
		options : {
			title : {
				display : true,
				text : "Pie Chart for admin panel",
			},
			responsive : true,
		},
	});
	
	<%
	ApplicationContext context2 = new ClassPathXmlApplicationContext("config.xml");
    AccessoriesOrderDao accessoriesOrderDao = context2.getBean("accessoriesOrderDao", AccessoriesOrderDao.class);
    List<TopSoldAccessories> topAccessoriesList = accessoriesOrderDao.getTopFiveSoldAccessories();
    List<Object[]> data1 = new ArrayList<Object[]>();
    for (TopSoldAccessories topAccessories : topAccessoriesList) {
        Object[] item1 = new Object[2];
        item1[0] = topAccessories.getProductName();
        item1[1] = topAccessories.getProductCount();
        data1.add(item1);
    }
%>
	

	new Chart(document.getElementById("accessChart"), {
		type : "pie",
		data : {
			labels : [ <% for (int j = 0; j < data1.size(); j++) { %>"<%=data1.get(j)[0]%>"<% if (j < data1.size() - 1) { %>, <% } } %>],
			datasets : [
					{
						backgroundColor : [ "#e63946", "#254BDD",
								"#ffbe0b", "#1d3557", "#326998", ],
						data : [ <% for (int i = 0; i < data1.size(); i++) { %><%=data1.get(i)[1]%><% if (i < data1.size() - 1) { %>, <% } } %>],
					}, ],
		},
		options : {
			title : {
				display : true,
				text : "Pie Chart for admin panel",
			},
			responsive : true,
		},
	});
	</script>

	<script src="js/script.js"></script>
</body>
</html>