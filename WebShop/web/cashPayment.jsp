<%-- 
    Document   : cashPayment
    Created on : Jan 17, 2022, 5:15:25 PM
    Author     : Mladen
--%>

<%@page import="hr.algebra.models.Bill"%>
<%@page import="hr.algebra.models.User"%>
<%@page import="hr.algebra.models.Item"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%List<Item> cartItems = (List<Item>) (session.getAttribute("cartItems"));%>
<%String total = (String) session.getAttribute("total");%>
<%User user = (User) session.getAttribute("user");%>
<%Bill bill = (Bill) session.getAttribute("bill");%>
<!DOCTYPE html>
<html>
    <head>
        <title>Checkout</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="refresh" content="8; url=http://localhost:8080/WebShop/index.jsp">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="style/background.css" rel="stylesheet" type="text/css"/> 
    </head>
    <body class="bg-dark">
        <div class="container" style="margin-top: 2em;">
            <h1 style="text-align: center; color: red;">Thank you for shopping with us!</h1>
            <hr>
            <h3 style="text-align: center; color: white;">Your order with the total of $<%=total%> will arrive at your address (<%=user.getAddress()%>) in 3-5 business days.</h3>
            <h3 style="text-align: center; color: white;">You will be redirected to our home page shortly.</h3>
            <h3 style="text-align: center; color: white;">Have a nice day :)</h3>
        </div>
    </body>
</html>
