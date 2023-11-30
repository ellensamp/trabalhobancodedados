<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Resultado</title>
</head>
<body>
    <%
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        boolean loginSucesso = false;

        try {
            Class.forName("org.hsqldb.jdbc.JDBCDriver");
            Connection connection = DriverManager.getConnection("jdbc:hsqldb:hsql://localhost/banco", "SA", "");

            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM usuarios WHERE email=? AND senha=?");
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, senha);

            ResultSet resultSet = preparedStatement.executeQuery();
            loginSucesso = resultSet.next();

            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <h2>Resultado do Login</h2>
    <% if (loginSucesso) { %>
        <p>Login bem-sucedido! Bem-vindo, <%= email %>.</p>
    <% } else { %>
        <p>Login falhou. Verifique seu email e senha.</p>
    <% } %>
</body>
</html>
