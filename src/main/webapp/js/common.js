
// //情况一:
// //当页面加载时，给名称为  删除  的链接添加一个事件。注意没说哪个页面，和页面无关。牛
// //json
// var commons = {
// 	myconfig:function(message){
// 		return window.confirm(message);
// 	}
// };
//
// //当页面加载时，给名称为  删除  的链接添加一个事件。注意没说哪个页面，和页面无关。牛
// $().ready(function(){
// 	//所有的超级链接标签
// 	$("a").each(function(){
// 		if($(this).text()=="删除"){
// 			$(this).unbind("click");
// 			$(this).bind("click",function(){
// 				return commons.myconfig("确认删除吗");
// 			});
// 		}
// 	});
// });


// //情况二:
// //通过调用jQuery对象插件
// $().ready(function() {
//     $('a').each(function() {
//         if($(this).text()==("删除")){
//             $(this).unbind("click");
//             $(this).bind("click", function(){
//                 //调用插件方法comfirm()
// 				return $(this).confirm("确认删除吗？");
//             })
//         }
//     });
// });


//情况三：
//调用全局插件
// $().ready(function() {
//     $.confirm("确定删除吗？");
// });


//情况四：添加了回调函数
// $().ready(function() {
//     $.confirm("确定删除吗？", function() {
//         alert("就是这么牛！！ 简单callback");
//     })
// });

//情况五：整合一下 数据 和 回调函数 成 json
$().ready(function() {
    $.confirm({
        message : "确定删除吗？",
        callback : function() {
            alert("就是这么牛，厉害点的回调");
        }
    });
});