<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
						<h5 class="modal-title">Sửa lớp tập</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form method="post" action="${pageContext.request.contextPath}/admin/class/updateClass/${classEntityUpdate.classId}.htm"
						 modelAttribute="updateC"  class="row g-3">
							<div class="col-md-12">
								<label for="inputName" class="form-label">Mã:
									<span class="employeeId text-danger">
										<input type="text" class="form-control" name="classId"
									 		value="${classEntityUpdate.classId}" />
									</span>
								</label>
							</div>
							<div class="col-md-6">
								<label for="input-package" class="form-label">Gói tập</label> 
								<select name="packId"
									id="input-package" class="form-select">
										<option  value="${classEntityUpdate.packId}"> ${classEntityUpdate.packId} </option>
										<c:forEach var="T" items="${trainingPackEntity}">
				                        	<option value="${T.packID}">${T.packID}</option>
				                    	</c:forEach>
								</select>
							</div>
							<div class="col-md-6">
								<label for="input-pt" class="form-label">PT</label> 
								<select name="PT"
									id="input-pt" class="form-select">
									<c:forEach var="X" items="${ptEntity }">
										<option value="${X.ptID}"> ${X.ptID} </option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-6">
								<label for="input-open-register-day" class="form-label">Ngày
									mở đăng ký</label> 
									<input name="dateOpen" type="date" class="form-control"
									id="input-open-register-day" />
							</div>
							<div class="col-md-6">
								<label for="input-close-register-day" class="form-label">Ngày
									đóng đăng ký</label> 
									<input name="dateClose" type="date" class="form-control"
									id="input-close-register-day" />
							</div>

							<div class="col-md-6">
								<label for="input-close-register-day" class="form-label">Ngày
									bắt đầu lớp</label> 
									<input name="dateStart" type="date" class="form-control"
									id="input-close-register-day" />
							</div>

							<div class="col-md-6">
								<label for="inputPhone" class="form-label">Số
									người đăng ký tối đa</label> 
									<input name="maxPP" type="number" class="form-control" />
							</div>
							<div>
								<button class="btn col-12 btn-outline-primary btn-light"
									type="button" data-bs-target="#time-table"
									data-bs-toggle="modal">
									<i class="bi bi-plus-circle"></i> <span class="te">Tạo
										TKB</span>
								</button>
							</div>

							<div class="text-end mt-3">
								<button type="submit" class="btn btn-primary">Xác nhận
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		
			</div>
				</div>
		</section>
		</main>
		<%@include file="./script.jsp"%>
</body>
</html>