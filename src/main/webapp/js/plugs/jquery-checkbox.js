(function(jQuery){
	$.fn.controlCheckBox = function(checkname){		//非全局插件

		if($(this).attr("checked")){
			$("input[name='"+checkname+"']").attr("checked",true);
		}else{
			$("input[name='"+checkname+"']").attr("checked",false);
		}
	}
})(jQuery);