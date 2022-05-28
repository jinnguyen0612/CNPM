<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="./head.jsp"%>
</head>
<body>
	<!-- ======= Header ======= -->
	<%@include file="./header.jsp"%>
	<!-- End Header -->

	<!-- ======= Sidebar ======= -->
	<%@include file="./sidebar.jsp"%>
	<!-- End Sidebar-->
	<main id="main" class="main">
		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						
					
		
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white px-3 py-2">
						<h5 class="modal-title">Thêm gói tập</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form:form class="row g-3" id="form-package" action="${pageContext.request.contextPath}/admin/package/insertP.htm"
						modelAttribute="insertP">
						<label  class="success-message">${message}</label>
        				<label  class="fail-message">${fmessage}</label>
							<div class="col-md-12">
								<label class="form-label">Mã<span
									class="employeeId text-danger"></span></label>
									<form:input path="packID" type="text" class="form-control" />
							</div>
							<div class="col-md-6">
								<label for="package-type" class="form-label">Loại gói</label> 
								<form:select path="packTypeID" class="form-control">
				                    <c:forEach var="T" items="${trainingPackTypeEntity}">
				                        <form:option value="${T.packTypeID}">${T.packTypeID}</form:option>
				                    </c:forEach>
				                </form:select>
								
								
							</div>

							<div class="col-md-6">
								<label for="input-package-name" class="form-label">Tên
									gói tập</label> 
									<form:input type="text" class="form-control"
									id="input-package-name" path="packName" />
							</div>

							<div class="col-md-6">
								<label for="input-package-limit-time" class="form-label">Hạn
									gói</label>
								<div class="input-group col-md-6 mb-3">
									<form:input id="input-package-limit-time" type="number"
										class="form-control"  aria-label="Username"
										aria-describedby="basic-addon1" path="packDuration"  /> <span
										class="input-group-text" id="basic-addon1" >Tháng</span>
								</div>
							</div>

							<div class="col-md-6">
								<label for="input-package-price" class="form-label">Giá
									gói</label>
								<div class="input-group col-md-6 mb-3">
									<form:input id="iinput-package-price" type="number"
										class="form-control" placeholder="vd: 50000"
										aria-label="input-package-price"
										aria-describedby="basic-addon1" path="money" /> <span
										class="input-group-text" id="basic-addon1">VND</span>
								</div>
							</div>
							<fieldset class="col-md-12">
								<legend class="col-form-label col-sm-2 pt-0"> Trạng
									thái </legend>
									
						            <form:select path="status" class="form-control">
						                <form:option value="0">Khóa</form:option>
						            </form:select>
														
							</fieldset>
							</div>
							<div class="modal-footer">
								<button type="submit" form="form-package" class="btn btn-primary">
									Xác nhận</button>
							</div>
						</div>
						</form:form>
					
			</div>
		
					</div>
				</div>
			</div>
		</section>