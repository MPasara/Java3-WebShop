<%-- 
    Document   : storeItems
    Created on : Dec 8, 2021, 5:08:40 PM
    Author     : Mladen
--%>

<%@page import="hr.algebra.repository.Repository"%>
<%@page import="hr.algebra.repository.SqlRepository"%>
<%@page import="hr.algebra.models.Category"%>
<%@page import="hr.algebra.models.Item"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%List<Item> items = (List<Item>) (session.getAttribute("items"));%>
<%List<Category> categories = (List<Category>) (session.getAttribute("categories"));%>
<%Repository repo = new SqlRepository();%>
<!DOCTYPE html>
<html class="bg-dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Store items</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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

        <h1 style="text-align: center; color: white; margin: 0;" class="bg-dark">Store items</h1>
        <p></p>
        <%----%>
        <div id="page-content-wrapper" style="color: white">
            <div class="container">
                <table class="table table-bordered table-light table-hover table-striped" style="text-align: center;" >
                    <tr>
                        <td>ID</td>
                        <td>ITEM NAME</td>
                        <td>DESCRIPTION</td>
                        <td>PRICE</td>
                        <td>STORAGE AMOUNT</td>
                        <td>CATEGORY</td>
                        <td>SELECT</td>
                        <td>DELETE</td>
                    </tr>
                    <%if (items.size() != 0) {
                            for (Item item : items) {
                    %>
                    <tr>
                        <td><%=item.getId()%></td>
                        <td><%=item.getItemName()%></td>
                        <td><%=item.getItemDescription() == null ? "/" : item.getItemDescription()%></td>
                        <td><%=item.getPrice()%> $</td>
                        <td><%=item.getAvailableAmount()%></td>
                        <td><%=repo.getCategoryById(item.getCategory())%></td>
                        <td><button class="btn btn-primary" type="submit" onClick="selectItem()">Select</button></td>
                        <td><button class="btn btn-danger" type="submit" onClick="deleteItem(<%=item.getId()%>)">Delete</button></td>
                    </tr>
                    <%}
                    } else {%>
                    <h1>No data in Database!</h1>
                    <%}%>
                </table>
            </div>
            <h1 style="text-align: center; color: white; margin: 0;" ><u>Item Editing Station</u></h1>
            <p></p>
            <form>
                <div class="container">
                    <div class="form-group">
                        <table class="table " style="text-align: center; color: white;">
                            <tr>
                                <td>Item name: </td>
                                <td><input class="form-control" type="text" id="itemName"></input></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Description: </td>
                                <td><textarea class="form-control" id="itemDescription" rows="2"></textarea></td>
                            </tr>
                            <tr>
                                <td>Price: </td>
                                <td><input class="form-control" id="itemPrice"></input></td>
                            </tr>
                            <tr>
                                <td>Storage amount: </td>
                                <td><input class="form-control" id="itemStorageAmount"></input></td>
                            </tr>
                            <tr>
                                <td>Category: </td>
                                <td>
                                    <select class="form-control" id="itemCategory">
                                        <%for (Category c : categories) {%>
                                        <option value="<%=c.getId()%>"><%=c.getTitle()%></option>
                                        <%}%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><button class="btn btn-primary" onclick="addItem()">Add</button></td>
                                <td><button class="btn btn-success">Update</button></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <p></p>
            <h1 style="text-align: center; color: white; margin: 0;"><u>Category Editing Station</u></h1>
            <p></p>
            <form>
                <div class="container">
                    <table class="table table-bordered table-light table-hover table-striped" style="text-align: center;" >
                        <tr>
                            <td>ID</td>
                            <td>CATEGORY NAME</td>
                            <td>EDIT</td>
                            <td>DELETE</td>
                        </tr>
                        <%for (Category c : categories) {
                        %>
                        <tr>
                            <td><%=c.getId()%></td>
                            <td><%=c.getTitle()%></td>
                            <td><button class="btn btn-primary" type="submit" onClick="editCategory()">Edit</button></td>
                            <td><button class="btn btn-danger" type="submit" onClick="deleteCategory(<%=c.getId()%>)">Delete</button></td>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </form>
            <p></p>
            <div class="container">
                <table>
                    <tr>
                        <td>
                            <label style="text-align: center;">Name: </label>
                        </td>
                        <td>
                            <input class="form-control" type="text"></input>
                        </td>
                        <td><button class="btn btn-success">Save</button></td>
                    </tr>
                </table>
            </div>
            <p></p>
            <div class="container">
                <table>
                    <tr>
                        <td>
                            <label style="text-align: center;">Add new category: </label>
                        </td>
                        <td>
                            <input class="form-control" id="addNewCategory" type="text"></input>
                        </td>
                        <td><button class="btn btn-info" onclick="addCategory()">Add</button></td>
                    </tr>
                </table>
            </div>
            <p></p>
        </div>
    </body>
</html>

<script>
    function addItem() {
        var itemName = document.getElementById('itemName').value;
        var itemDescripton = document.getElementById('itemDescription').value;
        var itemPrice = document.getElementById('itemPrice').value;
        var itemStorageAmount = document.getElementById('itemStorageAmount').value;
        var itemCategory = document.getElementById('itemCategory').value;
        //alert(itemName+ itemDescripton+ itemPrice+ itemStorageAmount+ itemCategory);
        alert(itemCategory);
        //alert($.ajax);
        if (confirm('Add item to database?')) {
            $.ajax({
                url: 'admin',
                type: 'POST',
                data: {
                    itemName: itemName,
                    itemDescription: itemDescripton,
                    itemPrice: itemPrice,
                    itemStorageAmount: itemStorageAmount,
                    itemCategory: itemCategory
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
    function deleteItem(idItem) {
        //alert('Rili delete this item?');
        //alert($.ajax);
        if (confirm('Do you really want to delete this item?')) {
            $.ajax({
                url: 'admin',
                type: 'POST',
                data: 'idItem=' + idItem,
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
    function addCategory() {
        var categoryName = document.getElementById('addNewCategory').value;
        //alert(categoryName);
        if (confirm('Really add this category')) {
            $.ajax({
                url: 'admin',
                type: 'POST',
                data: 'categoryName=' + categoryName,
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
    function deleteCategory(idCategory) {
        //alert('Rili delete this category?');
        if (confirm('Do you really want to delete this category? All items in this category will be deleted with it')) {
            $.ajax({
                url: 'admin',
                type: 'POST',
                data: 'idCategory=' + idCategory,
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
    $("#menu-toggle").click(function (e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
</script>
