<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/pages/common/taglibs.jsp" %>

<html>
	<head>
		<title>index page</title>
		<link rel="stylesheet" type="text/css" media="all" href="<%= request.getContextPath() %>/styles/<mys:theme />/theme.css" />
		<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/jquery/jquery.min.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/jquery/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/jquery/my/layout/vertical_menu.js"></script>
		<style type="text/css">
			body{
				padding:0;
				background-color: #FCFFEF;
			}
			
			#navigation{
			}
			
			ul#vertical_navigation{
				margin:0;/* fixed IE bug*/
				padding:0;/* fixed IE bug*/
			}
			
			ul#vertical_navigation,ul#vertical_navigation li a{
				width:100%;
			}
			
		</style>
		
		<script>
			/**
			 * init vertical menu
			 */
			$(document).ready(function(){
				initVerticalMenu( "vertical_navigation" );
			})
		</script>
	</head>
	
	<body>
	<div id="navigation">
		
		<ul id="vertical_navigation" class="menu vertical-menu">
			<li>
				<%-- 系统管理--%>
				<a href="#"><s:text name="project.nav.sysmgr"/></a>
				<ul id="system_mgr">
					<li><a href="<s:url value="/settings/organization/viewparent.do"/>" target="main_frame">企业资料</a></li>
					<li>
						<%-- 登录账号--%>
						<a href="#"><s:text name="project.nav.loginaccount"/></a>
						<ul id="login_account">
							<%-- 修改密码--%>
							<li><a href="<s:url value="/security/account/edit.do?password=update"/>" target="main_frame"><s:text name="project.nav.changepassword"/></a></li>
							<%-- 新增用户--%>
							<shiro:hasPermission name="SECURITY_ACCOUNT_EDIT">
							<li><a href="<s:url value="/security/account/edit.do"/>" target="main_frame"><s:text name="project.nav.newaccount"/></a></li>
							</shiro:hasPermission>
							<%-- 用户列表--%>
							<li><a href="<s:url value="/security/account/list.do"/>" target="main_frame"><s:text name="project.nav.listaccount"/></a></li>
						</ul>
					</li>
					
					<li>
						<%-- 角色管理--%>
						<a href="#"><s:text name="project.nav.rolemgr"/></a>
						<ul id="security">
							<%-- 新增角色--%>
							<li><a href="<s:url value="/security/role/edit.do"/>" target="main_frame"><s:text name="project.nav.newrole"/></a></li>
							<%-- 角色列表--%>
							<li><a href="<s:url value="/security/role/list.do"/>" target="main_frame"><s:text name="project.nav.listrole"/></a></li>
						</ul>
					</li>
					
				</ul>
			</li>
			
			<li>
				<%-- 人员机构管理--%>
				<a href="#"><s:text name="project.nav.partymgr"/></a>
				<ul id="party_mgr">
					<li>
						<%-- 组织机构管理--%>
						<a href="#"><s:text name="project.nav.org"/></a>
						<ul id="org_mgr">
							<li><a href="<s:url value="/party/organization/edit.do"/>" target="main_frame"><s:text name="project.nav.neworg"/></a></li>
							<%-- 组织机构列表 --%>
							<li><a href="<s:url value="/party/organization/list.do"/>" target="main_frame"><s:text name="project.nav.listorg"/></a></li>
						</ul>
					</li>
					<li>
						<%-- 人员管理--%>
						<a href="#"><s:text name="project.nav.person"/></a>
						<ul id="member_mgr">
							<%-- 新增人员--%>
							<li><a href="<s:url value="/party/person/edit.do"/>" target="main_frame"><s:text name="project.nav.newperson"/></a></li>
							<%-- 人员列表--%>
							<li><a href="<s:url value="/party/person/list.do"/>" target="main_frame"><s:text name="project.nav.listperson"/></a></li>
						</ul>
					</li>
				</ul>
			</li>
			
			<li>
				<%-- 基础管理--%>
				<a href="#"><s:text name="project.nav.settings"/></a>
				<ul id="settings_mgr">
					<li><a href="<s:url value="/settings/organization/viewparent.do"/>" target="main_frame">企业资料</a></li>
					<%-- 系统日志--%>
					<li>
						<a href="#"><s:text name="project.nav.syslog"/></a>
						<ul id="">
							<li><a href="<s:url value="/settings/log/loginlist.do"/>" target="main_frame">登录日志</a></li>
							<li><a href="<s:url value="/settings/log/list.do"/>" target="main_frame"><s:text name="project.nav.syslog"/></a></li>
						</ul>
					</li>
					<%-- 定时任务 --%>
					<li><a href="<s:url value="/settings/scheduler/list.do"/>" target="main_frame">定时任务</a></li>
					<%-- 计量单位 --%>
					<li><a href="<s:url value="/settings/uom/list.do"/>" target="main_frame">计量单位</a></li>
					<%-- 地理区域--%>
					<li><a href="<s:url value="/settings/geo/list.do"/>" target="main_frame">地理区域</a></li>
					<%-- 分类树--%>
					<li><a href="<s:url value="/settings/tree/list.do"/>" target="main_frame">分类树</a></li>
				</ul>
			</li>
		</ul>
		
		<div class="spliter">
		</div>
	</div>
	</body>
</html>