
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
		<!-- MAIN -->
		<main>
			<h1 class="main-heading">Add Accessories</h1>
			<form action="AccessoriesServlet" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="product-category">Category:</label> <input type="text"
						id="Category" name="product-category" required />
				</div>
				<div class="form-group">
					<label for="product-name">Product Name: </label> <input type="text"
						id="product-name" name="product-name" required />
				</div>
				<div class="form-group">
					<label for="product-price">Price:</label> <input type="text"
						id="product-price" name="product-price" required />
				</div>
				<div class="form-group">
					<label for="product-quantity">In Stock:</label> <input type="text"
						id="product-quantity" name="product-quantity" required />
				</div>
				<div class="form-group">
					<label for="product-unit">Unit:</label> <input type="text"
						id="product-unit" name="product-unit" required />
				</div>
				<div class="form-group">
					<label for="product-image">Image:</label> <input type="file"
						id="product-image" name="product-image" onchange="readURL(this)"
						accept="Image/*" required />
				</div>
				<div class="form-group">
					<button type="submit">Add Accessories</button>
				</div>
			</form>
		</main>
	</section>

	<script src="js/script.js"></script>
</body>
</html>