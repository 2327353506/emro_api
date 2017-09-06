<%--
  Created by IntelliJ IDEA.
  User: wangmt
  Date: 2017/8/17
  Time: 11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="emro.vo.SessionLogin" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    SessionLogin login = (SessionLogin)request.getSession().getAttribute("sessionLogin");
%>
<html>
<head>
    <jsp:include page="head.jsp" flush="true"/>

    <link rel="stylesheet" type="text/css" href="<%=basePath %>/css/index.css">
    <script type="text/javascript" src="<%=basePath %>/js/index.js"></script>
</head>
<body class="easyui-layout" id="index">
    <div data-options="region:'north',border:false" style="height:60px;padding:10px">
        <jsp:include page="page/north.jsp"/>
    </div>
    <div data-options="region:'west',split:false,title:'功能'" style="width:10%;">
        <jsp:include page="page/west.jsp"/>
    </div>
    <div data-options="region:'east',split:false,collapsed:false,title:'接口说明'" style="width:40%;padding:10px;">
        <form id="ff" method="post">
            <table cellpadding="5">
                <tr>
                    <td>接口URL:</td>
                    <td><span class="index_suff"></span><input class="easyui-textbox index_url" type="text" name="subject" style="width:200px;" readonly></input></td>
                </tr>
                <tr>
                    <td>接口说明:</td>
                    <td><input class="easyui-textbox  index_remark" name="message" data-options="multiline:true" style="height:80px;width:500px;" readonly></input></td>
                </tr>
                <tr>
                    <td>请求类型:</td>
                    <td>
                        <input class="easyui-textbox  index_method" name="message"  style="width:100px;" readonly></input>
                    </td>
                </tr>
            </table>
        </form>
        <div class="easyui-tabs" style="width:100%;height:70%">
            <div title="请求参数" style="padding:10px" class="index_request">
                <table class="easyui-datagrid index_request_data" style="width:100%;height:100%"
                       data-options="singleSelect:true,collapsible:true,url:'api/getRequest',method:'get'">
                    <thead>
                    <tr>
                        <th data-options="field:'index',width:50,align:'center',formatter:function(value,row,index){ return index+1;}" >序号</th>
                        <th data-options="field:'name',width:100,align:'center'">请求参数</th>
                        <th data-options="field:'value',align:'center',fitColumns:true">注释</th>
                        <th data-options="field:'isRequired',width:80,align:'center',formatter: function(value,row,index){
                        if (value==1){
                            return '<B>*</B>';
                        } else {
                            return '';
                        }
                    }">是否必填</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div title="响应参数" style="padding:10px" class="index_response">
                <table class="easyui-datagrid index_response_data" style="width:100%;height:100%"
                       data-options="singleSelect:true,collapsible:true,url:'api/getResponse',method:'get'">
                    <thead>
                    <tr>
                        <th data-options="field:'index',width:50,align:'center',formatter:function(value,row,index){ return index+1;}" >序号</th>
                        <th data-options="field:'name',width:100,align:'center'">响应参数</th>
                        <th data-options="field:'value',align:'center',fitColumns:true">注释</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
    <div data-options="region:'south',border:false" style="height:50px;padding:10px;">
        <jsp:include page="page/south.jsp"/>
    </div>
    <div data-options="region:'center',title:'API详情'" style="width:40%;">
        <div class="index_toolbar">
            <div style="margin-bottom:5px">
                <%--<a href="#" class="easyui-linkbutton view" iconCls="icon-search" plain="true"  >查看</a>--%>
                <a href="#" class="easyui-linkbutton add" iconCls="icon-add" plain="true" >新增</a>
                <a href="#" class="easyui-linkbutton edit" iconCls="icon-edit" plain="true" >修改</a>
                <a href="#" class="easyui-linkbutton remove" iconCls="icon-remove" plain="true" >删除</a>
            </div>
            <div >
                接口说明: <input class="easyui-textbox index_remark" style="width:80px">
                创建人: <input class="easyui-textbox index_createBy" style="width:80px" >
                请求类型:
                <select class="easyui-combobox index_method" name="status" style="width: 100px" >
                    <option value=""  >请选择</option>
                    <option value="GET"  >GET</option>
                    <option value="POST" >POST</option>
                    <option value="PUT" >PUT</option>
                    <option value="DELETE" >DELETE</option>
                </select>
                <a href="#" class="easyui-linkbutton doSearch" iconCls="icon-search"  data-options="plain:true">查询</a>
            </div>
        </div>
        <table class="easyui-datagrid index_datagrid" style="width:100%;height:100%"
               data-options="singleSelect:true,striped:true,collapsible:true,url:'api/list',method:'get',pagination:true,pageNumber:0,toolbar:'#index .index_toolbar',pageSize:20,pageList:[20,30,50]">
            <thead>
            <tr>
                <th data-options="field:'index',width:50,align:'center',formatter:function(value,row,index){ return index+1;}" >序号</th>
                <th data-options="field:'remark',width:250,align:'left'">接口说明</th>
                <th data-options="field:'method',width:100,align:'center'">请求类型</th>
                <th data-options="field:'createBy',width:100,align:'center'">创建人</th>
                <th data-options="field:'createDt',width:145">创建时间</th>
                <th data-options="field:'updateDt',width:145,align:'center'">更新时间</th>
            </tr>
            </thead>
        </table>
    </div>
    <div class="win" ></div>
</body>
</html>
