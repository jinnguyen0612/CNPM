if ($(".alert-flag").attr("aType")) {
	alertify.notify($(".alert-flag").attr("aMessage"), $(".alert-flag").attr("aType"), 4, function() { console.log('dismissed'); });
	alertify.set('notifier', 'position', 'top-right');
}