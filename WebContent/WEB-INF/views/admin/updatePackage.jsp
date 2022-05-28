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
						<h5 class="modal-title">Chỉnh sửa gói tập</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form method ="post" class="row g-3" id="form-package" action="${pageContext.request.contextPath}/admin/package/updateTrainingPack/${trainingPackEntity.packID}.htm"
						modelAttribute="updateP">
							<div class="col-md-12">
								<label class="form-label">Mã<span
									class="employeeId text-danger"></span></label>
									<input type="text" class="form-control" name="packID"
									 value="${trainingPackEntity.packID}" readonly/>
							</div>
							<div class="col-md-6">
								<label for="package-type" class="form-label">Loại gói</label> 
									<input type="text" class="form-control" name="packTypeID" 
									value="${trainingPackEntity.trainingPackTypeEntity.packTypeID}" readonly/>
							</div>

							<div class="col-md-6">
								<label for="input-package-name" class="form-label">Tên
									gói tập</label> 
									<input type="text" class="form-control"
									id="input-package-name" name="packName" value="${trainingPackEntity.packName}" />
							</div>

							<div class="col-md-6">
								<label for="input-package-limit-time" class="form-label">Hạn
									gói</label>
								<div class="input-group col-md-6 mb-3">
									<input id="input-package-limit-time" type="number"
										class="form-control"  aria-label="Username"
										aria-describedby="basic-addon1" name="packDuration" value="${trainingPackEntity.packDuration}" /> <span
										class="input-group-text" id="basic-addon1" >Tháng</span>
								</div>
							</div>

							<div class="col-md-6">
								<label for="input-package-price" class="form-label">Giá
									gói</label>
								<div class="input-group col-md-6 mb-3">
									<input id="iinput-package-price" type="number"
										class="form-control" placeholder="vd: 50000"
										aria-label="input-package-price"
										aria-describedby="basic-addon1" name="money" value="${trainingPackEntity.money}"/> <span
										class="input-group-text" id="basic-addon1">VND</span>
								</div>
							</div>
							<fieldset class="col-md-12">
								<legend class="col-form-label col-sm-2 pt-0"> Trạng
									thái </legend>
									
							<c:choose>
								 <c:when test="${trainingPackEntity.status=='0'}">
          								<div class="col-sm-12 d-flex gap-4">
									<div class="form-check">
										<input class="form-check-input" type="radio"
											id="block" name="status"  value="${trainingPackEntity.status}" checked /> <label
											class="form-check-label" for="block"> Khoá </label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" 
											id="active" name="status" value="1" /> <label class="form-check-label"
											for="active"> Kích hoạt </label>
									</div>
								</div>
								 </c:when>
								 <c:when test="${trainingPackEntity.status=='1' }">
  											<div class="col-sm-12 d-flex gap-4">
									<div class="form-check">
										<input class="form-check-input" type="radio" 
											id="block" name="status" value="0"  /> <label
											class="form-check-label" for="block"> Khoá </label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="status"
											id="active" name="status" value="${trainingPackEntity.status}" checked/> <label class="form-check-label"
											for="active"> Kích hoạt </label>
									</div>
								</div>
 								</c:when>
							</c:choose> 
							
								
							</fieldset>
							</div>
							<div class="modal-footer">
								<button type="submit" form="form-package" class="btn btn-primary">
									Xác nhận</button>
							</div>
						</div>
						</form>
					
			</div>
		
					</div>
				</div>
			</div>
		</section>
		</main>
		<%@include file="./script.jsp"%>
</body>
</html>