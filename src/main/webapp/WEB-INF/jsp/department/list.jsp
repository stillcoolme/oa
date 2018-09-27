<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/common.jsp"%>

<html>
<head>
    <title>部门列表</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
 
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${pageContext.request.contextPath}/css/images/title_arrow.gif"/> 部门管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align=center valign=middle id=TableTitle>
            	<td width="150px">部门名称</td>
				<td width="200px">职能说明</td>
				<td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer" datakey="departmentList">
        	<!-- 
        		迭代器到企业里一定会常用，不要到时又不会！！！！！！！！！！！！！！！
        		iterator说明
        		  *  当前正在迭代的元素会被放在栈顶！！！  在iterator标签下添加一个s:debug /s:debug标签就可以在页面显示栈的情况了。
        		  这时由于department的元素在栈顶，所以dname、description可以直接访问，而不用加#号。
        		  *  如果下面iterator标签的value属性不写，则默认迭代栈顶的元素
        	 -->
        	<s:iterator value="#departmentList">		<!-- ActionContext.getContext().put("departmentList", departmentList); -->
				<tr class="TableDetail1 template">
					<td><s:property value="dname"/></td>
					<td><s:property value="description" escape="false"/></td>   <!-- escape为false就可以得到fckeditor的表情 -->
					<td>
						<!--  
							在struts2的标签中只能用ognl表达式，不能用el表达式
							在html标签中，只能用el表达式，不能用ognl表达式!!!!!!!!
						-->
						<s:a action="departmentAction_deleteDepartment?did=%{did}">删除</s:a>
						<s:a action="departmentAction_updateUI?did=%{did}">修改</s:a>
					</td>
				</tr>
			</s:iterator>
		
		
			<!--list中含有list-->
		    <!--  
			  <s:iterator>
			  	 <s:iterator>
			  		<s:property value="dname"/>
			  	 </s:iterator>
			  </s:iterator>
		     -->
		     
		  
			  <!--list中含有map  放到map栈：ActionContext.getContext().put("list", lists); -->
			  <!-- 
			   <s:iterator value="#list">
			   	  <s:iterator>
			   	  	<s:property value="key"/>
			   	  	<s:property value="value.dname"/>
			   	  </s:iterator>
			   </s:iterator>
			  -->
			  
			  <!-- map中含有list   放到map栈： ActionContext.getContext().put("maps", maps); -->
			  <!-- 
			     <s:iterator value="#maps">
			     	<s:property value="key"/>  -->
			     	<!--下面这迭代就是一个list-->
			   <!-- 
			     	<s:iterator value="value">
			     		<s:property value="dname"/>
			     	</s:iterator>
			     </s:iterator>
			   --> 
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
            <a href="departmentAction_addUI.action"><img src="${pageContext.request.contextPath}/css/images/createNew.png" /></a>
        </div>
    </div>
</div>



</body>
</html>
