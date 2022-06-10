$(document).ready(function() {
	$("button[name='btnUpdate']").click(function(e) {

		if (!confirm("Xác nhận cập nhật")) {
			e.preventDefault();
		}
	})

	$(".btnClock").click(function(e) {
		if (!confirm("Xác nhận khoá tài khoản")) {
			e.preventDefault();
		}

	})
}
)