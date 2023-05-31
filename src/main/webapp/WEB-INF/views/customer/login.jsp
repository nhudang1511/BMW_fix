<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous"> -->
	
<link href="cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
<link
	href="<c:url value='/assets/vendors/bootstrap/dist/css/bootstrap.min.css'/>"
	rel="stylesheet">

<link
	href="<c:url value='/assets/vendors/font-awesome/css/font-awesome.min.css'/>"
	rel="stylesheet">
<!-- <link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous"> -->
<link href="<c:url value = "templates/css/style2.css" />"
	rel="stylesheet" type="text/css">
<title>Bootstrap 4 Login/Register Form</title>
</head>
<body>
	<div id="logreg-forms">
		<div class="row">
			<div class="col">
				<c:if test="${not empty message}">
					<div class="alert alert-success">${message}</div>
				</c:if>
				<c:if test="${not empty error}">
					<div class="alert alert-danger">${error}</div>
				</c:if>
			</div>
		</div>
		<form class="form-signin" action="login" method="post">
			<h1 class="h3 mb-3 font-weight-normal" style="text-align: center">
				Sign in</h1>

			<input name="user" type="text" class="form-control" placeholder="Username"> 
				<input name="pass" type="password" class="form-control" placeholder="Password">

			<button class="btn btn-success btn-block" type="submit">
				<i class="fas fa-sign-in-alt"></i> Sign in
			</button>
			<a href="#" id="forgot_pswd">Forgot password?</a>
			<hr>
			<!-- <p>Don't have an account!</p>  -->
			<button class="btn btn-primary btn-block" type="button"
				id="btn-signup">
				<i class="fas fa-user-plus"></i> Sign up New Account
			</button>
		</form>


		<form action="signup" class="form-signup">
			<input name="firstname" type="text" id="first-name" class="form-control" placeholder="First name" required="" autofocus=""> 
			<input name="lastname" type="text" id="last-name" class="form-control" placeholder="Last name" required autofocus=""> 
			<input name="idcard" type="number" id="id_card" class="form-control" placeholder="Id card" required autofocus="">
          	<input name="user" type="text" id="user-name" class="form-control" placeholder="User/ Email" required="" autofocus=""> 
          	<input name="phone" type="number" id="phone" class="form-control" placeholder="Phone" required autofocus=""> 
			<input name="e_wallet" type="text" id="e_wallet" class="form-control" placeholder="E wallet" required autofocus=""> 
			<input name="pass" type="password" id="user-pass" class="form-control" placeholder="Password" required autofocus=""> 
			<input name="repass" type="password" id="user-repeatpass" class="form-control" placeholder="Repeat Password" required autofocus="">

			<button class="btn btn-primary btn-block" type="submit">
				<i class="fas fa-user-plus"></i> Sign Up
			</button>
			<a href="#" id="cancel_signup"><i class="fas fa-angle-left"></i>
				Back</a>
		</form>
		<br>

	</div>
	<script  >

    function toggleSignUp(e){
        e.preventDefault();
        $('#logreg-forms .form-signin').toggle(); // display:block or none
        $('#logreg-forms .form-signup').toggle(); // display:block or none
    };

    $(()=>{
        // Login Register Form
        $('#logreg-forms #btn-signup').click(toggleSignUp);
        $('#logreg-forms #cancel_signup').click(toggleSignUp);
    });
    </script>
</body>
</html>
>
