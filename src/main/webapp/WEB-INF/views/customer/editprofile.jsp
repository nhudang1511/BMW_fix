<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <link href="<c:url value = "templates/css/style.css" />"
	rel="stylesheet" type="text/css"> --%>
<body>
 <form action="reset-password" class="form-reset" method="post">
		  
<div class="container">
	<div class="row">
		<div class="col-sm-4">
		    
		    <label>Email</label>
		    <div class="form-group pass_show"> 
                <input name="user" value="${sessionScope.account.email}" class="form-control" required>
            </div> 
		       <label>Old Password</label>
            <div class="form-group pass_show"> 
                <input type="password" name="opass" class="form-control" placeholder="Old Password"> 
            </div> 
		       <label>New Password</label>
            <div class="form-group pass_show"> 
                <input type="password" name="pass" class="form-control" placeholder="New Password"> 
            </div> 
            <button class="btn btn-primary btn-block" type="submit">Reset Password</button>
		</div>  
	</div>
</div>
		</form>
</body>
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
