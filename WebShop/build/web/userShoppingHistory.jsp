<%-- 
    Document   : userShoppingHistory
    Created on : Jan 30, 2022, 10:17:25 PM
    Author     : Mladen
--%>

<%@page import="hr.algebra.models.UserShoppingHistoryItem"%>
<%@page import="hr.algebra.models.Item"%>
<%@page import="hr.algebra.repository.SqlRepository"%>
<%@page import="hr.algebra.repository.Repository"%>
<%@page import="hr.algebra.models.Bill"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%List<UserShoppingHistoryItem> shoppingHistory = (List<UserShoppingHistoryItem>)session.getAttribute("completeShoppingHistoryList");%>
<%Repository repo = new SqlRepository();%>
<!DOCTYPE html>
<html>
    <head>
    <head class="bg-dark">
        <title>Shopping history </title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

        <link href="style/admin.css" rel="stylesheet" type="text/css"/>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    </head>
    <body class="bg-dark">
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="homePage.jsp">Indumentum</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="nav navbar-nav navbar-right">
                    <li class="nav-item">
                        <a class="nav-link" id="btnAdmin" href="admin.jsp">Admin</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- NAVBAR END-->
        <h1 style="text-align: center; color: white; margin: 0;" class="bg-dark">Shopping history - bills</h1>

        <div id="page-content-wrapper" style="color: white">
            <div class="container">
                <table class="table table-bordered table-light table-hover table-striped" style="text-align: center;">
                <tr>
                    <td><b>PURCHASED ITEM</b></td>
                    <td><b>TIME OF PURCHASE</b></td>
                    <td><b>PAYMENT METHOD</b></td>
                    <td><b>BILL ID</b></td>
                    <td><b>USER</b></td>
                </tr>
                <%if (shoppingHistory.size() != 0) {
                    for (UserShoppingHistoryItem item : shoppingHistory) {
                         
                %>
                <tr>
                    <td><%=repo.getItemsById(item.getItemId())%></td>
                    <td><%=item.getDateOdPurchase()%></td>
                    <td><%=item.getPaymentMethod()%></td>
                    <td><%=item.getBillId()%></td>
                    <td><%=repo.getUserById(item.getAppUserId())%></td>
                </tr>
                <%}
                    } else {%>
                    <h1>No data in Database!</h1>
                    <%}%>
            </table>
            </div>
        </div>
    </body>
</html>
