<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="./head.jsp"%>
</head>
<body>
	<!-- ======= Header ======= -->
	<%@include file="./header.jsp"%>
	<!-- End Header -->
	<!-- ======= Sidebar ======= -->
	<%@include file="./sidebar.jsp"%>
	<!-- End Sidebar-->
	<div class="page-flag" data="account"></div>
	<main id="main" class="main">
		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body pb-0">
							<h5
								class="card-title align-items-center d-flex justify-content-between transitioning">
								Danh sách tài khoản</h5>
							<!-- Table with stripped rows -->
							<table class="table" id="my-data-table">
								<thead>
									<tr>
										<th class="text-center">STT</th>
										<th>Tên tài khoản</th>
										<th>Ngày Tạo</th>

										<th>Trạng Thái</th>
										<th>Loại tài khoản</th>
										<th class="text-center col-2">Thao tác</th>
									</tr>
								</thead>
								<tbody>
									<%
									int count = 0;
									%>
									<c:forEach var="a" items="${aList}">
										<c:if test="${(not empty a.customer) or (not empty a.staff) }">
											<tr>
												<th scope="row" class="text-center">${count=count+1}</th>
												<td>${a.username }</td>

												<td><fmt:formatDate value="${a.dateCreate }"
														pattern="dd/MM/yyyy" /></td>

												<c:choose>
													<c:when test="${a.status=='0' }">
														<td class="account-state text-success"><span
															class="badge rounded-pill bg-secondary">Khoá</span></td>
													</c:when>
													<c:otherwise>
														<td class="account-state text-success"><span
															class="badge rounded-pill bg-success">Hoạt động</span></td>
													</c:otherwise>
												</c:choose>

												<c:choose>
													<c:when test="${a.policyId=='0'}">
														<td class="account-state text-danger">Quản lý</td>
													</c:when>

													<c:when test="${a.policyId=='2'}">
														<td class="account-state text-primary">Nhân viên</td>
													</c:when>

													<c:otherwise>
														<td class="account-state text-success">Khách hàng</td>
													</c:otherwise>
												</c:choose>

												<td class="text-center"><c:choose>

														<c:when test="${not empty a.customer and empty a.staff}">
															<a
																href="admin/customer/detail/${a.customer.customerId}.htm"><button
																	class="btn btn-outline-info btn-light btn-sm"
																	title="Chi tiết người sở hữu" data-bs-toggle="modal"
																	data-bs-target="#detail" data-bs-placement="top">
																	<i class="fa-solid fa-circle-exclamation"></i>
																</button></a>
														</c:when>

														<c:when test="${not empty a.staff and empty a.customer}">
															<a href="admin/employee/detail/${a.staff.staffId}.htm"><button
																	class="btn btn-outline-info btn-light btn-sm"
																	title="Chi tiết người sở hữu" data-bs-toggle="modal"
																	data-bs-target="#detail" data-bs-placement="top">
																	<i class="fa-solid fa-circle-exclamation"></i>
																</button></a>
														</c:when>
														<c:otherwise>
															<button disabled="disabled"
																class="btn btn-secondary btn-sm"
																title="Chi tiết người sở hữu" data-bs-toggle="modal"
																data-bs-target="#detail" data-bs-placement="top">
																<i class="fa-solid fa-circle-exclamation"></i>
															</button>
														</c:otherwise>
													</c:choose> <c:choose>
														<c:when test="${a.policyId == 2}">
															<c:choose>
																<c:when test="${a.status == 0}">
																	<a class="btnClock"
																		href="admin/account/clock/${a.username}.htm"><button
																			class="btn btn-outline-warning btn-light btn-sm"
																			title="Mở khoá tài khoản">
																			<i class="fa-solid fa-unlock"></i>
																		</button></a>
																</c:when>
																<c:otherwise>
																	<a class="btnClock"
																		href="admin/account/clock/${a.username}.htm"><button
																			class="btn btn-outline-warning btn-light btn-sm"
																			title="Khoá tài khoản">
																			<i class="fa-solid fa-lock"></i>
																		</button></a>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															<button disabled="disabled"
																class="btn btn-secondary btn-sm" title="Khoá tài khoản">
																<i class="fa-solid fa-lock"></i>
															</button>
														</c:otherwise>
													</c:choose></td>
											</tr>
										</c:if>
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

	<%@include file="./script.jsp"%>
	<!-- end common script  -->
	<script type="text/javascript">
      const toggleBtnState = function (e, classToggle) {
        e.classList.toggle(classToggle);
      };
      $(document).ready(function () {
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
                                  <form class="row g-3 mt-1" action="admin/account.htm" id="form-filter">
                                      <div class="col-12">
                                          <label for="input-birthday" class="form-label">Ngày Tạo</label>

                                          <div class="col-12 d-flex gap-1 justify-content-around align-items-stretch">
                                              <div class="input-group">
                                                  <input id="input-birthday" name="dateLeft" type="date" class="form-control" aria-label="input-birthday" aria-describedby="basic-addon1" />
                                              </div>
                                              <button type="button" class="btn btn-primary btn-sm btn-range-filter" data-bs-toggle="collapse" data-bs-target="#input-birthday-right">
                                                  Đến
                                              </button>

                                              <div class="input-group collapse" id="input-birthday-right">
                                                  <input type="date" name="dateRight" class="form-control" aria-label="input-birthday" aria-describedby="basic-addon1" />
                                              </div>
                                          </div>
                                      </div>

                                      <div class="col-md-12">
                                          <label for="gender" class="form-label">Trạng thái</label>
                                          <div class="col-md-12 d-flex">
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="status" id="filter-female" value="1"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-female">
                                                      Hoạt động
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="status" id="filter-male" value="0"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-male">
                                                      Khoá
                                                  </label>
                                              </div>
                                          </div>
                                      </div>
                                      <div class="col-md-12">
                                          <label for="status" class="form-label">Loại tài khoản</label>
                                          <div class="col-md-12 d-flex">
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="type" id="filter-allStatus" value="0"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-allStatus">
                                                      Quản lý
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="type" id="filter-status-1" value="1"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-1">
                                                  Khách hàng
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="type" id="filter-status-2" value="2"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-2">
                                                      
                                                      Nhân viên
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
        $(".btn-create").remove();
        $(".btn-filter").click(function () {
          $(".filter-block").toggleClass("show-flex");
        });
      });
    </script>

</body>
</html>