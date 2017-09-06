<%--
  Created by IntelliJ IDEA.
  User: wangmt
  Date: 2017/8/21
  Time: 8:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>
    <title>emrp_api</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="<%=basePath %>css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath %>css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath %>css/templatemo_style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="<%=basePath %>/plugin/easyui/jquery.min.js"></script>
</head>
<body class="templatemo-bg-gray" id="login">
<div class="container">
    <div class="col-md-12">
        <h1 class="margin-bottom-15">API Login Form</h1>
        <form class="form-horizontal templatemo-container templatemo-login-form-1 margin-bottom-30" role="form" action="#" method="post">
            <div class="form-group">
                <div class="col-xs-12">
                    <div class="control-wrapper">
                        <label for="username" class="control-label fa-label"><i class="fa fa-user fa-medium"></i></label>
                        <input type="text" class="form-control" id="username" placeholder="Username">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-12">
                    <div class="control-wrapper">
                        <label for="password" class="control-label fa-label"><i class="fa fa-lock fa-medium"></i></label>
                        <input type="password" class="form-control" id="password" placeholder="Password">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-12">
                    <div class="checkbox control-wrapper">
                        <label>
                            <input type="checkbox"> Remember me
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-12">
                    <div class="control-wrapper">
                        <input type="button" value="Log in" class="btn btn-info to_login" >
                        <a href="#" class="text-right pull-right error" style="color: red"></a>

                    </div>
                </div>
            </div>
            <hr>
            <div class="form-group">
                <div class="col-md-12">
                    <label>Login with: </label>
                    <div class="inline-block">
                        <a href="#"><i class="fa fa-facebook-square login-with"></i></a>
                        <a href="#"><i class="fa fa-twitter-square login-with"></i></a>
                        <a href="#"><i class="fa fa-google-plus-square login-with"></i></a>
                        <a href="#"><i class="fa fa-tumblr-square login-with"></i></a>
                        <a href="#"><i class="fa fa-github-square login-with"></i></a>
                    </div>
                </div>
            </div>
        </form>
        <div class="text-center">
            <%--<a href="create-account.html" class="templatemo-create-new">Create new account <i class="fa fa-arrow-circle-o-right"></i></a>--%>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    (function($){
        $(function(){
            var main = function(val){
                if(val){
                    return $("#login").find(val);
                }else{
                    return $("#login");
                }
            };
            main(".to_login").on("click",function(){
                var username = main("#username").val();
                var password = main("#password").val();
                if(!username){
                    main(".error").text("username cannot be empty");
                    return;
                }
                if(!password){
                    main(".error").text("password cannot be empty");
                    return;
                }
                $.post("login",{username:username,password:password},function(data){
                    if(data.code==0){
                        window.location.href="<%=basePath %>";
                    }else{
                        main(".error").text("username password error");
                    }
                })
            })
            main("#username,#password").on("keypress",function(event){
                if(event.keyCode ==13){
                    main(".to_login").click();
                }
            });
        })
    })(jQuery)
</script>
</html>