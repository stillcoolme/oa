//情况二：
//针对某个对象的插件     在common.jsp导入插件，在common.js 调用$(this).confirm("确认删除？");
// (function(jQuery){
// 	$.fn.confirm = function (message) {
// 		return window.confirm(message);
//     }
// })(jQuery);


//情况三：
//不用绑定某个元素的全局插件
// (function(jQuery){
//     $.confirm = function(message){		//全局方法confirm
// 		$("a").each(function(){
// 			if($(this).text()=="删除"){
// 				$(this).unbind("click");
// 				$(this).bind("click",function(){
// 					return window.confirm(message);
// 				});
// 			}
// 		});
// 	}
// })(jQuery);


//情况四：加了回调函数
// (function(jQuery) {
//     $.confirm = function(message, callback) {
//         $("a").each(function(){
//             if($(this).text() == '删除'){
//                 $(this).unbind('click');
//                 $(this).bind('click', function() {
//                     callback();
//                     return window.confirm(message);
//                 })
//             }
//         });
//     }
// })(jQuery);


// // 情况五：
// // 效果：点击弹出自己的页面，能做自己的事，然后再弹出提示框？
// //不用绑定某个元素的全局插件,含回调函数
(function(jQuery){
    $.confirm = function(confirmJson){
		$("a").each(function(){
			if($(this).text()=="删除"){
				$(this).unbind("click");
				$(this).bind("click",function(){
					confirmJson.callback();
					return window.confirm(confirmJson.message);
				});
			}
		});
	}
})(jQuery);
