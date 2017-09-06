<%--
  Created by IntelliJ IDEA.
  User: wangmt
  Date: 2017/9/4
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="emro.vo.SessionLogin" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    SessionLogin login = (SessionLogin)request.getSession().getAttribute("sessionLogin");
    String mainName = "帮助中心";
    if(request.getRequestURL().indexOf("system")>=0){
        mainName = "系统中心";
    }
    String[] manager = new String[]{"wmt","cmf","kxq","lyj"};
    List<String> managerList = Arrays.asList(manager);
    boolean ex = managerList.contains(login.getUsername());
%>
<div>
    <span style="font-size: 25px;font-weight: bolder"><%=mainName %></span>
    <span style="float: right;margin-top: 20px;margin-right: 30px">
            <a href="#" class="easyui-menubutton" data-options="menu:'#mm1',iconCls:'icon-man'">欢迎您,<%=login.getUsername() %></a>
        </span>
</div>
<div id="mm1" style="width:150px;">
    <div data-options="" onclick="window.location.href='index.jsp'">主页</div>
    <%= ex?"<div data-options=\"iconCls:'icon-lock'\" onclick=\"window.location.href='system.jsp'\">系统中心</div>" :"" %>

    <div data-options="iconCls:'icon-mini-edit'" onclick="$('.edit_windows').window('open')">修改密码</div>
</div>
<div  class="easyui-window edit_windows" title="修改密码" data-options="modal:true,shadow:true,inline:false,closed:true" style="width:500px;height:200px;padding:5px;">
    <div class="easyui-layout" data-options="fit:true">
        <form id="edit_form">
            <table cellpadding="5">
                <tr>
                    <td>原始密码:</td>
                    <td><input class="easyui-textbox oldPassword" type="password" name="oldPassword" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>新密码:</td>
                    <td><input class="easyui-textbox password" type="password" name="password" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>再次输入新密码:</td>
                    <td><input class="easyui-textbox newPassword" type="password" name="newPassword" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="edit_password_submit()">保存</a>
                        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="$('#edit_form').form('clear')">重置</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script language="javascript">
    function edit_password_submit(){
        if($('#edit_form').form('validate')){
            var newPassword =  $.trim($("#edit_form .newPassword").textbox("getValue"));
            var password =  $.trim($("#edit_form .password").textbox("getValue"));
            var oldPassword =  $.trim($("#edit_form .oldPassword").textbox("getValue"));
            if(password != newPassword){
                $.messager.alert('新密码不一致');
            }
            $.post(  "<%=basePath %>staff/editPswd",
                {
                    password : password,
                    oldPassword : oldPassword
                },
                function(res){
                    if(res.code == 0){
                        window.location.href="login.jsp"
                    }else{
                        $.messager.alert('修改密码',res.msg);
                    }
            })
        }
    }
</script>