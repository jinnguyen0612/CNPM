$(function() {
	"use strict";
	var url = window.location + "";
	var path = url.replace(
		window.location.protocol + "//" + window.location.host + "/",
		""
	);
	let page = $(".page-flag").attr("data");
	console.log(page)
	var element = $(".nav-link").filter(function() {

		return this.getAttribute("data") === page
	});

	element.removeClass("collapsed");
});
