<%-- 
    Document   : admin
    Created on : Nov 14, 2021, 8:38:23 PM
    Author     : Mladen
--%>

<%@page import="java.util.Optional"%>
<%@page import="hr.algebra.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%User user = (User) session.getAttribute("user");%>
<!DOCTYPE html>
<html>
    <head class="bg-dark">
        <title>Admin page</title>
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
        <div id="wrapper" >

            <!-- Sidebar -->
            <div id="sidebar-wrapper">
                <ul class="sidebar-nav">
                    <li class="sidebar-brand" style="color: white">
                        <u>ADMIN</u>
                    </li>
                    <li>
                        <a href="storeItems.jsp">Store items</a>
                    </li>
                    <li>
                        <a href="userLoginHistory.jsp">User login history</a>
                    </li>
                    <li>
                        <a href="shoppingHistory">Shopping history</a>
                    </li>
                    <li>
                        <a href="homePage.jsp">Home</a>
                    </li>
                    <li>
                        <a href="logout" style="color: red;">Logout</a>
                    </li>
                </ul>
            </div>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
            <div id="page-content-wrapper" style="color: white">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <%if (user!=null) {
                            %>
                            <h1>Hello <u><%=user.getUsername()%></u>!</h1>
                            <%}%>
                            <p style="margin: 2.5em;"></p>
                            <p>This page is used to navigating to other pages where you have the power to add, update or delete items in the store and you can view the history of purchases of each customer.</p>
                            <p>Start by pressing the <code>toggle menu button</code> below and navigating to other sites.</p>
                            <a href="#menu-toggle" class="btn btn-danger" id="menu-toggle">Toggle Menu</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /#page-content-wrapper -->

        </div>
        <!-- /#wrapper -->
    </body>
</html>

<script>
    $("#menu-toggle").click(function (e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
</script>

