$(function() {
	"use strict";
	let page = $(".page-flag").attr("data");
	var element = $(".nav-link").filter(function() {

		return this.getAttribute("data") === page
	});

	element.removeClass("collapsed");
});
