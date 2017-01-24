(function(e) {
	e.fn.checkTree = function(t) {
		t = e.extend({
			onExpand : null,
			onCollapse : null,
			onCheck : null,
			onUnCheck : null,
			onHalfCheck : null,
			onLabelHoverOver : null,
			onLabelHoverOut : null,
			labelAction : "expand",
			attrHalfChecked : "checked",
			collapseAll : false,
			debug : false
		}, t);
		var n = this;
		n.clear = function() {
			n.find(":checkbox").attr("checked", "")
		};
		n.update = function() {
			n.find("li").each(function() {
				var t = e(this).children(".checkbox");
				if (e(this).children(":checkbox").attr("checked")) {
					t.addClass("checked")
				} else {
					t.removeClass("checked")
				}
			});
			n.find("li").each(
					function() {
						if (e(this).is(":has(ul)")) {
							var n = e(this).children(".checkbox");
							var r = e(this).contents().find(".checkbox");
							var i = e(this).contents().find(".checked");
							if (i.length == 0) {
								n.removeClass("checked half_checked").siblings(
										":checkbox").attr("checked", "")
							} else if (r.length == i.length) {
								n.removeClass("half_checked").addClass(
										"checked").siblings(":checkbox").attr(
										"checked", "checked")
							} else {
								n.removeClass("checked").addClass(
										"half_checked").siblings(":checkbox")
										.attr("checked", t.attrHalfChecked)
							}
						}
					})
		};
		n
				.find("li")
				.find(":checkbox")
				.change(
						function() {
							var n = e(this).siblings("ul").find(":checkbox");
							var r = n.filter(":checked");
							if (n.length == r.length) {
								e(this).attr("checked", "checked").siblings(
										".checkbox")
										.removeClass("half_checked").addClass(
												"checked");
								if (t.onCheck)
									t.onCheck(e(this).parent())
							} else if (r.length == 0) {
								e(this).attr("checked", "").siblings(
										".checkbox").removeClass("checked")
										.removeClass("half_checked");
								if (t.onUnCheck)
									t.onUnCheck(e(this).parent())
							} else {
								if (t.onHalfCheck
										&& !e(this).siblings(".checkbox")
												.hasClass("half_checked")) {
									t.onHalfCheck(e(this).parent())
								}
								e(this).attr("checked", t.attrHalfChecked)
										.siblings(".checkbox").removeClass(
												"checked").addClass(
												"half_checked")
							}
						})
				.hide()
				.end()
				.each(
						function() {
							if (t.collapseAll) {
								e(this).find("ul").each(function() {
									if (!e(this).siblings(".expanded").length)
										e(this).hide()
								})
							}
							var n = e(this).children("label").clone();
							var r = e('<div class="checkbox"></div>');
							var i = e('<div class="arrow"></div>');
							if (e(this).is(":has(ul)")) {
								if (e(this).children("ul").is(":hidden"))
									i.addClass("collapsed");
								else
									i.addClass("expanded");
								i.click(function() {
									e(this).siblings("ul").toggle();
									if (e(this).hasClass("collapsed")) {
										e(this).addClass("expanded")
												.removeClass("collapsed");
										if (t.onExpand)
											t.onExpand(e(this).parent())
									} else {
										e(this).addClass("collapsed")
												.removeClass("expanded");
										if (t.onCollapse)
											t.onCollapse(e(this).parent())
									}
								})
							}
							r
									.click(function() {
										e(this)
												.toggleClass("checked")
												.removeClass("half_checked")
												.siblings(":checkbox")
												.attr(
														"checked",
														e(this).hasClass(
																"checked") ? "checked"
																: "");
										if (e(this).hasClass("checked")) {
											if (t.onCheck)
												t.onCheck(e(this).parent());
											e(this)
													.siblings("ul")
													.find(".checkbox")
													.not(".checked")
													.removeClass("half_checked")
													.addClass("checked")
													.each(
															function() {
																if (t.onCheck)
																	t
																			.onCheck(e(
																					this)
																					.parent())
															}).siblings(
															":checkbox").attr(
															"checked",
															"checked")
										} else {
											if (t.onUnCheck)
												t.onUnCheck(e(this).parent());
											e(this).siblings(":checkbox")
													.removeAttr("checked");
											e(this)
													.siblings("ul")
													.find(".checkbox")
													.filter(".checked")
													.removeClass("half_checked")
													.removeClass("checked")
													.each(
															function() {
																if (t.onUnCheck) {
																	t
																			.onUnCheck(e(
																					this)
																					.parent());
																	alert("enterd");
																	e(this)
																			.parent()
																			.siblings(
																					":checkbox")
																			.removeAttr(
																					"checked")
																}
															}).siblings(
															":checkbox")
													.removeAttr("checked")
										}
										e(this).parents("ul").siblings(
												":checkbox").change();
										if (e(this).siblings("ul").find(
												":checkbox").length == 0) {
											if (e(this).hasClass("checked")) {
												e(this).closest("li").siblings(
														"li:first-child").find(
														":checkbox").change()
											}
										}
									});
							if (e(this).children(".checkbox").hasClass(
									"checked"))
								r.addClass("checked");
							else if (e(this).children(":checkbox").attr(
									"checked")) {
								r.addClass("checked");
								e(this).parents("ul").siblings(":checkbox")
										.change()
							} else if (e(this).children(".checkbox").hasClass(
									"half_checked")) {
								r.addClass("half_checked")
							}
							e(this).children(".arrow").remove();
							e(this).children(".checkbox").remove();
							e(this).children("label").remove();
							e(this).prepend(n).prepend(r).prepend(i)
						}).find("label").click(function() {
					var n = t.labelAction;
					switch (t.labelAction) {
					case "expand":
						e(this).siblings(".arrow").click();
						break;
					case "check":
						e(this).siblings(".checkbox").click();
						break
					}
				}).hover(function() {
					e(this).addClass("hover");
					if (t.onLabelHoverOver)
						t.onLabelHoverOver(e(this).parent())
				}, function() {
					e(this).removeClass("hover");
					if (t.onLabelHoverOut)
						t.onLabelHoverOut(e(this).parent())
				}).end();
		return n
	}
})(jQuery)