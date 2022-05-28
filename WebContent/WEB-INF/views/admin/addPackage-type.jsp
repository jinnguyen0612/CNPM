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
			<div class="container">
			<form:form class="form" action="${pageContext.request.contextPath}/admin/package/insert.htm"
               modelAttribute="insertPKT">
               	
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header bg-primary text-white px-3 py-2">
							<h5 class="modal-title">Thêm mới Loại gói</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="row g-3" id="form-package">
								<div class="col-md-12">
									<label for="input-package-name" class="form-label">Mã
										</label> 
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
								<label class="success-message"> ${success_message}</label>
        						<label class="fail-message"> ${fail_message}</label>
							</div>
						</div>
					
					</div>
				</div>
				
				<div class="modal-footer" class="btn btn-primary">
				<button class="btn btn-primary">Thêm</button>
				
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
		<%@include file="./script.jsp"%>
</body>
</html>