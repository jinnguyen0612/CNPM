<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="./head.jsp"%>
</head>

<body>

	<!-- initial customer data -->
	<div class="page-flag" data="schedule"></div>
	<div class="initialCSId position-absolute"
		data="${customer.customerId }"></div>
	<!-- ======= Header ======= -->
	<%@include file="./header.jsp"%>
	<!-- End Header -->

	<!-- ======= Sidebar ======= -->
	<%@include file="./sidebar.jsp"%>
	<!-- End Sidebar-->

	<main id="main" class="main">
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body pb-0">
							<h5 class="card-title">Danh sách khách tập hôm nay</h5>
							<!-- Table with stripped rows -->
							<table class="table" id="my-data-table">
								<thead>
									<tr>
										<th>Mã khách hàng</th>
										<th>Tên khách hàng</th>
										<th>Lớp</th>
										<th>Loại tập</th>
										<th>Buổi tập</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="c" items="${cList}">
										<tr>
											<td>${c.customer.customerId}</td>
											<td>${c.customer.name}</td>
											<td>${c.classEntity.maxPP == 1? 'Cá nhân': c.classEntity.classId}

											</td>
											<td>${c.classEntity.trainingPackEntity.trainingPackTypeEntity.packTypeName}
											</td>
											<td><c:choose>
													<c:when test="${c.schedule.session == 0}">
														<span class="badge rounded-pill bg-danger"> Sáng </span>
													</c:when>
													<c:when test="${c.schedule.session == 1}">
														<span class="badge rounded-pill bg-warning"> Chiều
														</span>
													</c:when>
													<c:when test="${c.schedule.session == 2}">
														<span class="badge rounded-pill bg-secondary"> Tối
														</span>
													</c:when>
												</c:choose></td>
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
	</main>
	<!-- End #main -->
	<!-- common script -->
	<%@include file="./script.jsp"%>
	<script type="text/javascript">
		
      $(document).ready(function () {  
    	  // show modal
    	  $(".btn-create").remove();
    	  let id = $(".modal-flag").attr("idModal")
    	  if(id) {
    	  $("#"+id).modal("show");
    	  }
        $(
          "#my-data-table_filter",
        ).append(`  <div class="search-bar-table d-flex align-items-stretch">
                      <div class="position-relative">
                          <button type="button" class="btn btn-primary btn-filter" data-bs-toggle="collapse" data-bs-target="#filter-block">
                              <i class="fa-regular fa-filter"></i>
                              <span class="text-white"></span>
                          </button>
                          <!-- filter table -->
                          <div id="filter-block" class="card position-absolute end-100 top-0 collapse" style="z-index: 100; min-width: 22rem;">
                              <div class="card-header py-2 text-secondary bg-info text-black fs-6">Bộ lọc</div>
                              <div class="card-body">
                                  <form action="admin/schedule.htm" class="row g-3 mt-1" id="form-filter">
                                      
                                      <div class="col-md-12">
                                          <label for="gender" class="form-label">Hình thức</label>
                                          <div class="col-md-12 d-flex">
                                              
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="type" id="filter-female" value="0" />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-female">
                                                      Cá nhân
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="type" id="filter-male" value="1" />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-male">
                                                      Lớp
                                                  </label>
                                              </div>
                                          </div>
                                      </div>
                                      <div class="col-md-12">
                                          <label for="status" class="form-label">Buổi</label>
                                          <div class="col-md-12 d-flex">
                                              
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="status" id="filter-status-0" value="0" />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-0">
                                                      Sáng
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="status" id="filter-status-1" value="1" />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-1">
                                                      Chiều
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                              <input class="form-check-input-filter" type="checkbox" name="status" id="filter-status-2" value="2" />
                                              <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-2">
                                                  Tối
                                              </label>
                                          </div>
                                          </div>
                                      </div>
                                  </form>
                              </div>
                              <div class="card-footer py-2 text-end">
                                  <button type="submit" name="btnFilter" form="form-filter" class="btn btn-primary">
                                      Lọc
                                  </button>
                                 
                              </div>
                          </div>
                      </div>
                  </div>
                `);    	 
      });
    </script>

</body>
</html>