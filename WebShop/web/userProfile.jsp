<%-- 
    Document   : userProfile
    Created on : Jan 4, 2022, 12:41:56 PM
    Author     : Mladen
--%>

<%@page import="hr.algebra.models.UserShoppingHistoryItem"%>
<%@page import="hr.algebra.models.Item"%>
<%@page import="hr.algebra.repository.Repository"%>
<%@page import="hr.algebra.repository.SqlRepository"%>
<%@page import="hr.algebra.models.LoginHistory"%>
<%@page import="java.util.List"%>
<%@page import="hr.algebra.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%User user = (User) session.getAttribute("user");%>
<%Repository repo = new SqlRepository();%>
<%List<UserShoppingHistoryItem> userBillList =(List<UserShoppingHistoryItem>) session.getAttribute("userBillList");%>
<!DOCTYPE html>
<html class="bg-dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        
    </head>
    <body class="bg-dark">
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg navbar-dark ">
            <a class="navbar-brand" href="homePage.jsp" style="color: white;">Indumentum</a>

            <li class="nav navbar-nav navbar-right">
                <a class="btn btn-outline-danger" href="logout">Logout</a>
            </li>

        </nav>
        <!-- NAVBAR END-->

        <h1 style="text-align: center; color: white; margin: 0;" >Welcome back <%=user.getUsername()%></h1>
        <p></p>
        <div class="container">
            <table class="table table-bordered table-light table-hover table-striped" style="text-align: center;">
                <tr>
                    <td><b>PURCHASED ITEM</b></td>
                    <td><b>TIME OF PURCHASE</b></td>
                    <td><b>PAYMENT METHOD</b></td>
                    <td><b>BILL ID</b></td>
                    <td><b>TOTAL</b></td>
                </tr>
                <%if (userBillList.size() != 0) {
                    for (UserShoppingHistoryItem item : userBillList) {
                         
                %>
                <tr>
                    <td><%=repo.getItemsById(item.getItemId())%></td>
                    <td><%=item.getDateOdPurchase()%></td>
                    <td><%=item.getPaymentMethod()%></td>
                    <td><%=item.getBillId()%></td>
                    <td>$<%=item.getTotal()%></td>
                </tr>
                <%}
                    } else {%>
                    <h1>No data in Database!</h1>
                    <%}%>
            </table>
        </div>
    </body>
</html>
