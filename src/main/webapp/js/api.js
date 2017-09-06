(function($){
    var getUrlParam = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    };
    var node_data = function(){
        var name = window.parent.$("#index .menu_tree .select").attr("mt-name");
        var icon = window.parent.$("#index .menu_tree .select").attr("mt-icon");
        return {name:name,icon:icon};
    };
    var trim = function(val){
        return $.trim(val);
    };
    var boolean = function(val){
        if(val == 'true' || val == true){
            return true;
        }else{
            return false;
        }
    }
    var getRowData = function(val,index){
        var list = [];
        if(val.name){
            var name = val.name.split(",");
            var value = val.value.split(",");
            var isRequired = val.isRequired.split(",");
            var len = name.length;
            if(index){
                len = len -1;
            }
            for (var i = 0; i < len; i++) {
                if(i != index){
                    var map = {};
                    map.name=trim(name[i]);
                    map.value=value.length>i?trim(value[i]):"";
                    map.isRequired=boolean(isRequired.length>i?isRequired[i].trim():"false");
                    map.action="";
                    list.push(map);
                }
            }
        }else{
            var map = {};
            map.name="";
            map.value="";
            map.isRequired="";
            map.action="";
            list.push(map);
        }
        return list;
    }
    $(function(){
        var id = getUrlParam("id");
        var node = node_data();
        var main = function(val){
            if(val){
                return $("#api").find(val);
            }else{
                return $("#api");
            }
        };
        if(id){
            $.get("api/detail?id=" + id,function(data){
                main(".api_id").val(id);
                main(".api_url").textbox("setValue", data.url);
                main(".api_remark").textbox("setValue", data.remark);
                main(".api_method").textbox("setValue", data.method);
            });
            $.get("api/getRequest?id=" + id,function(data){
                main(".api_request").datagrid('loadData', data);
            });
            $.get("api/getResponse?id=" + id,function(data){
                main(".api_response").datagrid('loadData', data);
            });
        }
        main(".api_suff").text("192.168.1.211:8080/emro_"+ node.name.toLowerCase() +"/")
        main(".api_channel").val(node.name);
        var getRequestParam = function(){
            var request_name = "";
            var request_value = "";
            var request_isRequired = "";
            main(".index_request input[name='name']").each(function(){
                request_name = request_name+$(this).val()+" ,"
            });
            main(".index_request input[name='value']").each(function(){
                request_value = request_value+$(this).val()+" ,"
            });
            main(".index_request input[name='isRequired']").each(function(){
                request_isRequired = request_isRequired+$(this).prop("checked")+" ,"
            });
            return {"name":request_name,"value":request_value,"isRequired":request_isRequired};
        }
        var getResponseParam = function(){
            var response_name = "";
            var response_value = "";
            var response_isRequired = "";
            main(".index_response input[name='name']").each(function(){
                response_name = response_name+$(this).val()+" ,"
            });
            main(".index_response input[name='value']").each(function(){
                response_value = response_value+$(this).val()+" ,"
                response_isRequired = response_isRequired+"false ,"
            });
            return {"name":response_name,"value":response_value,"isRequired":response_isRequired};
        }
        main(".add_request").on("click",function(){
            var requestParam = getRequestParam();
            main(".api_request").datagrid('loadData', getRowData(requestParam));
            /*            $.post('api/addRow',requestParam,function(data){
                        })*/
        });
        main(".add_request_win").on("click",function(){
            main(".request_win").window("open");
        });
        main(".add_response").on("click",function(){
            var responseParam = getResponseParam();
            main(".api_response").datagrid('loadData', getRowData(responseParam));
            /*            $.post('api/addRow',responseParam,function(data){
                        })*/
        });
        main(".add_response_win").on("click",function(){
            main(".response_win").window("open");
        });
        main(".reset").on("click",function(){
            window.parent.$("#index .win iframe").attr("src","api.jsp?id="+ id +"&cache"+new Date().getTime());
        })
        main(".save").on("click",function(){
            var id = main(".api_id").val();
            var channel = main(".api_channel").val();
            var url = main(".api_url").textbox("getValue");
            var remark = main(".api_remark").textbox("getValue");
            var method = main(".api_method").combobox("getValue");
            if(!url){
                $.messager.alert('api','保存失败:URL不能为空');
                return;
            }
            if(!remark){
                $.messager.alert('api','保存失败:接口说明不能为空');
                return;
            }
            if(!method){
                $.messager.alert('api','保存失败:接口方法不能为空');
                return;
            }
            var requestParam = JSON.stringify(getRequestParam());
            var responseParam = JSON.stringify(getResponseParam());
            var param = {id:id,channel:channel,url:url,remark:remark,method:method,requestParam:requestParam,responseParam:responseParam}
            $.post('api/save',param,function(data){
                if(data.code == 0 ){
                    window.parent.$("#index .win").window('close');
                    window.parent.$("#index .index_datagrid").datagrid('reload');
                    $.messager.alert('api','保存成功!');
                }else{
                    $.messager.alert('api','保存失败:'+data.msg);
                }
            })
        })
        main(".request_win_save").on("click",function(){
            var valeue = main(".request_win input").textbox("getValue");
            if(valeue){
                $.post('api/addManyRow',{"msg":$.trim(valeue)},function(data){
                    main(".api_request").datagrid('loadData', data);
                })
            }
            main(".request_win").window("close");
        })
        main(".response_win_save").on("click",function(){
            var valeue = main(".response_win input").textbox("getValue");
            if(valeue){
                $.post('api/addManyRow',{"msg":$.trim(valeue)},function(data){
                    main(".api_response").datagrid('loadData', data);
                })
            }
            main(".response_win").window("close");
        })
        var api_request_remove = function(){
            var requestParam = getRowData(getRequestParam(),$(this).attr("index"));
            main(".api_request").datagrid('loadData', requestParam);
            /*            $.post('api/delRow',requestParam,function(data){
                            main(".easyui-textbox").textbox({});
                            main(".easyui-linkbutton").linkbutton({});
                        })*/
        }
        var api_response_remove = function(){
            var responseParam = getRowData(getResponseParam(),$(this).attr("index"));
            main(".api_response").datagrid('loadData', responseParam);
            /*            $.post('api/delRow',requestParam,function(data){
                            main(".easyui-textbox").textbox({});
                            main(".easyui-linkbutton").linkbutton({});
                        })*/
        }
        main(".api_request").datagrid("options").view.onAfterRender = function(target){
            main(".index_request .api_action").on("click",api_request_remove);
            main(".easyui-textbox").textbox({});
            main(".easyui-linkbutton").linkbutton({});
        }
        main(".api_response").datagrid("options").view.onAfterRender = function(target){
            main(".index_response .api_action").on("click",api_response_remove);
            main(".easyui-textbox").textbox({});
            main(".easyui-linkbutton").linkbutton({});
        }
        main().on("keydown",function(e){
            if(e.keyCode==40){
                console.log(main('.api_tab'))
                var tab = main('.api_tab').tabs('getSelected');
                var index = main('.api_tab').tabs('getTabIndex',tab);
                if(index == 0){
                    var requestParam = getRequestParam();
                    main(".api_request").datagrid('loadData', getRowData(requestParam));
                }else if(index == 1){
                    var responseParam = getResponseParam();
                    main(".api_response").datagrid('loadData', getRowData(responseParam));
                }
            }
        });
        /*        keydown(function(e){
                    if(e.keyCode==40){
                        var tab = $('#tt').tabs('getSelected');
                        var index = $('#tt').tabs('getTabIndex',tab);
                        if(index == 0){
                            var requestParam = getRequestParam();
                            main(".api_request").datagrid('loadData', getRowData(requestParam));
                        }else if(index == 1){
                            var responseParam = getResponseParam();
                            main(".api_response").datagrid('loadData', getRowData(responseParam));
                        }
                    }
                })*/
    })
})(jQuery)
function action_formatter(value,row,index){
    return "<a href='#' class='easyui-linkbutton api_action' iconCls='icon-clear' plain='true' index='"+index+"'></a>";
}
function name_formatter(value,row,index){
    return "<input class='easyui-validatebox easyui-textbox' name='name' style='width:100px' value='" + value + "'>";
}
function value_formatter(value,row,index){
    return "<input class='easyui-validatebox easyui-textbox'name='value' style='width:200px' value='" + value + "'>";
}
function isRequired_formatter(value,row,index){
    if(value){
        return "<input  type='checkbox' style='width:50px' name='isRequired' value='"+ value +"' checked>";
    }else{
        return "<input  type='checkbox' style='width:50px' name='isRequired' value='"+ value +"' >";
    }
}