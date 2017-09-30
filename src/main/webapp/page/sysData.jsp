<%--
  Created by IntelliJ IDEA.
  User: wangmt
  Date: 2017/9/11
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="../head.jsp" />
</head>
<body style="width:100%;height: 100%" class="easyui-layout" id="sysData">
    <div data-options="region:'east',split:false,collapsed:false,title:'接口说明'" style="width:40%;height:100%">
        <table class="easyui-datagrid dataCh_datagrid" style="width:100%;height:100%"
               data-options="singleSelect:true,collapsible:true">
            <thead>
            <tr>
                <th data-options="field:'index',width:50,align:'center',formatter:function(value,row,index){ return index+1;}" >序号</th>
                <th data-options="field:'columnName',width:100,align:'center'">列名</th>
                <th data-options="field:'columnComment',align:'center',fitColumns:true">注释</th>
                <th data-options="field:'columnType',align:'center',fitColumns:true">类型</th>
            </tr>
            </thead>
        </table>
    </div>
    <div data-options="region:'center',title:''">
        <div class="index_toolbar">
            <div style="margin-bottom:5px">
                <a href="#" class="easyui-linkbutton add" iconCls="icon-add" plain="true">生成增删改查</a>
                <a href="#" class="easyui-linkbutton add_pojo" iconCls="icon-add" plain="true">表对象</a>
            </div>
            <div >
                表名: <input class="easyui-textbox data_table_name" style="width:80px">
                表注释: <input class="easyui-textbox data_table_comment" style="width:80px" >
                <a href="#" class="easyui-linkbutton doSearch" iconCls="icon-search"  data-options="plain:true">查询</a>
            </div>
        </div>
        <table class="easyui-datagrid data_datagrid" style="width:100%;height:100%"
               data-options="singleSelect:true,rownumbers:true,striped:true,collapsible:true,url:'../data/list',method:'get',pagination:true,pageNumber:0,toolbar:'#sysData .index_toolbar',pageSize:20" >
            <thead>
            <tr>
                <th data-options="field:'tableName',width:150,align:'left'">表名</th>
                <th data-options="field:'tableComment',width:150,align:'center'">表注释</th>
                <th data-options="field:'createTime',width:200,align:'center'">创建时间</th>
            </tr>
            </thead>
        </table>

        <div  class="easyui-window data_windows" title="CRUD" style="width:700px;height:400px;padding:5px;"data-options="closable:true,closed : true">
            <input class="easyui-textbox crud" data-options="multiline:true"  style="width:100%;height:100%">
        </div>
    </div>
</body>
<script type="text/javascript">
    (function($){
        var main = function(val){
            return $("#sysData").find(val)
        }
        $(function(){
            main(".data_datagrid").datagrid({
                onClickRow : function(rowIndex, rowData){
                    $.get("../data/chList?name="+rowData.tableName,function(res){
                        main(".dataCh_datagrid").datagrid("loadData",res);
                    });
                }
            });
            main(".doSearch").on("click",function(){
                main('.data_datagrid').datagrid('load',{
                    'name': main(".data_table_name").textbox("getValue"),
                    'tableComment': main(".data_table_comment").textbox("getValue"),
                });
            });
            main(".add").on("click",function(){
                main(".crud").textbox("setValue","");
                main('.data_windows').window('open');
                var row = main('.data_datagrid').datagrid('getSelected');
                if(row){
                    $.get("../data/create?name="+row.tableName,function(res){
                        main(".crud").textbox("setValue",res.data);
                    });
                }
            })
            main(".add_pojo").on("click",function(){
                main(".crud").textbox("setValue","");
                main('.data_windows').window('open');
                var row = main('.data_datagrid').datagrid('getSelected');
                if(row){
                    $.get("../data/createPOJO?name="+row.tableName,function(res){
                        main(".crud").textbox("setValue",res.data);
                    });
                }
            })
        })
    })(jQuery)

</script>
</html>
