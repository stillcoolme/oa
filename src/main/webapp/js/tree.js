/**
 * 点击事件加载
 *   * 第一步： 加载根节点
 *   * 第二步： 点击该节点的+号，触发事件，加载该节点的子节点
 */

var tree = {
	zTree:'',	//tips: js就不要var 那么多全局变量来传参数了，不然会很慢的。像这样弄个json传参数就能给json里面的函数用了
	pNode:'',	
    setting:{
        isSimpleData: true,
        treeNodeKey: "mid",
        treeNodeParentKey: "pid",
        showLine: true,
        root: {
            isRoot: true,
            nodes: []
        },
        callback:{	//怎么知道人家这么写呢，find jquery-ztree-2.5.js源码啊,,点击加号触发expand事件
        	 /**
             * @param {Object} event
             *     鼠标事件
             * @param {Object} treeId
             *     树的容器ID
             * @param {Object} treeNode
             *     当前点击的节点
             */
        	expand:function(event,treeId,treeNode){
        		//alert("aa");
        		tree.pNode = treeNode;			//定义一个pNode 来传递参数
                tree.loadNodeByPNODE();			//加载子节点
        	}
        }
    },
    loadTree: function(){				//这个就加载树
        $.post("menuitemAction_getAllMenuitem.action", 
        		null, 
        		function(data){
        			$("#tree").zTree(tree.setting, data.menuitemList);
                }
              );
    },
    loadRootNode: function(){
        var parameter = {
            pid: 0
        };
        $.post("menuitemAction_showMenuitemsByPid.action", parameter, function(data){	//这function事件(回调函数)由服务器触发
        /*
        	tips：两年经验的错误：一般情况下，如果一段代码中要用到某个变量，而这个变量是在回调函数里负责的，比如下面的tree.Ztree 一定要确保执行你的代码时，回调函数已经执行了
        	因为后面要加载其节点的子节点，要用到tree.zTree属性，所以只要在tree对象中设置一个属性
           	那么只要在该json对象中，tree.zTree都能访问
		*/
        	tree.zTree = $("#tree").zTree(tree.setting, data.menuitemList);
        });
    },
    loadNodeByPNODE: function(){
        var parameter = {
            pid: tree.pNode.mid
        };
        //if (!tree.zTree.getNodeByParam("pid", tree.pNode.mid)) {  //判断点击的节点是否有子节点，没就加载
        	
            $.post("menuitemAction_showMenuitemsByPid.action", parameter, function(data){
              //把查询出来的子节点追加到父节点上,为什么会知道用下面这个方法？去查api啊你妹的。
              tree.zTree.addNodes(tree.pNode, data.menuitemList, true);
            });
            /* tips:这个变量tree.zTree用的时候，你他妈怎么知道它已经被赋值了呢?
             * loadNodeByPNode该方法是在点击父节点的+号的时候执行的，这就意味着在执行该方法的时候，
             * 树早已经生成了,tree.zTree = $("#tree").zTree(tree.setting, data.menuitemList);所以才能用tree.zTree;
            */
        //}
    }
};

/**
 * 1、回调函数是由服务器端触发的，什么时候执行由服务器决定
 * 2、回调函数是由jQuery内核调用的
 * 3、客户端存在两个线程
 * 4、如果在js代码中，有一些代码要用到回调函数中的数据，那么这些代码必须放在回调函数中
 */
$().ready(function(){
    //一次加载树
	tree.loadTree();

    //点击加载树
	//tree.loadRootNode();
	//tree.loadNodeByPNODE();
});



