<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="<c:url value = "templates/css/style.css" />"
	rel="stylesheet" type="text/css">
<body>
	<%@include file="/common/taglib.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="home">Home</a></li>
						<li class="breadcrumb-item active" aria-current="page">Search</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	<form action=""></form>
	<div class="container">
			<div class="col">
				<div id="content" class="row">
				<c:if test="${!listall.isEmpty() }">
				<c:forEach items="${listall}" var="p">
						<div class="col-12 col-md-6 col-lg-4">
							<div class="card">
								<c:url value="/image?fname=${p.getImage() }" var="imgUrl"></c:url>
								<img class="img-fluid border-0" width="200px" height="100px"
									src="${imgUrl}" alt="">
								<div class="card-body">
									<h4 class="card-title">
										<a href="product?pid=${p._id }" title="View Product">${p.name }</a>
									</h4>
									<p class="card-text">${p.description }</p>
									<div class="row">
										<div class="col">
											<p class="btn btn-danger btn-block">${p.price}$</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				
				<c:if test="${listall.isEmpty()}">
				<div>
				<h1>Từ khóa không đúng, vui lòng nhập lại</h1>
				</div>
				</c:if>
			</div>
		</div>
	</div>			
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
		function loadMore() {
			//var amount = document.getElementsByClassName("product").length;
			$.ajax({
				url : "/BanHang/load", //send to Controller
				type : "get", //send it through get method
				success : function(data) {
					//$("#content").append(data);
					var row = document.getElementsById("content");
					row.innerHTML += data;
				},
				error : function(xhr) {
					//Do Something to handle error
				}
			});
		};
}
	</script>