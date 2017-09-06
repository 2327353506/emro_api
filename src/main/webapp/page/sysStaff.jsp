<%--
  Created by IntelliJ IDEA.
  User: wangmt
  Date: 2017/9/4
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="emro.vo.SessionLogin" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    SessionLogin login = (SessionLogin)request.getSession().getAttribute("sessionLogin");
    String mainName = "帮助中心";
    if(request.getRequestURL().indexOf("system")>=0){
        mainName = "系统中心";
    }
%>
<html>
<head>
    <jsp:include page="../head.jsp" />
</head>
<body style="width:100%;height: 100%" class="easyui-layout" id="sysStaff">
    <div  class="easyui-window add_windows" title="新增" data-options="modal:true,shadow:true,inline:false,closed:true" style="width:500px;height:200px;padding:5px;">
        <div class="easyui-layout" data-options="fit:true">
            <form id="edit_form">
                <table cellpadding="5">
                    <tr>
                        <td>用户名:</td>
                        <td><input class="easyui-textbox username" type="text" name="username" data-options="required:true"></input></td>
                    </tr>
                    <tr>
                        <td>姓名:</td>
                        <td><input class="easyui-textbox name" type="text" name="name" data-options="required:true"></input></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>(初始密码:123)</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="staff_save()">保存</a>
                            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="$('#sysStaff form').form('clear')">重置</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <div class="index_toolbar">
        <div style="margin-bottom:5px">
            <a href="#" class="easyui-linkbutton add" iconCls="icon-add" plain="true" onclick="$('#sysStaff .add_windows').window('open')">新增</a>
        </div>
    </div>
    <table class="easyui-datagrid" style="width:100%;height:100%"
           data-options="singleSelect:true,rownumbers:true,striped:true,collapsible:true,url:'../staff/list',method:'get',pagination:true,pageNumber:0,toolbar:'#sysStaff .index_toolbar'" >
        <thead>
        <tr>
            <th data-options="field:'username',width:150,align:'center'">登录名</th>
            <th data-options="field:'name',width:150,align:'center'">姓名</th>
            <th data-options="field:'createDt',width:200,align:'right'">创建时间</th>
        </tr>
        </thead>
    </table>
</body>
<script language="javascript">


    function staff_save(){
        if($('#sysStaff form').form('validate')){
            var username =  $.trim($("#edit_form .username").textbox("getValue"));
            var name =  $.trim($("#edit_form .name").textbox("getValue"));
            $.post(  "<%=basePath %>staff/add",
                {
                    username : username,
                    name : name
                },
                function(res){
                    if(res.code == 0){
                        $.messager.alert('新增',"保存成功");
                        $('#sysStaff form').form('clear');
                        $('#sysStaff .add_windows').window('close')
                    }else{
                        $.messager.alert('新增',res.msg);
                    }
                })
        }
    }
</script>
</html>
