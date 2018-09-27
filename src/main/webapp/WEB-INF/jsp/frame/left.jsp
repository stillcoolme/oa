<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/common.jsp"%>
<html>
	<!-- menu.js请求树 -->
	<head>
		<title>左边导航菜单</title>
		<script language="JavaScript" src="js/frame/jquery-ztree-2.5.js"></script>
		<script language="JavaScript" src="js/menu.js"></script>	
		<link rel="stylesheet" href="zTreeStyle/zTreeStyle.css" type="text/css">
	</head>
	
	<body style="margin: 0">
		<TABLE border=0 width="700">
			<TR>
				<TD width=340px align=center valign=top>
				<div class="zTreeDemoBackground">
					<ul id="menuTree" class="tree"></ul>
				</div>		
				</TD>
			</TR>
		</TABLE>
	</body>
</html>
