<%--
  Created by IntelliJ IDEA.
  User: wangmt
  Date: 2017/8/17
  Time: 11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <jsp:include page="head.jsp" />
    <script type="text/javascript" src="<%=basePath %>/js/api.js"></script>
</head>
<body class="easyui-layout" id="api">
    <div class="easyui-panel" style="width:100%;height:190px">
        <form>
            <input type="hidden" value="" class="api_id">
            <input type="hidden" value="BOSS" class="api_channel">
            <table cellpadding="5">
                <tr>
                    <td>接口URL:</td>
                    <td><span class="api_suff">192.168.1.211:/emro_boss/</span><input class="easyui-textbox api_url" type="text" name="subject" style="width:200px;"></input></td>
                </tr>
                <tr>
                    <td>接口说明:</td>
                    <td><input class="easyui-textbox  api_remark" name="message" data-options="multiline:true" style="height:80px;width:500px;"></input></td>
                </tr>
                <tr>
                    <td>请求类型:</td>
                    <td>
                        <select class="easyui-combobox api_method" name="language" >
                            <option value="">请选择</option>
                            <option value="GET">GET</option>
                            <option value="POST">POST</option>
                            <option value="PUT">PUT</option>
                            <option value="DELETE">DELETE</option>
                        </select>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div class="easyui-tabs api_tab" style="width:100%;height:60%">
        <div title="请求参数" style="padding:10px" class="index_request">
            <a href="#" class="easyui-linkbutton add_request" iconCls="icon-add" plain="true" >新增行</a>
            <a href="#" class="easyui-linkbutton add_request_win" iconCls="icon-add" plain="true" >快速新增</a>
            <table class="easyui-datagrid api_request" style="width:100%;height:90%;border: none" data-options="singleSelect:true,rownumbers:true" >
                <thead>
                <tr>
                    <%--<th data-options="field:'index',width:50,align:'center',formatter:function(value,row,index){ return index+1;}" >序号</th>--%>
                    <th data-options="field:'name',width:150,align:'center',formatter:name_formatter">请求参数</th>
                    <th data-options="field:'value',width:300,align:'center',formatter:value_formatter">注释</th>
                    <th data-options="field:'isRequired',width:80,align:'center',formatter:isRequired_formatter">是否必填</th>
                    <th data-options="field:'action',width:80,align:'center',formatter:action_formatter">操作</th>
                </tr>
                </thead>
            </table>
        </div>
        <div title="响应参数" style="padding:10px" class="index_response">
            <a href="#" class="easyui-linkbutton add_response" iconCls="icon-add" plain="true" >新增行</a>
            <a href="#" class="easyui-linkbutton add_response_win" iconCls="icon-add" plain="true" >快速新增</a>
            <table class="easyui-datagrid api_response" style="width:100%;height:90%" data-options="singleSelect:true,rownumbers:true">
                <thead>
                <tr>
                    <%--<th data-options="field:'index',width:50,align:'center',formatter:function(value,row,index){ return index+1;}" >序号</th>--%>
                    <th data-options="field:'name',width:150,align:'center' ,formatter:name_formatter">响应参数</th>
                    <th data-options="field:'value',width:300,align:'center',formatter:value_formatter">注释</th>
                        <th data-options="field:'action',width:80,align:'center',formatter:action_formatter">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
    <div class="easyui-window request_win" title="快速新增请求参数" data-options="closable:true,closed:true,shadow:true" style="width:500px;height:200px;padding:10px;">
        <input class="easyui-textbox" data-options="multiline:true,prompt:'xxxx,xxxx,xxxx'" value="" style="width:350px;height:140px">
        <a href="#" class="easyui-linkbutton request_win_save" data-options="iconCls:'icon-large-smartart',size:'large',iconAlign:'top'" style="margin-left: 40px">保存</a>
    </div>
    <div class="easyui-window response_win" title="快速新增响应参数" data-options="closable:true,closed:true,shadow:true" style="width:500px;height:200px;padding:10px;">
        <input class="easyui-textbox" data-options="multiline:true,prompt:'xxxx,xxxx,xxxx'" value="" style="width:350px;height:140px">
        <a href="#" class="easyui-linkbutton response_win_save" data-options="iconCls:'icon-large-smartart',size:'large',iconAlign:'top'" style="margin-left: 40px">保存</a>
    </div>
    <div style="text-align: center;margin-top: 10px;">
        <a href="#" class="easyui-linkbutton save" data-options="iconCls:'icon-save'" style="margin-right: 5px">保存</a>
        <a href="#" class="easyui-linkbutton reset" data-options="iconCls:'icon-reload'" style="margin-left: 5px">重置</a>
    </div>
</body>
</html>
