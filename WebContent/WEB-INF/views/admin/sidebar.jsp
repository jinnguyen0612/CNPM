<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<aside id="sidebar" class="sidebar">
	<ul class="sidebar-nav" id="sidebar-nav">
		<li class="nav-item"><a class="nav-link collapsed" data="index"
			href="admin/index.htm"> <i class="bi bi-grid"></i> <span>Trang
					chủ</span>
		</a></li>
		<li class="nav-item"><a class="nav-link collapsed"
			data="schedule" data-bs-target="#pt" href="admin/schedule.htm"> <i
				class="fa-light fa-ballot"></i><span>Khách Tập</span>
		</a></li>

		<c:if test="${admin.policyId == '0'}">
			<!-- End Dashboard Nav -->
			<li class="nav-item"><a class="nav-link collapsed"
				data="account" data-bs-target="#account" href="admin/account.htm">
					<i class="fa-light fa-file-user"></i><span>Tài Khoản</span>
			</a></li>
			<!-- End Employee Nav -->
			<li class="nav-item"><a class="nav-link collapsed" data="staff"
				data-bs-target="#employee" href="admin/employee.htm"> <i
					class="fa-light fa-user"></i><span>Nhân Viên</span>
			</a></li>
			<!-- End Employee Nav -->

			<li class="nav-item"><a class="nav-link collapsed" data="PT"
				data-bs-target="#pt" href="admin/personal-trainer.htm"> <i
					class="fa-light fa-dumbbell"></i><span>Huấn luyện viên</span>
			</a></li>
		</c:if>



		<!-- End PT Nav -->
		<li class="nav-item"><a class="nav-link collapsed" data="pack"
			data-bs-target="#package" data-bs-toggle="collapse" href="#"> <i
				class="bi bi-bag"></i><span>Gói Tập</span><i
				class="bi bi-chevron-down ms-auto"></i>
		</a>
			<ul id="package" class="nav-content collapse"
				data-bs-parent="#sidebar-nav">
				<li><a href="admin/package/type.htm"> <i
						class="bi bi-circle"></i><span>Loại gói tập</span>
				</a></li>
				<li><a href="admin/package.htm"> <i class="bi bi-circle"></i><span>Danh
							Sách Gói Tập</span>
				</a></li>
			</ul></li>
		<!-- End Employee Nav -->
		<li class="nav-item"><a class="nav-link collapsed" data="class"
			data-bs-target="#class" href="admin/class.htm"> <i
				class="fa-light fa-screen-users"></i><span>Lớp</span>
		</a></li>
		<!-- End Employee Nav -->
		<li class="nav-item"><a class="nav-link collapsed"
			data-bs-target="#customer" data="customer" data-bs-toggle="collapse"
			href="#"> <i class="bi bi-people"></i><span>Khách Hàng</span><i
				class="bi bi-chevron-down ms-auto"></i>
		</a>
			<ul id="customer" class="nav-content collapse"
				data-bs-parent="#sidebar-nav">
				<li><a href="admin/customer.htm"> <i class="bi bi-circle"></i><span>Danh
							Sách Khách Hàng</span>
				</a></li>
				<li><a href="admin/contract-registration.htm"> <i
						class="bi bi-circle"></i><span>Thông Tin Đăng Ký</span>
				</a></li>
			</ul></li>
		<!-- End Customer Nav -->

		<li class="nav-item"><a class="nav-link collapsed"
			href="admin/logout.htm"> <i class="bi bi-box-arrow-left"></i> <span>Đăng
					xuất</span>
		</a></li>
	</ul>
</aside>