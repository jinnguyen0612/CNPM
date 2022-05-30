<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
	<div class="page-flag" data="customer"></div>
	<main id="main" class="main">
		<!-- End Page Title -->


		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body pb-0">
							<h5 class="card-title">Danh sách thông tin đăng ký</h5>

							<!-- Table with stripped rows -->
							<table class="table" id="my-data-table">
								<thead>
									<tr>
										<th>Mã</th>
										<th>Tên khách hàng</th>
										<th>Tài khoản đăng ký</th>
										<th>Ngày đăng ký</th>
										<th>Trạng thái</th>
										<th class="text-center ">Thao tác</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="r" items="${registerList}">
										<tr>
											<td>${r.registerId}</td>
											<td>${r.customer.name}</td>
											<td>${r.account.username}</td>
											<td>${r.registerDate}</td>

											<td class="account-state"><c:if test="${r.status == 0}">
													<span class="badge rounded-pill bg-danger">Chưa
														thanh toán</span>
												</c:if> <c:if test="${r.status == 1}">
													<span class="badge rounded-pill bg-success">Đã thanh
														toán</span>
												</c:if></td>

											<td class="text-center"><c:choose>
													<c:when test="${r.status == 1}">
														<button title="Chỉnh sửa" disabled="disabled"
															class="btn btn-sm btn-secondary">
															<i class="fa-solid fa-pen-to-square"></i>
														</button>
													</c:when>
													<c:otherwise>
														<a
															href="admin/customer/register/update/${r.registerId}.htm"><button
																class="btn btn-outline-warning btn-light btn-sm"
																title="Chỉnh sửa">
																<i class="fa-solid fa-pen-to-square"></i>
															</button> </a>
													</c:otherwise>
												</c:choose> <a
												href="admin/contract-registration/detail/${r.registerId}.htm">
													<button class="btn btn-outline-info btn-light btn-sm"
														title="Chi tiết" data-bs-toggle="modal"
														data-bs-target="#detail" data-bs-placement="top">
														<i class="fa-solid fa-circle-exclamation"></i>
													</button>
											</a> <c:choose>
													<c:when test="${r.status == 1}">
														<button title="Tạo hoá đơn" disabled="disabled"
															class="btn  btn-sm btn-secondary">
															<i class="fa-solid fa-ballot"></i>
														</button>
													</c:when>
													<c:otherwise>
														<button title="Tạo hoá đơn"
															class="btn btn-outline-success btn-sm">
															<i class="fa-solid fa-ballot"></i>
														</button>
													</c:otherwise>
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

		<!-- table detail -->
		<div class="modal fade" id="modal-detail" tabindex="-1">
			<div class="modal-dialog modal-lg modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white px-3 py-2">
						<h5 class="modal-title">Thông tin đăng ký</h5>
						<button type="button" class="btn-close close-form"
							data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body p-0">
						<section class="section profile">
							<div class="row">
								<div class="col-xl-12 mx-auto">
									<div class="card mb-0">
										<div class="card-body pt-3">
											<!-- Bordered Tabs -->
											<div class="tab-content pt-2">
												<div
													class="tab-pane fade show active profile-overview d-flex"
													id="profile-overview">

													<div class="col-6 border-end">
														<div class="row mt-4">
															<div class="col-lg-5 col-md-4 label">Mã đăng ký</div>
															<div class="col-lg-7 col-md-8">${registerDetail.registerId}</div>
														</div>
														<div class="row">
															<div class="col-lg-5 col-md-4 label">Tên khách hàng</div>
															<div class="col-lg-7 col-md-8">${registerDetail.customer.name}</div>
														</div>
														<div class="row">
															<div class="col-lg-5 col-md-4 label">Ngày dăng ký</div>
															<div class="col-lg-7 col-md-8">
																<fmt:formatDate value="${registerDetail.registerDate}"
																	pattern="dd/MM/yyyy" />
															</div>
														</div>

														<div class="row">
															<div class="col-lg-5 col-md-4 label">Tài khoản đăng
																ký</div>
															<div class="col-lg-7 col-md-8">${registerDetail.account.username}</div>
														</div>

														<div class="row">
															<div class="col-lg-5 col-md-4 label">Trạng thái</div>
															<div class="col-lg-7 col-md-8">
																<c:if test="${registerDetail.status == 0}">
																	<span class="text-danger">Chưa thanh toán</span>
																</c:if>
																<c:if test="${r.status == 1}">
																	<span class="text-success">Đã thanh toán</span>
																</c:if>
															</div>
														</div>
													</div>
													<div class="col-6">
														<div class="row mt-4 ">
															<div class="col-lg-5 mx-auto label">Các gói đăng ký</div>
														</div>


														<c:forEach var="d"
															items="${registerDetail.registerDetailList}">
															<c:forEach var="t"
																items="${d.classEntity.scheduleEntity}">
																<input type="text"
																	class="T-${d.classEntity.classId} invisible position-absolute"
																	value='D-T${t.day}-${t.session}'>
															</c:forEach>
															<div
																class="p-2 bg-white border-top border-bottom mb-3 rounded d-flex flex-column col-10 mx-auto">
																<div class="row">
																	<div class="col-lg-5 col-md-6 label">Gói tập</div>
																	<div class="col-lg-7 col-md-6">${d.classEntity.trainingPackEntity.packName}</div>
																</div>
																<div class="row">

																	<div class="col-lg-5 col-md-4 label">Ngày tập</div>
																	<div class="col-lg-7 col-md-8">
																		<fmt:formatDate value="${d.classEntity.dateStart}"
																			pattern="dd/MM/yyyy" />
																	</div>
																</div>
																<div class="row">
																	<div class="col-lg-5 col-md-4 label">Thời hạn</div>
																	<div class="col-lg-7 col-md-8">${d.classEntity.trainingPackEntity.packDuration}
																		tháng</div>
																</div>
																<div class="row">
																	<div class="col-lg-5 col-md-4 label">Hình thức</div>
																	<div class="col-lg-7 col-md-8">${d.classEntity.maxPP == 1?'Cá nhân':'Lớp' }
																	</div>
																</div>

																<button type="button" data=".T-${d.classEntity.classId}"
																	class="btn-show-time-table-detail btn btn-outline-success btn-light btn-sm">
																	<i class="fa-regular fa-calendar-days"></i>
																</button>
															</div>
														</c:forEach>

													</div>

												</div>


											</div>
											<!-- End Bordered Tabs -->
										</div>
									</div>
								</div>
							</div>
						</section>
						<!-- End Multi Columns Form -->
					</div>
				</div>
			</div>
		</div>
		<!-- end table detail -->


		<!-- Time-table detail -->
		<div class="modal fade" id="time-table-detail" tabindex="-1">
			<div class="modal-dialog modal-xl modal-dialog-centered">
				<div class="modal-content">
					<section class="section">
						<div class="row">
							<div class="col-lg-12">
								<div class="card mb-0">
									<div class="card-body">
										<h5
											class="card-title align-items-center d-flex justify-content-between">
											Thời Khoá Biểu</h5>

										<!-- Table with stripped rows -->
										<div class="my-time-table">
											<div class="table-responsive">
												<table class="table table-bordered text-center">
													<thead>
														<tr class="bg-light-gray">
															<th class="text-uppercase col-1 label">Buổi</th>
															<th class="text-uppercase col-1 label">Thứ hai</th>
															<th class="text-uppercase col-1 label">Thứ ba</th>
															<th class="text-uppercase col-1 label">Thư tư</th>
															<th class="text-uppercase col-1 label">Thứ năm</th>
															<th class="text-uppercase col-1 label">Thứ sáu</th>
															<th class="text-uppercase col-1 label">Thứ bảy</th>
															<th class="text-uppercase col-1 label">Chủ nhật</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td class="align-middle bg-light">Sáng</td>
															<td class="td-time-table"><input type="radio"
																name="T2" form="register" id="D-T2-0" value="0"
																class="form-check-input" /> <label for="D-T2-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T3" id="D-T3-0" value="0"
																class="form-check-input" /> <label for="D-T3-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T4" id="D-T4-0" value="0"
																class="form-check-input" /> <label for="D-T4-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T5" id="D-T5-0" value="0"
																class="form-check-input" /> <label for="D-T5-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T6" id="D-T6-0" value="0"
																class="form-check-input" /> <label for="D-T6-0"></label></td>

															<td class="td-time-table"><input form="register"
																type="radio" name="T7" id="D-T7-0" value="0"
																class="form-check-input" /> <label for="D-T7-0"></label></td>

															<td class="td-time-table"><input form="register"
																type="radio" name="T8" id="D-T8-0" value="0"
																class="form-check-input" /> <label for="D-T8-0"></label></td>
														</tr>

														<tr>
															<td class="align-middle bg-light">Chiều</td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T2" id="D-T2-1" value="1"
																class="form-check-input" /> <label for="D-T2-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T3" id="D-T3-1" value="1"
																class="form-check-input" /> <label for="D-T3-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T4" id="D-T4-1" value="1"
																class="form-check-input" /> <label for="D-T4-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T5" id="D-T5-1" value="1"
																class="form-check-input" /> <label for="D-T5-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T6" id="D-T6-1" value="1"
																class="form-check-input" /> <label for="D-T6-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T7" id="D-T7-1" value="1"
																class="form-check-input" /> <label for="D-T7-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T8" id="D-T8-1" value="1"
																class="form-check-input" /> <label for="D-T8-1"></label></td>
														</tr>

														<tr>
															<td class="align-middle bg-light">Tối</td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T2" id="D-T2-2" value="2"
																class="form-check-input" /> <label for="D-T2-2E"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T3" id="D-T3-2" value="2"
																class="form-check-input" /> <label for="D-T3-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T4" id="D-T4-2" value="2"
																class="form-check-input" /> <label for="D-T4-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T5" id="D-T5-2" value="2"
																class="form-check-input" /> <label for="D-T5-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T6" id="D-T6-2" value="2"
																class="form-check-input" /> <label for="D-T6-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T7" id="D-T7-2" value="2"
																class="form-check-input" /> <label for="D-T7-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T8" id="D-T8-2" value="2"
																class="form-check-input" /> <label for="D-T8-2"></label></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<!-- End Table with stripped rows -->
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>


		<!-- end table detail -->
	</main>
	<!-- End #main -->
	<!-- common script -->
	<%@include file="./script.jsp"%>
	<script type="text/javascript">
      $(document).ready(function () {
    	  let id = $(".modal-flag").attr("idModal")
    	  if(id) {
    	  $("#"+id).modal("show");
    	  }
    	  
    	  $(".btn-show-time-table-detail").click(function() {
    		  $("#time-table-detail :input").prop( "checked", false );
    		  $(this.getAttribute("data")).each(function() {
    			  $("#"+this.value).prop( "checked", true );
    		  })
    		  $("#time-table-detail").modal("show");
    	  })
        $(
          "#my-data-table_filter",
        ).append(` <div class="search-bar-table d-flex align-items-stretch">
                      <div class="position-relative">
                          <button type="button" class="btn btn-primary btn-filter" data-bs-toggle="collapse" data-bs-target="#filter-block">
                              <i class="fa-regular fa-filter"></i>
                              <span class="text-white"></span>
                          </button>
                          <!-- filter table -->
                          <div id="filter-block" class="card position-absolute end-100 top-0 collapse" style="z-index: 100; min-width: 26rem;">
                          <div class="card-header py-2 text-secondary bg-info text-black fs-6">Bộ lọc</div>
                              <div class="card-body">
                                  <form class="row g-3 mt-1" id="form-filter">
                                      <div class="col-12">
                                          <label for="input-birthday" class="form-label">Ngày đăng ký</label>

                                          <div class="col-12 d-flex gap-1 justify-content-around align-items-stretch">
                                              <div class="input-group">
                                                  <input id="input-birthday" type="date" class="form-control" aria-label="input-birthday" aria-describedby="basic-addon1" />
                                              </div>
                                              <button type="button" class="btn btn-primary btn-sm btn-range-filter">
                                                  Đến
                                              </button>

                                              <div class="input-group d-none range-filter-right">
                                                  <input id="input-birthday-right" type="date" class="form-control" aria-label="input-birthday" aria-describedby="basic-addon1" />
                                              </div>
                                          </div>
                                      </div>
                                      <div class="col-md-12">
                                          <label for="status" class="form-label">Trạng thái</label>
                                          <div class="col-md-12 d-flex">
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="radio" name="status" id="filter-allStatus" value="" checked />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-allStatus">
                                                      Tất cả
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="radio" name="status" id="filter-status-0" value="0" />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-0">
                                                      Đã thanh toán
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="radio" name="status" id="filter-status-1" value="1" />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-1">
                                                      Chưa thanh toán
                                                  </label>
                                              </div>
                                          </div>
                                      </div>
                                  </form>
                              </div>
                              <div class="card-footer py-2 text-end">
                                  <button type="submit" form="form-filter" class="btn btn-primary">
                                      Lọc
                                  </button>
                                  <button type="reset" class="btn btn-secondary">
                                      Đặt lại
                                  </button>
                              </div>
                          </div>
                      </div>
                  </div>
                  `);

        $(".btn-filter").click(function () {
          $(".filter-block").toggleClass("show-flex");
        });

        $(".personal-chosen").click(function () {
          $("#input-class").val("0");
        });
      });
    </script>
</body>
</html>