<%-- 
    Document   : shoppingCart
    Created on : Nov 12, 2021, 10:45:09 PM
    Author     : Mladen
--%>

<%@page import="hr.algebra.models.User"%>
<%@page import="java.util.List"%>
<%@page import="hr.algebra.models.Item"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%List<Item> cartItems = (List<Item>) (session.getAttribute("cartItems"));%>
<%String amount = (String) session.getAttribute("amount");%>
<%Double total = 0.0;%>
<%User user = (User) session.getAttribute("user");%>
<!doctype html>
<html lang="en" >

    <head >
        <link href="style/background.css" rel="stylesheet" type="text/css"/>
        <title>Shopping cart</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

        <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <script src="https://www.paypal.com/sdk/js?client-id=test&enable-funding=venmo&currency=USD" data-sdk-integration-source="button-factory"></script>
        <!------ Include the above in your HEAD tag ---------->

        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    </head>

    <body >
        <h1 style="text-align: center; color: white; margin-top: 1em;" >Your Cart</h1>
        <div class="container">

            <table id="cart" style="margin-top: 2em; color: white" class="table table-hover table-condensed">
                <thead>
                    <tr>
                        <th style="width:50%">Product</th>
                        <th style="width:10%">Price</th>
                        <th style="width:8%">Quantity</th>
                        <th style="width:22%" class="text-center">Subtotal</th>
                        <th style="width:10%"></th>
                    </tr>
                </thead>
                <%if (cartItems != null) {
                        for (Item item : cartItems) {
                %>
                <tbody>
                    <tr>
                        <td data-th="Product">
                            <div class="row">
                                <div class="col-sm-2 hidden-xs"><img style="margin-top: 0;" src="http://placehold.it/100x100"<%=item.getItemImage()%> alt="..."
                                                                     class="img-responsive" /></div>
                                <div class="col-sm-10">
                                    <h4 class="nomargin"><%=item.getItemName()%></h4>
                                    <p><%=item.getItemDescription() == null ? "No description" : item.getItemDescription()%></p>
                                </div>
                            </div>
                        </td>
                        <td data-th="Price">$<%=item.getPrice()%></td>
                        <td data-th="Quantity">
                            <input type="text" readonly="true" class="form-control text-center" value=<%=amount%> >
                        </td>
                        <% total += (item.getPrice() * Double.parseDouble(amount));%>
                        <td data-th="Subtotal" class="text-center">$<%=item.getPrice() * Double.parseDouble(amount)%></td>
                        <td class="actions" data-th="">
                            <!------ <button id="delete" onclick="removeItem(<%=item.getId()%>)" class="btn btn-danger btn-sm"><i class="fa fa-trash-o"></i> </button> ---------->
                            <a href="cart/?idItem=<%=item.getId()%>" class="btn btn-danger btn-sm"><i class="fa fa-trash-o"></i> </a>
                        </td>
                    </tr>
                </tbody>
                <%}
                } else {%>
                <h1 style="text-align: center; color: white;">Cart is empty.</h1>
                <%}%>
                <tfoot>
                    <tr class="visible-xs">
                        <td class="text-center"><strong>Total <%=total%></strong></td>
                    </tr>
                    <tr>
                        <td><button class="btn btn-warning" onclick="window.history.back();">< Continue shopping</button>
                        </td>
                        <td colspan="2" class="hidden-xs"></td>
                        <td class="hidden-xs text-center"><strong>Total $<%=total%></strong></td>
                        <td>
                            <%if (user != null && total != 0) {
                            %>
                            <a href="cash/?total=<%=total%>" class="btn btn-success btn-block">Checkout - cash payment on delivery<i class="fa fa-angle-right"></i></a>
                                <%} else {%>
                            <h4 style="text-align: center; color: red;">You have to have items in cart and be logged in to checkout.</h4>
                            <%}%>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
        <hr>
        <%if (user != null && total != 0) {
        %>
        <h1 style="text-align: center; color: white; margin-bottom: 2em;"><u>Checkout with PayPal</u></h1>
        <div id="smart-button-container">
            <div style="text-align: center;">
                <div id="paypal-button-container"></div>
            </div>
        </div>
        <%}%>

    </body>
</html>

<script>
    function initPayPalButton() {
        paypal.Buttons({
            style: {
                shape: 'pill',
                color: 'gold',
                layout: 'horizontal',
                label: 'paypal',

            },

            createOrder: function (data, actions) {
                return actions.order.create({
                    purchase_units: [{"amount": {"currency_code": "USD", "value": <%=total%>}}]
                });
            },

            onApprove: function (data, actions) {
                return actions.order.capture().then(function (orderData) {

                    // Full available details
                    console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));

                    // Show a success message within this page, e.g.
                    const element = document.getElementById('paypal-button-container');
                    element.innerHTML = '';
                    element.innerHTML = '<h3>Thank you for your payment!</h3>';

                    // Or go to another URL:  actions.redirect('thank_you.html');

                });
            },

            onError: function (err) {
                console.log(err);
            }
        }).render('#paypal-button-container');
    }
    initPayPalButton();
</script>