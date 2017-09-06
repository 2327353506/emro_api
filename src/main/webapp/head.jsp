<%@ page import="emro.vo.SessionLogin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    SessionLogin login = (SessionLogin)request.getSession().getAttribute("sessionLogin");
%>
<meta charset="UTF-8">

<title>API</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/plugin/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>/plugin/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>/plugin/easyui/demo/demo.css">
<script type="text/javascript" src="<%=basePath %>/plugin/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/plugin/easyui/jquery.easyui.min.js"></script>
