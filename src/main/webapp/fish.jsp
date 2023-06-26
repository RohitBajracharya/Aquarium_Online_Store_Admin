
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>The Aqua Infinity - Fish</title>
<link rel="stylesheet" href="css/fish&access.css" />
<%@include file="all_css.jsp"%>
</head>
<body>

	<%@include file="utilities/sidebar.jsp" %>
	<section id="content">
		<%@include file="utilities/navbars.jsp"%>
		<main>
			<h1 class="main-heading">Add Fish</h1>
			<form action="FishServlet" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="fish-type">Fish Type:</label> <input type="text"
						id="fish-type" name="fish-type" required />
				</div>
				<div class="form-group">
					<label for="fish-name">Fish Name:</label> <input type="text"
						id="fish-name" name="fish-name" required />
				</div>
				<div class="form-group">
					<label for="fish-price">Price:</label> <input type="text"
						id="fish-price" name="fish-price" required />
				</div>
				<div class="form-group">
					<label for="fish-quantity">In Stock:</label> <input type="text"
						id="fish-quantity" name="fish-quantity" required />
				</div>
				<div class="form-group">
					<label for="fish-unit">Unit:</label> <input type="text"
						id="fish-unit" name="fish-unit" required />
				</div>
				<div class="form-group">
					<label for="fish-image">Image:</label> <input type="file"
						id="fish-image" name="fish-image" onchange="readURL(this)"
						accept="Image/*" required />
				</div>
				<div class="form-group">
					<button type="submit" class="edit-btn">Add Fish</button>
				</div>
			</form>
		</main>
	</section>

	<script src="js/script.js"></script>
</body>
</html>