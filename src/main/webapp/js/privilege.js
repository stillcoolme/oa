var privilege = {
	init : {
		initEvent : function () {
			$("a").each(function () {
				if($(this).text() == "设置权限"){
					$(this).unbind("click");
					$(this).bind("click", function () {
						privilege.init.initData.call(this);
						privilege.pFunction.divOption.showDiv();//显示所有的div
						privilege.pFunction.userOption.showUsername();  //动态的显示用户名
						privilege.pFunction.privilegeTree.loadPrivilegeTree();//加载权限树
						return false;
					});
				}
			});
			
			$("#allchecked").unbind("click");
			$("#allchecked").bind("click", function(){
				privilege.pFunction.privilegeTree.checkAll.call(this);  //就变成现在点击的#allchecked来调用checkAll方法。
			});
			
			$("#savePrivilege").unbind("click");
			$("#savePrivilege").bind("click", function () {
				privilege.pFunction.privilegeTree.savePrivilege();
			})

		},
		initData : function () {
			var username = $(this).parent().siblings("td:first").text();
			var uid = $(this).parent().siblings("input[type='hidden']:first").val();
			privilege.data.user.uid = uid;
			privilege.data.user.username = username;
		}
	},
	pFunction : {
		privilegeTree : {
			zTree : "",
			setting : {
				isSimpleData: true,
				treeNodeKey: "mid",
				treeNodeParentKey: "pid",
				showLine: true,
				root: {
					isRoot: true,
					nodes: []
				},
				checkable: true,
				checkType: {
					"Y": "ps",
					"N": "s"
				},
				callback : {
					/**
					 * 在点击树上的复选框之前触发该方法
					 * @param {Object} treeId
					 * @param {Object} treeNode
					 */
					beforeChange: function(treeId, treeNode){
						privilege.pFunction.privilegeTree.controlCheckBox({
							"Y": "ps",
							"N": "s"
						});
					},
					change: function(treeId, treeNode){
						if (privilege.pFunction.privilegeTree.zTree.getCheckedNodes(false).length!=0) {//获取到没有选中的
							$("#allchecked").attr("checked", false);
						}
						else {
							$("#allchecked").attr("checked", true);
						}
					}
				}
			},
			loadPrivilegeTree : function(){
				var parameter =  {
					"uid" : privilege.data.user.uid
				};
				$.post("privilegeAction_showPrivilege.action", parameter, function (data) {
						privilege.pFunction.privilegeTree.zTree = $("#privilegeTree").zTree(privilege.pFunction.privilegeTree.setting, data.privilegeList);
						/**
						 * 这里是设置全选按钮默认状态的最佳位置
						 *    *  默认值必须在点击设置权限的超级链接中设置
						 *    *  确保zTree必须有值才行 ！！！！
						 */
						if(privilege.pFunction.privilegeTree.zTree.getCheckedNodes(false)){
							$("#allchecked").attr("checked", false);
						}else{
							$("#allchecked").attr("checked", true);
						}

				});
			},
			controlCheckBox : function (checktype) {
				var setting = privilege.pFunction.privilegeTree.zTree.getSetting();
				setting.checkType = checktype;
				privilege.pFunction.privilegeTree.zTree.updateSetting(setting);
			},
			checkAll : function () {
				/**
				 * 改变树上的复选框的选中规则
				 *    在执行该函数的时候，zTree已经存在了
				 */
				/**
				 * 改变zTree中复选框的规则
				 */
				privilege.pFunction.privilegeTree.controlCheckBox({
					"Y":"ps",
					"N":"ps"
				});
				if ($(this).attr("checked")) {//全选
					privilege.pFunction.privilegeTree.zTree.checkAllNodes(true);
				}
				else {//全不选
					privilege.pFunction.privilegeTree.zTree.checkAllNodes(false);
				}
			},
			savePrivilege : function () {
				var checkedNodes = privilege.pFunction.privilegeTree.zTree.getCheckedNodes(true);
				var mids = "";
				for(var i=0;i<checkedNodes.length;i++){
					if(i<checkedNodes.length-1){
						mids = mids+checkedNodes[i].mid+",";
					}else{
						mids = mids+checkedNodes[i].mid;
					}
				}
				var parameter = {
					uid:privilege.data.user.uid,
					mids:mids
				};
				$.post("privilegeAction_savePrivilege.action", parameter, function () {
					alert("保存成功");
				});
			}
		},
		userOption : {
			showUsername : function () {
				$("#userImage").text(privilege.data.user.username);
			}
		},
		divOption : {
			showDiv : function () {
				$("#userTitle").show();
				$("#privilegeTitle").show();
				$("#privilegeContent").show();

			}
		}
	},
	data :  {
		user : {
			uid : "",
			username : ""
		}
	}
}

$().ready(function () {
	privilege.init.initEvent();
})