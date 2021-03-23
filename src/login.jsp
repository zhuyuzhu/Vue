



























<!DOCTYPE html>
<html>
<head>
<title GJH-LABLE="loginKedacomVideo" class='GJHDZ >Login- KEDACOM Video Conference Cloud</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<link rel="stylesheet" href="/jms/static/css/common.css?t=6.0.820816542"/>
<link rel="stylesheet" href="/jms/static/css/login.css?t=6.0.2487786125"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<meta name="renderer" content="webkit">
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="Content-Security-Policy" content="default-src *;style-src 'self' 'unsafe-inline';script-src 'self' 'unsafe-inline' 'unsafe-eval';img-src 'self' data: http: https:;">
<link rel="stylesheet" href="/jms/static/css/common.css?t=6.0.820816542"/>
<link rel="stylesheet" href="/jms/static/css/ezmark.min.css?t=6.0.2811809063"/>
<link rel="stylesheet" href="/jms/static/css/main.css?t=6.0.3797097393"/>

<link rel="stylesheet" href="/jms/static/sysBrand/kedacom/css/home.css?t=6.0.3238894971" />
<link rel="stylesheet" href="/jms/static/sysBrand/kedacom/css/login.css?t=6.0.796967055" />

<script>
    var pageContext_request_contextPath = '/jms';
</script>
<script type="text/javascript" src="/jms/static/js/language/lang-zh_CN.js?t=6.1.1142749033"></script>
<script type="text/javascript" src="/jms/static/js/language/announce-zh_CN.js?t=6.1.3077290915"></script>
<script type="text/javascript" src="/jms/static/js/language/config-zh_CN.js?t=6.1.830376544"></script>
<script type="text/javascript" src="/jms/static/js/language/dialog-zh_CN.js?t=6.1.1236745477"></script>

<script type="text/javascript" src="/jms/static/jlib/jquery/3.5.1/jquery-3.5.1.min.js?t=6.1.1025346437"></script>
<script type="text/javascript" src="/jms/static/jlib/jquery/3.4.1/jquery-migrate-3.1.0.min.js?t=6.1.3867510913"></script>

<script type="text/javascript" src="/jms/static/js/bp.js?t=6.1.3741640933"></script>


<script type="text/javascript" src="/jms/static/jlib/namespace/1.0/jquery.namespace.min.js?t=5.0.3214755290"></script>  

<script type="text/javascript" src="/jms/static/jlib/artTemplate/1.4/template-web.js?t=6.0.3604292374"></script>
<script type="text/javascript" src="/jms/static/jlib/ezmark/1.0/jquery.ezmark.min.js?t=6.0.851139702"></script> 
<script type="text/javascript" src="/jms/static/jlib/underscore.min.js?t=6.0.1500937896"></script> 
<script type="text/javascript" src="/jms/static/i18n/location-zh_CN.min.js?t=6.0.503328863"></script>
<script type="text/javascript" src="/jms/static/js/messagebox.min.js?t=6.1.2211568760"></script>
<script type="text/javascript" src="/jms/static/js/messageboxCustom.js?t=6.1.3144036731"></script>

<script type="text/javascript" src="/jms/static/js/jquery.history.js?t=6.0.4246142002"></script>
<script type="text/javascript" src="/jms/static/js/common.js?t=6.1.4118861991"></script>
<script type="text/javascript" src="/jms/static/js/dialog.js?t=6.1.2527082607"></script>
<script type="text/javascript" src="/jms/static/js/config.js?t=6.1.1450206628"></script>

<script type="text/javascript" src="/jms/static/sysBrand/kedacom/js/home.js?t=6.1.707982036"></script>
<script type="text/javascript" src="/jms/static/jlib/moment/2.13.0/moment.js?t=6.0.3326331096"></script> 


<script type="text/javascript">
$.namespace("Mo.Config");
Mo.Config = {
	appUrl: "/jms",
	staticUrl: "/jms/static",
	newIP:location.host
};
$(function() {
	Mo.ExceptionUtils.pageErrorCode="";
	Mo.ExceptionUtils.pageErrorText="";
	Mo.ExceptionUtils.checkRecordExists();
});
</script>




<link rel="stylesheet" href="/jms/static/jlib/artDialog/4.1.7/skins/simple.min.css?t=6.0.1573329959"/>
<link rel="stylesheet" href="/jms/static/css/reset-artDialog.min.css?t=6.0.1737021460"/>
<script type="text/javascript" src="/jms/static/jlib/artDialog/4.1.7/jquery.artDialog.min.js?t=6.0.2288083125"></script>
<script type="text/javascript" src="/jms/static/jlib/artDialog/4.1.7/plugins/iframeTools.min.js?t=5.0.3699955660"></script>

<script type="text/javascript" src="/jms/static/js/login.js?t=6.0.2143859412"></script>
<script type="text/javascript" src="/jms/static/sysBrand/kedacom/js/login.js?t=6.1.2737878489"></script>
<script id="loginheader" type="text/html">
	<!-- login界面黑色背景图 -->
	<div class="login_header_bg"></div>
	<!-- 左上角logo-->
	<span class="login-logo mo-icons-bg"></span>
	<!-- 中间部分的中文与英文字体-->
	<div class="sys_logo">
		<span class="logo_text">
			<span class="login-title-logo mo-icons-bg"></span>
		    <div class="logo_title">{{systemName}}</div>
		</span>
 		<div class="logo_englishtext" >{{systemEnglishName}}</div>
	</div>
</script>
<script id="enterprise_introduce" type="text/html">
	<div class="enterprise_introduce_content clearfix" style="width:100%">
		<div class="company_info_up " style="font-size:14px;font-family:'微软雅黑';color:#4e4e4e;"> 
			<p class="clearfix company_info">
				<!-- 电话图标 -->
	          	<a class="no_meeting_icon phone_icon"></a>
	          	<!-- 电话 -->
	           	<span class="phoneNumber">{{phoneNumber}}</span>
	           	<!-- 邮件 -->
	           	<a class="no_meeting_icon emal_icon"></a>
	           	<span class="email">{{emailAddress}}</span>
	           	<!-- 网址 -->
	           	<a class="no_meeting_icon no_meeting"></a>
	           	<span class="meeting">	
					<a href="{{netAddress1Href}}" target="_blank">{{netAddress1Txt}}</a>
	           	</span>
	           	<span class="meeting movision">
                    <a class="no_meeting_icon no_meeting"></a>
	           		<a href="{{netAddress2Href}}" target="_blank">{{netAddress2Txt}}</a>
	           	</span>
	          		
	        </p>
        </div>
          	
        <div class="company_info_down">
			<p class="clearfix company_info">
				<!-- 公司名称-->
				<span class="companyName">{{companyName}}</span>
				<span class="copyright" >Copyright &copy;
				<span class="establishYear">{{establishYear}}</span><span class="version_year">2021</span>
				<span class="companyDomainName">{{companyDomainName}}</span><span>.&nbspAll rights reserved.</span>
				<!-- 科达视讯无备案号 摩云视讯有备案号 阿里云电信有备案号 DX6000无备案号 -->
				<span class="icp">
					<a  href="{{icpInfoHref}}" target="_blank">{{icpInfoTxt}}</a>
				</span>				
	         </p>
	    </div>
	</div>
</script>
<script type="text/javascript">
$(document).ready(function(){
	var data = Mo.CompanyInfo;
	document.title = data.title;
	var loginHeaderHtml = template('loginheader',data);
	document.getElementById('login_header').innerHTML = loginHeaderHtml;
	var footerHtml = template('enterprise_introduce',data);
	document.getElementById('footer').innerHTML = footerHtml;
})
$(function(){
	$('input[type="checkbox"]').ezMark();
});
if(top.location.href != location.href) {
	top.location.href = location.href;
}

$(document).ready(function(){
	Mo.Login.init();
	window.onresize=function(){  
		Mo.Login.init();
	 }
});
</script>
<style>
.footVerInfo{
	display:inline-block;
}
.meeting a{
	color:#4e4e4e;
	
}
.meeting a:hover{
	color:#007ac0;
	text-decoration:underline;
}
.left24{
	margin-left:24px;
}
</style>
</head>

<body class="bg">  
	   <div id="wrap" class="clearfix">
	       <div id="login_header" class="clearfix">
	            
	        </div>
	        
	        <div class="content">
	          <div class="login_content clearfix">
		
		        <div id="login_form">
		               <div class="clearfix form_input_holder">
				           <div class="login_input_wrapper email_input_holder">
				              <input type="text" class="login-input" id="account"  value="administrator" maxlength="64"/>
				              <label class="tip_label">用户名</label>
				           </div>
				           <div class="login_input_wrapper password_input_holder">
				              <input type="password" class="login-input" id="password"  value=""  maxlength="32"/>
				              <label class="tip_label">密码</label>
				           </div>

							<div class="login_input_wrapper verifyCode_input_holder hidden">
								<input type="text" id="verifyCode" name="verifyCode" class="login-input" value="" maxlength="4"/>
								<label class="tip_label">验证码</label>
								<img align="middle" id="verifyImage" src="/jms/verifyImage">
				           </div>

				           <a class="password_forget">忘记密码</a>
				           <div class="keep_login">
								<input type="checkbox" value="1" id="remember" name="keepLogin"/><span GJH-LABLE="keep" class='GJHDZ >Keep</span>
						   </div>
				           <div class="error_msg">
				              
				           </div>
						   <a id="login-submit" class="icon" type="submit" >登录</a>
			           </div>
		
						 <div id="forgotPassword-wrapper" style="display:none;width: 230px;">
							<div class="forgotPassword">
								<div class="item-reg-email login_input_wrapper">
									<input type="text" id="reg-email" name="reg-email" class="login-input input-email" value="" />
									<label class="tip_label">输入您的注册邮箱</label>
								</div>
								 <div class="error_msg" style="width: 230px;">
				                   
								 </div>
								<div>
								    <a id="cancel_email" GJH-LABLE="back" class="GJHDZ icon small" type="button" href="javascript:" style="margin-right:5px;">Back</a>
								    <a id="forgotPasswordBtn" GJH-LABLE="findItBack" class="GJHDZ icon btn-forgotPassword small" style="margin-left:5px;">Find it back now.</a>
								</div>
							</div>
						</div>
			           
	              </div>
		        </div>

	            
	        </div>
	        <!-- content end -->
	    </div>
	    <div class="betwweenWraperAndContent">
	    
	    </div>
	    <!-- footer enterprise infomation -->
	    <div id="footer">
	    </div>
       
</body>
</html>
