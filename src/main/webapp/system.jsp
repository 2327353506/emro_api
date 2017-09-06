<%--
  Created by IntelliJ IDEA.
  User: wangmt
  Date: 2017/9/4
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="emro.vo.SessionLogin" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    SessionLogin login = (SessionLogin)request.getSession().getAttribute("sessionLogin");
%>
<html>
<head>
    <jsp:include page="head.jsp" />
    <link rel="stylesheet" type="text/css" href="<%=basePath %>/css/system.css">
    <script type="text/javascript" src="<%=basePath %>/js/system.js"></script>
</head>
<body class="easyui-layout" id="system">
<div data-options="region:'north',border:false" style="height:60px;padding:10px">
    <jsp:include page="page/north.jsp"/>
</div>
<div data-options="region:'west',split:false,title:'菜单'" style="width: 10%;">
    <jsp:include page="page/west.jsp"/>
</div>
<div data-options="region:'south',border:false" style="height:50px;padding:10px;">
    <jsp:include page="page/south.jsp"/>
</div>
<div data-options="region:'center'" >
    <div class="easyui-tabs system_tab" style="width:100%;height:100%;padding: 0px">
        <div title="主页">

        </div>
    </div>
</div>
</body>
</html>
