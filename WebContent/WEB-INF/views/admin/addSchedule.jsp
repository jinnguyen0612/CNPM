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
						



<div class="modal fade" id="time-table" tabindex="-1">
			<div class="modal-dialog modal-xl modal-dialog-centered">
				<div class="modal-content">
					<section class="section">
						<div class="row">
							<div class="col-lg-12">
								<div class="card mb-0">
									<div class="card-body">
										<h5
											class="card-title align-items-center d-flex justify-content-between">
											Thời Khoá Biểu
											<div class="header-action d-flex gap-1">
												<button type="button" class="btn btn-primary"
													data-bs-target="#modal-class"
													data-bs-toggle="modal">
													Xác nhận</button>

												<div class="search-bar-table d-flex align-items-stretch">
													<div class="">
														<button type="button" class="btn btn-secondary btn-search"
															data-bs-target="#modal-class"
															data-bs-toggle="modal">
															Huỷ bỏ</button>
													</div>

													<div class="">
														<button type="button" class="btn btn-secondary btn-filter">
															Cài lại</button>
													</div>
												</div>
											</div>
										</h5>

										<!-- Table with stripped rows -->
										<from class="my-time-table">
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
														<td class="td-time-table"><input type="radio" form="class"
															name="T2" id="T2-M" value="0" class="form-check-input" />
															<label for="T2-M"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T3" id="T3-M" value="0" class="form-check-input" />
															<label for="T3-M"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T4" id="T4-M" value="0" class="form-check-input" />
															<label for="T4-M"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T5" id="T5-M" value="0" class="form-check-input" />
															<label for="T5-M"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T6" id="T6-M" value="0" class="form-check-input" />
															<label for="T6-M"></label></td>

														<td class="td-time-table"><input type="radio" form="class"
															name="T7" id="T7-M" value="0" class="form-check-input" />
															<label for="T7-M"></label></td>

														<td class="td-time-table"><input type="radio" form="class"
															name="T8" id="T8-M" value="0" class="form-check-input" />
															<label for="T8-M"></label></td>
													</tr>

													<tr>
														<td class="align-middle bg-light">Chiều</td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T2" id="T2-A" value="1" class="form-check-input" />
															<label for="T2-A"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T3" id="T3-A" value="1" class="form-check-input" />
															<label for="T3-A"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T4" id="T4-A" value="1" class="form-check-input" />
															<label for="T4-A"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T5" id="T5-A" value="1" class="form-check-input" />
															<label for="T5-A"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T6" id="T6-A" value="1" class="form-check-input" />
															<label for="T6-A"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T7" id="T7-A" value="1" class="form-check-input" />
															<label for="T7-A"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T8" id="T8-A" value="1" class="form-check-input" />
															<label for="T8-A"></label></td>
													</tr>

													<tr>
														<td class="align-middle bg-light">Tối</td> 
														<td class="td-time-table"><input type="radio" form="class"
															name="T2" id="T2-E" value="2" class="form-check-input" />
															<label for="T2-E"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T3" id="T3-E" value="2" class="form-check-input" />
															<label for="T3-E"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T4" id="T4-E" value="2" class="form-check-input" />
															<label for="T4-E"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T5" id="T5-E" value="2" class="form-check-input" />
															<label for="T5-E"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T6" id="T6-E" value="2" class="form-check-input" />
															<label for="T6-E"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T7" id="T7-E" value="2" class="form-check-input" />
															<label for="T7-E"></label></td>
														<td class="td-time-table"><input type="radio" form="class"
															name="T8" id="T8-E" value="2" class="form-check-input" />
															<label for="T8-E"></label></td>
													</tr>
												</tbody>
											</table>
										</div>
										</from>
										<!-- End Table with stripped rows -->
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
		
					</div>
				</div>
			</div>
		</section>		