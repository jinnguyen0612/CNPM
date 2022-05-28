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
						<div class="card-body">
							<h5
								class="card-title align-items-center d-flex justify-content-between transitioning">
								Danh sách gói tập</h5>
							<h3 class="success-message">${message}</h3>
                   			<h3 class="fail-message">${fmessage}</h3>

                   		<br/>
	
							<!-- Table with stripped rows -->
							<table class="table" id="my-data-table">
								<thead>
									<tr>
										<th class="col-2">Mã</th>
										<th class="col-2">Tên loại</th>
										<th>Mô tả</th>
										<th class="text-center col-2">Hành động</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="m" items="${packageType}">
									<tr>
									
										<td>${m.packTypeID}</td>
										<td>${m.packTypeName}</td>
										<td>${m.describe }</td>
										
										<td class="text-center">
											<button class="btn btn-outline-warning btn-light btn-sm"
												onclick="window.location.href = '${pageContext.request.contextPath}/admin/package/update/${m.packTypeID}.htm'" title="Chỉnh sửa">					
												<i class="fa-solid fa-pen-to-square"></i>									
											</button>
										</td>																				
									</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- End Table with stripped rows -->
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- modal  -->
		<div class="modal fade" id="modal-create" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white px-3 py-2">
						<h5 class="modal-title">Thêm mới Loại gói</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form:form action="${pageContext.request.contextPath}/admin/package/insert.htm"
              			 	modelAttribute="insertPKT"
                			class="row g-3" id="form-package">
							<div class="col-md-12">
								<label class="form-label">Mã: </label>
								<form:input path="packTypeID" type="text" class="form-control"
										id="input-package-name" required="text"/>
							</div>

							<div class="col-md-12">
								<label for="input-package-name" class="form-label">Tên
									loại</label> 
									<form:input path="packTypeName" type="text" class="form-control"
										id="input-package-name" required="text"/>
							</div>
							<div class="col-md-12">
								<label for="input-package-name" class="form-label">Mô
									tả</label>
								<form:input path="describe" type="textarea" class="form-control" aria-label="With textarea"
										rows="5" required="text"/>
							</div>
						
					
					<div class="modal-footer">
						<button type="submit" form="form-package" class="btn btn-primary">
							Xác nhận</button>
						<button type="button" form="form-package"
							class="btn btn-secondary close-form" data-bs-dismiss="modal">
							Đóng</button>
					</div>
					</form:form>
				 </div>
				</div>
			</div>
		</div>
		
		<!-- detail -->
	</main>
	<!-- End #main -->
	<!-- common script -->
	<%@include file="./script.jsp"%>
</body>
</html>


		<!--  		<input type="button" title="Chỉnh sửa" class="btn btn-outline-warning btn-light btn-sm" value="Chỉnh sửa asdsad "  onclick="window.location.href = 'admin/package/insert.htm'"/>

				<input type="button" onclick="window.location.href = 'admin/package.htm';" value="w3docs"/>
				-->