<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - Login</title>
    <link rel="stylesheet" href="css/login.css" />
  </head>
  <body>
    <div class="login-container">
      <img
        src="resources/logo/logo.png"
        alt="Avatar"
        style="border-radius: 50%"
      />
      <h1>Login</h1>
      <form action="UserServlet" method="post" enctype="multipart/form-data">
      <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
        <div class="message" style="color: red;"><%= errorMessage %></div>
        <% } %>
        <% String loginMessage = (String) request.getAttribute("loginMessage"); %>
        <% if (loginMessage != null) { %>
        <div class="message" style="color: red;"><%= loginMessage %></div>
        <% } %>
        <div class="input-container">
          <input
            type="text"
            id="username"
            name="username"
            placeholder="Username"
            required
          />
        </div>
        <div class="input-container">
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Password"
            required
          />
          
        </div>
        <button type="submit">Login</button>
      </form>
    </div>
  </body>
</html>
