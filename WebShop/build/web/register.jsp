<%-- 
    Document   : register
    Created on : Nov 12, 2021, 10:13:05 PM
    Author     : Mladen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en" >
    <head>
        <title>Register</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="style/background.css" rel="stylesheet" type="text/css"/>
    </head>
    <body >
        <div class="container-fluid" style="color: white;">
            <div class="row">
                <div class="col-lg-10 col-xl-9 mx-auto">
                    <div class=" flex-row my-5 border-0 shadow rounded-3 overflow-hidden">
                        <div class="card-img-left d-none d-md-flex">
                            <!-- Background image for card set in CSS! -->
                        </div>
                        <div class="card-body p-4 p-sm-5">
                            <h5 class="card-title text-center mb-5 fw-light fs-5">Register</h5>
                            <form method="post" action="register">
                                <div class="form-floating mb-3">
                                    <label for="floatingInputUsername">Username:</label>
                                    <input type="text" name="username" class="form-control" id="floatingInputUsername" placeholder="Starlord29" required autofocus>
                                </div>
                                <div class="form-floating mb-3">
                                    <label for="floatingPassword">Password:</label>
                                    <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password" required>
                                </div>
                                <div class="form-floating mb-3">
                                    <label for="floatingPasswordConfirm">Confirm Password:</label>
                                    <input type="password" name="confirmPassword" class="form-control" id="floatingPasswordConfirm" placeholder="Confirm Password" required>
                                </div>
                                <div class="form-floating mb-3">
                                    <label for="floatingInputUsername">Address:</label>
                                    <input type="text" name="address" class="form-control" id="floatingInputAddress" placeholder="e.g. 20 W. Wall Street New York, NY 10040" required>
                                </div>
                                <div class="d-grid mb-2">
                                    <button class="btn btn-lg btn-primary btn-login fw-bold text-uppercase" type="submit">Register</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
