<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ include file="/pages/common/util/taglibs.jsp" %>
	
<head>
	<meta name="decorator" content="background"/>
	
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/jquery/ui/i18n/jquery.ui.datepicker_zh_CN.js"></script>
	<script type="text/javascript" src="<s:url value="/pages/message/catalog/popup.js" />"></script>
	<script type="text/javascript" src="<s:url value="/pages/party/popup.js" />"></script>
	<script type="text/javascript" src="<s:url value="/pages/security/account/popup.js" />"></script>
	
	<title>消息订阅</title>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var subType= $("select[name='subscription.subType']").val();
			$("#handler_msg_subtype").removeClass("disabled");
			if( subType == null || subType == '' )
				$("#handler_msg_subtype").addClass("disabled");
			
			/**
			 * 数据校验
			 */
			$("#profile_form").validate({
				rules:{
					"subscription.subType":{required:true}
					,"subscription.catalog.id":{required:true}
					,"subscription.subValue":{required:true}
				}
				,submitHandler: function(form) {
					if( !ajaxCheck( ) ){ 
						var url = '<s:url value="edit.do?"/>'
							+ '?subscription.catalog.id=' + $("input[name='subscription.catalog.id']").val() 
							+ '&subscription.subType=' + $("select[name='subscription.subType']").val() 
							+ '&subscription.subValue=' + $.trim( $("input[name='subscription.subValue']").val() );
						var msg = '\'消息类型\'+\'订阅类型\'+\'订阅值\'已存在！';
							msg += '<a href=\'' + url + '\'>点击进行修改！</a>';

						$.lightssh.showActionError(msg);
					}else{
						form.submit();
					}
				}
			});
			
			$(".calendar").datepicker( );
		});
		
		/**
		 * 检查名称是否重复
		 */
		function ajaxCheck( ){
			var result = false;
			$.ajax({
				url: "<s:url value="/message/subscription/unique.do"/>"
				,dataType: "json" 
				,type:"post"
				,async:false
				,data: {
		        	"subscription.id": function(){
						return $("input[name='subscription.id']").val()
			        }
			        ,"subscription.catalog.id": function(){
						return $.trim( $("input[name='subscription.catalog.id']").val() );
			        }
			        ,"subscription.subType": function(){
						return $.trim( $("select[name='subscription.subType']").val() );
			        }
			        ,"subscription.subValue": function(){
						return $.trim( $("input[name='subscription.subValue']").val() );
			        }
		        }
		        ,error: function(){ alert("检查重名出现异常!") }
		        ,success: function(json){
		        	result = json.unique;
		        }
			});
			
			return result;
		}
		
		/**
		 * 改变类型时清除选择的数据
		 */
		function cleanSelectedValue( ele ){
			var subType= $(ele).val();
			
			$("input[name='subscription.subValue']").val('');
			$("#span_msg_subscription_subvalue").text( '');
			
			$("#handler_msg_subtype").removeClass("disabled");
			if( subType == null || subType == '' )
				$("#handler_msg_subtype").addClass("disabled");
		}
		
		/**
		 * 选择消息类型回调
		 */
		function callbackSelectMsgCatalog(param){
			$("input[name='subscription.catalog.id']").val(param.id);
			$("input[name='subscription.catalog.description']").val(param.description);
			
			if( param != null && (param.id != null || param.description != null)  )
				$("#span_msg_catalog_name").text( param.id + '-' +param.description);
			else
				$("#span_msg_catalog_name").text( '');
			$( popup_msg_catalog ).dialog('destroy').html('');
			
			$("label[for='subscription.catalog.id']").remove(); //移除样式
		}
		
		/**
		 * 根据类型选择
		 */
		function popupSubType( ){
			var subType= $("select[name='subscription.subType']").val();
			if( subType == null || subType == '' )
				return;
			
			var url = '';
			if( subType == '<s:property value="@com.google.code.lightssh.project.message.entity.Subscription$SubType@ROLE.name()"/>'){
				url = '<s:url value="/security/role/popup.do"/>';
			}else if( subType == '<s:property value="@com.google.code.lightssh.project.message.entity.Subscription$SubType@DEPARTMENT.name()"/>' ){
				popupParty('<s:url value="/party/popup.do"/>',{party_type:'org'})
			}else if( subType == '<s:property value="@com.google.code.lightssh.project.message.entity.Subscription$SubType@PERSON.name()"/>' ){
				popupParty('<s:url value="/party/popup.do"/>',{party_type:'person'})
			}else if( subType == '<s:property value="@com.google.code.lightssh.project.message.entity.Subscription$SubType@USER.name()"/>' ){
				popupLoginAccount('<s:url value="/security/account/popup.do"/>',{})
			}
		}
		
		/**
		 * DEPT-弹出框回调
		 */
		function callbackSelectParty( party ){
			$("input[name='subscription.subValue']").val( party.id);
			$("#span_msg_subscription_subvalue").text( party.name);
			
			$("label[for='subscription.subValue']").remove(); //移除样式
			$( popup_party ).dialog('destroy').html('');
			
		}
		
		/**
		 * USER-弹出框回调
		 */
		function callbackSelectLoginAccount( param ){
			$("input[name='subscription.subValue']").val( param.id);
			$("#span_msg_subscription_subvalue").text( param.loginName );
			
			$("label[for='subscription.subValue']").remove(); //移除样式
			
			$( popup_login_account ).dialog('destroy').html('');
		}
	</script>
</head>
	
<body>
	<ul class="path">
		<li>基础管理</li>
		<li>消息管理</li>
		<li>消息订阅</li>
	</ul>
		
	<%@ include file="/pages/common/util/messages.jsp" %>
	
	<input type="button" class="action list" value="消息订阅列表" onclick="location.href='<s:url value="list.do"/>'"/>
	
	<s:form id="profile_form" action="save" method="post">
	<table class="profile">
		<tbody>
			<tr>
				<th><label for="name" class="required">消息类型</label></th>
				<td>
					<s:hidden id="subscription.id" name="subscription.id"/>
					<s:hidden name="subscription.createdTime"/>
					<s:hidden name="subscription.creator"/>
				
					<span class="popup" onclick="popupMsgCatalog('<s:url value="/message/catalog/popup.do"/>');">&nbsp;</span>
					<s:hidden id="subscription.catalog.id" name="subscription.catalog.id"/>
					<s:hidden name="subscription.catalog.description"/>
					<span id="span_msg_catalog_name"><s:property value="subscription.catalog.id + '-' + subscription.catalog.description"/></span>
				</td>
			</tr>
			
			<tr>
				<th><label for="name" class="required">订阅类型</label></th>
				<td>
					<s:select name="subscription.subType" value="%{subscription.subType.name()}" 
						listKey="name()" headerKey="" headerValue=""
						onchange="cleanSelectedValue(this)"
						list="@com.google.code.lightssh.project.message.entity.Subscription$SubType@supportedValues()"/>
				</td>
			</tr>
			
			<tr>
				<th><label for="name" class="required">订阅值</label></th>
				<td>
					<span class="popup disabled" id="handler_msg_subtype" onclick="popupSubType();">&nbsp;</span>
					<s:hidden id="subscription.subValue" name="subscription.subValue"/>
					<span id="span_msg_subscription_subvalue"><s:property value="subscription.subValue"/></span>
				</td>
			</tr>
			
			<tr>
				<th><label for="account_start_date">有效期</label></th>
				<td>
					<s:textfield name="subscription.period.start" cssClass="calendar" size="10" /> -
					<s:textfield name="subscription.period.end" cssClass="calendar" size="10"/>
				</td>
			</tr>
			
			<tr>
				<th><label for="desc">描述</label></th>
				<td><s:textarea id="desc" name="subscription.description" cols="60" rows="5"/></td>
			</tr>
		</tbody>
	</table>
	
	<p class="submit">
		<input type="submit" class="action save" name="Submit" 
			value="<s:property value="%{(subscription==null||subscription.insert)?\"新增消息订阅\":\"修改消息订阅\"}"/>"/>
	</p>
	</s:form>
</body>