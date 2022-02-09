<%-- 
    Document   : homePage
    Created on : Nov 12, 2021, 10:20:39 PM
    Author     : Mladen
--%>
<%@page import="hr.algebra.models.Category"%>
<%@page import="java.util.List"%>
<%@page import="hr.algebra.models.Item"%>
<%@page import="java.util.Optional"%>
<%@page import="hr.algebra.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%User user = (User) session.getAttribute("user");%>
<%List<Category> categories = (List<Category>) (session.getAttribute("categories"));%>
<% List<Item> jackets = (List<Item>) (session.getAttribute("Jackets"));%>
<!doctype html>
<html lang="en" >
    <head>
        <title>Indumentum shop</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="style/background.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg navbar-dark ">
            <a class="navbar-brand" href="homePage.jsp">Indumentum</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <%for (Category c : categories) {%>
                            <a class="dropdown-item" href="<%=c.getTitle().toLowerCase()%>"><%=c.getTitle()%></a>
                            <%}%>
                        </div>
                    </li>
                    <%if (user == null) {%>
                    <li class="nav-item active">
                        <a class="nav-link" href="login.jsp">Login/Register<span class="sr-only">(current)</span></a>
                    </li>
                    <%}else{%>
                    <li class="nav-item active">
                        <a class="nav-link" style="color: red;"  id="btnAdmin" href="logout"><u>Logout</u></a>
                    </li>
                    <%}%>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <%if (user != null && user.isAdmin()) {%>
                    <li class="nav-item">
                        <a class="nav-link" id="btnAdmin" href="admin.jsp">Admin</a>
                    </li>
                    <% }%>
                    <%if (user != null && !user.isAdmin()) {%>
                    <li class="nav-item">
                        <a class="nav-link" id="btnAdmin" href="userProfile.jsp">My profile</a>
                    </li>
                    <% }%>
                    <li class="nav-item active"><a class="nav-link" href="shoppingCart.jsp"><u>Shopping Cart</u></a></li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search products" aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" id="btnSearch" type="submit">Search</button>
                </form>
            </div>
        </nav>
        <h1 style="text-align: center; color: white; margin: 0;" >Jackets</h1>
        <%
            try {
                for (Item item : jackets) {
        %>

        <div class="row ">
            <div class="card " style="height: 20rem; border-radius: 1em; width: 17rem; margin: 1.5em;">
                <div class="card view zoom overlay" style="border-radius: 15em;">
                    <img style="border-radius: 1em;" class="img-fluid w-100" <%item.getItemImage();%>>
                </div>
                <div class="card-body text-center">
                    <h5><%=item.getItemName()%></h5>
                    <hr>
                    <h6 class="mb-3">
                        <span class="text-danger mr-1"><%=item.getPrice()%>$</span>
                    </h6>
                    <div class='main'>
                        <input type="number" id="counter" class="form-control text-center" style="width: 5em; margin-left: 6.5em;" value="1" min="1" max=<%=item.getAvailableAmount()%>>
                    </div>
                    <hr>
                    <div>
                        <span class="text-info mr-1"><%=item.getItemDescription() == null ? "No description" : item.getItemDescription()%></span>
                    </div>
                    <hr>
                    <form  method="post">
                        <input type="submit" class="btn btn-primary btn-sm mr-1 mb-2" onclick="addToCart(<%=item.getId()%>, getAmount())" value="Add to cart"/>
                    </form>
                </div>
            </div>

            <%}
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println(e.toString());
            %>
            <%}%>
        </div>
    </body>
</html>
<script>
    function getAmount() {
        var amount = document.getElementById('counter').value;
        return amount;
    }
</script>
<script>
    function addToCart(idItem, amount) {
        //alert('id: '+idItem +' amount: '+ amount);
        //alert(idItem + ' ' + amount);
        if (confirm('Add this item to cart?')) {
            $.ajax({
                url: 'cart',
                type: 'POST',
                data: {
                    idItem: idItem,
                    amount: amount
                },
                success: function () {
                    location.reload();
                }
            });
            return true;
        }
        return false;

    }
</script>
<script>
    $(document).ready(function () {
        $('button').click(function (e) {
            var button_classes, value = +$('.counter').val();
            button_classes = $(e.currentTarget).prop('class');
            if (button_classes.indexOf('up_count') !== -1) {
                value = (value) + 1;
            } else {
                value = (value) - 1;
            }
            value = value < 1 ? 1 : value;
            $('.counter').val(value);
        });
        $('.counter').click(function () {
            $(this).focus().select();
        });
    });
</script>
