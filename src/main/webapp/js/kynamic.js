var kynamic = {
    //树的操作
    kynamicTree:{
        pNode:'',			//全局变量！！
        zTree:'',
        setting:{
            isSimpleData: true,
            treeNodeKey: "kid",
            treeNodeParentKey: "pid",
            showLine: true,
            root: {
                isRoot: true,
                nodes: []
            },
            callback:{
                rightClick:function(event,treeId,treeNode){			//右键事件
                    //在点击右键的时候，把treeNode赋值给pNode！！！在下面的addFloder方法就可以用了。
                    kynamic.kynamicTree.pNode = treeNode;
                    //判断点击的是文件夹节点还是文件节点
                    if(treeNode.isParent){
                        kynamic.kynamicTree.controlRMenu({
                            x:event.clientX,
                            y:event.clientY,
                            addNode:true,
                            addFloder:true,
                            deleteNode:true,
                            updateNode:true
                        });
                    }else{
                        kynamic.kynamicTree.controlRMenu({
                            x:event.clientX,
                            y:event.clientY,
                            addNode:true,
                            addFloder:false,
                            deleteNode:true,
                            updateNode:true
                        });
                    }
                },
                click : function (event, treeId, treeNode) {
                    kynamic.kynamicTree.pNode = treeNode;
                    var parameter = {
                        kid : kynamic.kynamicTree.pNode.kid
                    }
                    $.post("kynamicAction_showVersionsByKid.action", parameter, function(data) {
                        if (data.versionList.length == 0) {//没有版本
                            kynamic.version.showContent({
                                 //"vid" : ,
                                 "title" : "",
                                 "content" : "",
                                 "versionList" : ""
                            });

                        }else {
                            //控制div和checkin和checkout按钮的显示，所以又是传json来做控制  !!!
                            kynamic.version.controlShowVersion({
                                addVersion: false,
                                versionList: true,
                                checkin: false,
                                checkout: false
                            });
                            kynamic.version.showVersionsByKid(data.versionList);
                        }
                    });
                }
            }
        },  //setting
        //加载树
        loadKynamicTree:function(){
            $.post("kynamicAction_showKynamicTree.action",null,function(data){
                kynamic.kynamicTree.zTree = $("#kynamicTree").zTree(kynamic.kynamicTree.setting,data.kynamicList);
                //给zTree赋值了，后面的右键菜单就可以使用addNodes方法
            });
        },

        //控制右键菜单显示。  传的参数: div位置；右键菜单选项
        controlRMenu:function(rMenuJson){		//这样传参
            //菜单项的显示逻辑
            $("#showRMenu").show();

            $("#rMenu").css({"top":rMenuJson.y+"px","left":rMenuJson.x+"px","display":"block"});
            if(rMenuJson.addNode){
                $("#addNode").show();
            }else{
                $("#addNode").hide();
            }

            if(rMenuJson.addFloder){
                $("#addFloder").show();
            }else{
                $("#addFloder").hide();
            }

            if(rMenuJson.deleteNode){
                $("#deleteNode").show();
            }else{
                $("#deleteNode").hide();
            }

            if(rMenuJson.updateNode){
                $("#updateNode").show();
            }else{
                $("#updateNode").hide();
            }

        },
        //这些右键菜单事件要在哪里声明，触发？？
        addNode : function(addJson){
            /**
             * 1、在kynamic表中增加一行数据
             * 2、在指定的父节点下增加一个子节点
             */
            var nodeName = window.prompt(addJson.fileMessage);
            if(nodeName != null){
                if(nodeName != ""){
                    //重名判断，nodeName通过模型驱动接收。
                    $.post("kynamicAction_existKynamicName.action",{name:nodeName}, function(data){
                        if(data.message=="1"){	//存在重名
                            alert("已存在重名的节点，请重新创建");
                        }else{
                            var parameter = {
                                name : nodeName,
                                isParent : addJson.isParent,
                                pid : kynamic.kynamicTree.pNode.kid
                            };
                            $.post("kynamicAction_saveKynamic.action",parameter,function(data){
                                if(data.message == "操作成功"){
                                    var newNodes = {
                                        kid : data.kid,
                                        pid : kynamic.kynamicTree.pNode.kid,
                                        isParent : addJson.isParent,
                                        name : nodeName
                                    };
                                    kynamic.kynamicTree.zTree.addNodes(kynamic.kynamicTree.pNode, newNodes, false);
                                    alert(data.message);
                                }else{
                                    alert(addJson.errorMessage);
                                }
                            });
                        }
                    });
                }else{
                    alert("输入不能为空");
                }
            }

        },
        //任何计算机问题都可以通过增加一个中间层来解决
        addFile : function () {
            kynamic.kynamicTree.addNode({
                fileMessage: '请输入文件的名称',
                errorMessage: '文件的名称不能为空',
                isParent: false
            });
        },
        addFloder:function(){
            kynamic.kynamicTree.addNode({
                fileMessage: '请输入文件夹的名称',
                errorMessage: '文件夹的名称不能为空',
                isParent: true
            });
        },
        deleteNode:function(){
            /**
             * 1、判断当前删除的节点是否是文件节点
             *     是
             *         直接删除
             *     否
             *         判断文件夹节点下是否有子节点
             *             如果没有
             *                  删除
             *             如果有
             *                  提示不能删除
             */
            if(kynamic.kynamicTree.pNode.isParent){
                if (kynamic.kynamicTree.zTree.getNodeByParam("pid", kynamic.kynamicTree.pNode.kid)) {
                    alert("该节点存在子节点，不能删除！");
                }else{
                    if (window.confirm("您确认要删除吗?")) {
                        var parameter = {
                            kid: kynamic.kynamicTree.pNode.kid
                        };
                        //由于删除了没有兄弟节点的节点后，其父节点会变成文件节点，所以要先判断是否有兄弟节点。
                        //这整个保持父节点的功能其实可以通过ztree的keepParent来弄，但那样太简单了吧，锻炼不了人。
                        //判断该节点是否有兄弟节点
                        $.post("kynamicAction_showSiblingNodes.action", parameter, function (data) {
                            if (data.kynamicList.length < 2) {//没有兄弟节点
                                $.post("kynamicAction_showParentNode.action", parameter, function (data2) {
                                    var pNode = kynamic.kynamicTree.zTree.getNodeByParam("kid", data2.kynamic.kid);
                                    $.post("kynamicAction_deleteNode.action", parameter, function (data3) {
                                        if (data3.message == "操作成功") {
                                            kynamic.kynamicTree.zTree.removeNode(kynamic.kynamicTree.pNode);
                                            pNode.isParent = true;
                                            kynamic.kynamicTree.zTree.refresh();
                                            alert(data3.message);
                                        } else {
                                            alert("删除失败，请重试");
                                        }
                                    });
                                });
                            } else {
                                //有兄弟节点的情况
                                $.post("kynamicAction_deleteNode.action", parameter, function (data3) {
                                    kynamic.kynamicTree.zTree.removeNode(kynamic.kynamicTree.pNode);
                                    //更新父节点的isParent的属性为true
                                    alert(data3.message);
                                });
                            }

                        });
                    }
                }
            }else {//文件节点
                if (window.confirm("您确认要删除吗?")) {
                    var parameter = {
                        kid: kynamic.kynamicTree.pNode.kid
                    };
                    //判断该节点是否有兄弟节点
                    $.post("kynamicAction_showSiblingNodes.action", parameter, function(data){
                        if (data.kynamicList.length < 2) {//没有兄弟节点
                            //kynamic.kynamicTree.zTree.getNodeByParam("kid",kynamic.kynamicTree.pNode.pid);
                            $.post("kynamicAction_showParentNode.action", parameter, function(data2){
                                var pNode = kynamic.kynamicTree.zTree.getNodeByParam("kid", data2.kynamic.kid);//获取父节点
                                $.post("kynamicAction_deleteNode.action", parameter, function(data3){
                                    kynamic.kynamicTree.zTree.removeNode(kynamic.kynamicTree.pNode);
                                    //更新父节点的isParent的属性为true
                                    pNode.isParent = true;
                                    kynamic.kynamicTree.zTree.refresh();
                                    alert(data3.message);
                                });
                            });
                        }
                        else {
                            $.post("kynamicAction_deleteNode.action", parameter, function(data3){
                                kynamic.kynamicTree.zTree.removeNode(kynamic.kynamicTree.pNode);
                                alert(data3.message);
                            });
                        }
                    });
                }
            }
        },
        updateNode:function(){
            var newName = window.prompt("请重新输入名称", kynamic.kynamicTree.pNode.name);
            var pararmeter = {
                name: newName
            };
            var para = {
                kid:kynamic.kynamicTree.pNode.kid,
                name:newName
            };
            $.post("kynamicAction_isExsitName.action", pararmeter, function(data){
                if (data.message == "1") {//重名了
                    alert("该文件名称已经存在，请重新输入");
                }else{//进行修改
                    $.post("kynamicAction_updateKynamic.action",para,function(data2){
                        kynamic.kynamicTree.pNode.name = newName;
                        kynamic.kynamicTree.zTree.refresh();
                    });
                }
            });


        }

    },

    //版本控制
    version:{
        showVersionsByKid:function(versionList){	//显示version列表，列表要自己拼接。
            /**拼接出以下  一行三列
             <tr>
             <td height="26" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:1px solid #f3f8fd;"><a>1</a></td>
             <td align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:1px solid #f3f8fd;">2010-5-24 09:56:33</td>
             <td align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:1px solid #f3f8fd;"><a>删除</a></td>
             </tr>
             */

            $("#showVersion").empty();   //把上次加载的版本列表清空
            for(var i=0; i<versionList.length; i++){

                (function(){
					var version = versionList[i].version;
					var updateTime = versionList[i].updatetime;
                    var title = versionList[i].title;
                    var content = versionList[i].content;

                    //先拼接<a>
					var $versionA = $("<a/>");
					$versionA.text(version);
					$versionA.css("cursor","pointer");

					$versionA.unbind("click");						//原来这样啊，给某个按钮加个点击事件
					$versionA.bind("click",function(){
						//alert(version);
                        //显示这个版本的内容。
                        kynamic.version.showContent({
                            "vid" : version,
                            "title" : title,
                            "content" : content,
                            "versionList" : versionList
                        });
					});

                    //下面三列数据 三个td
					var $versionTD = $("<td/>");
					$versionTD.attr("height","26");
					$versionTD.attr("align","center");
					$versionTD.attr("valign","middle");
					$versionTD.attr("bgcolor","#FFFFFF");
					$versionTD.attr("style","border-bottom:1px solid #f3f8fd;");
					$versionTD.append($versionA);

					var $updateTimeTD = $("<td/>");
					$updateTimeTD.attr("height","26");
					$updateTimeTD.attr("align","center");
					$updateTimeTD.attr("valign","middle");
					$updateTimeTD.attr("bgcolor","#FFFFFF");
					$updateTimeTD.attr("style","border-bottom:1px solid #f3f8fd;");
					$updateTimeTD.append(updateTime);

					var $deleteA = $("<a/>");
					$deleteA.append("删除");
					var $deleteTD = $("<td/>");
					$deleteTD.attr("height","26");
					$deleteTD.attr("align","center");
					$deleteTD.attr("valign","middle");
					$deleteTD.attr("bgcolor","#FFFFFF");
					$deleteTD.attr("style","border-bottom:1px solid #f3f8fd;");
					$deleteTD.append($deleteA);

                    $deleteA.unbind("click");
                    $deleteA.bind("click",  function () {
                        kynamic.version.deleteVersion.call(this);
                    })

					var $TR = $("<tr/>");

					$TR.append($versionTD);
					$TR.append($updateTimeTD);
					$TR.append($deleteTD);

					$("#showVersion").append($TR);

				})();
            }

        },
        controlShowVersion:function(versionShowJson){       //控制树的右边随你点击的不同显示不同东西。
            if(versionShowJson.versionList){
                $("#versionList").show();
            }else{
                $("#versionList").hide();
            }

            if (versionShowJson.addVersion) {
                $("#addVersion").show();
            }
            else {
                $("#addVersion").hide();
            }

            if (versionShowJson.checkin) {
                $("#checkin").show();
            }
            else {
                $("#checkin").hide();
            }

            if (versionShowJson.checkout) {
                $("#checkout").show();
            }
            else {
                $("#checkout").hide();
            }
        },
        /**
         * 点击某一个版本号，显示具体的title和content的内容
         */
        showContent:function(showContentJson){
            //将列表隐藏，将该版本信息显示
            kynamic.version.controlShowVersion({
                addVersion: true,
                versionList: false,
                checkin: true,
                checkout: true
            });
            $("input[name='title']").val(showContentJson.title);
            $("textarea[name='content']").val(showContentJson.content);

            //绑定checkin checkout 事件
            $("#checkin").unbind("click");
            $("#checkin").bind("click", function () {
                kynamic.version.checkin.call(this);   //this 就是 checkin按钮
            });
            $("#checkout").unbind("click");
            $("#checkout").bind("click", function () {
                kynamic.version.checkout(showContentJson.versionList);
            });
        },
        /**
         * 删除某一个版本
         */
        deleteVersion:function(){
            //页面里面怎么删除： 找父节点的父节点来干掉自己的子节点
            var vid  = $(this).parent().siblings("td:first").text();
            var parameter = {
                "vid" : vid
            }
            $.post("kynamicAction_deleteVersionByVid.action", parameter, function (data) {
                if(data.message == "操作成功"){
                    $(this).parent().parent().children("td").remove();
                    return null;
                }else{
                    alert("操作失败");
                }

            });
        },
        checkin:function(){
            /**
             * 通过checkin操作生成一个新的版本号
             *     如果该节点没有版本号
             *         那么新的版本号为1
             *     如果该节点有版本号
             *         版本号为原来的最高版本+1
             */
            //获得当前的节点
            var kid = kynamic.kynamicTree.pNode.kid;
            var title = $("input[name='title']").val();
            var content = $("textarea[name='content']").attr("value");
            var parameter = {
                "kid" : kid,
                "title" : title,
                "content" : content
            };
            $.post("kynamicAction_saveVersionBykid.action", parameter, function (data) {
                if(data.message == "操作成功"){
                    //如果成功返回列表，这就要查一遍了吧？
                    var parameter2 = {
                        "kid" : kid
                    }
                    $.post("kynamicAction_showVersionsByKid.action", parameter, function(data) {
                        //控制div和checkin和checkout按钮的显示，所以又是传json来做控制  !!!
                        kynamic.version.controlShowVersion({
                            addVersion: false,
                            versionList: true,
                            checkin: false,
                            checkout: false
                        });
                        kynamic.version.showVersionsByKid(data.versionList);
                    });

                }else {
                    alert("保存错误");
                }
            });
        },
        //返回刚刚的版本列表
        checkout:function(versionList){
            //控制div和checkin和checkout按钮的显示，所以又是传json来做控制  !!!
            kynamic.version.controlShowVersion({
                addVersion: false,
                versionList: true,
                checkin: false,
                checkout: false
            });
            kynamic.version.showVersionsByKid(versionList);
        }
    }

};


$().ready(function(){
    kynamic.kynamicTree.loadKynamicTree();

    //鼠标移出右键菜单，菜单消失
    $("#rMenu").hover(function(){			//hover在这里仅仅是用于声明事件，事件函数中的内容到底是否执行，根据触发的时候判断
        //声明右键菜单functiono，增删改查
        $("#addFile").unbind("click");
        $("#addFile").bind("click",function(){
            //alert("addNode")
            kynamic.kynamicTree.addFile();
        });

        $("#addFloder").unbind("click");
        $("#addFloder").bind("click",function(){
            //alert("addFloder")
            kynamic.kynamicTree.addFloder();
        });

        $("#updateNode").unbind("click");
        $("#updateNode").bind("click",function(){
            //alert("updateNode")
            kynamic.kynamicTree.updateNode();
        });

        $("#deleteNode").unbind("click");
        $("#deleteNode").bind("click",function(){
            //alert("deleteNode")
            kynamic.kynamicTree.deleteNode();
        });


    },function(){
        //当该方法被触发的时候，树早已经存在了，右键菜单已经显示了！！！
        $("#rMenu").hide();
    });

});

