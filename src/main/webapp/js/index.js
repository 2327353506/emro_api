(function($){
    var menu_tree = [
        { name:"BOSS",icon:"img/boss.png",select:"true"},
        { name:"CRM",icon:"img/crm.png"},
        { name:"SAAS",icon:"img/saas.png"},
    ];
    var main = function(val){
        return $("#index").find(val)
    };
    var init = function(){
        var menu_html = "";
        //var node_first = main('.tree').tree('getRoot');
        //main('.index_tree').tree('select', node_first.target);
/*        main('.index_datagrid').datagrid('load',{
            'name': "BOSS"
        });*/
        main(".index_suff").text("192.168.1.211:8080/emro_boss/")
        $(menu_tree).each(function(index){
            if(this.select){
                menu_html = menu_html +
                    "<li index='"+ index +"' class='select' mt-name='"+ this.name +
                    "' mt-icon='"+ this.icon +"'><a href='#'  value=''><span><img src='"+
                    this.icon +"' width='35px' height='35px'></img></span><span style='display:block;'>"+
                    this.name +"</span></a></li>";
            }else{
                menu_html = menu_html +
                    "<li index='"+ index +"'  mt-name='"+ this.name +
                    "' mt-icon='"+ this.icon +"'><a href='#'  value=''><span><img src='"+
                    this.icon +"' width='35px' height='35px'></img></span><span style='display:block;'>"+
                    this.name +"</span></a></li>";
            }

        });
        main(".menu_tree").html(menu_html);
    };

    var select_tree = function(){
        var index = $(".menu_tree .select").attr("index");
        return menu_tree[index];
    };
    var winParam = {
        width:700,
        height:650,
        modal:true,
        title : '新增',
        maximizable:true,
        closable:true,
        closed : true,
        shadow : true,
        inline : true,
        content:"<iframe src='' height='100%' width='100%' style='border: none;' ></iframe>"
    };
/*    var select_tree = function(){
        return main('.index_tree').tree('getSelected');
    };*/
    $(function(){
/*        main(".index_tree").tree({
            onClick: function(node){
                main(".index_suff").text("192.168.1.211:8080/emro_"+ node.text.toLowerCase() +"/");
                main('.index_datagrid').datagrid('load',{
                    'name': node.text
                });
            }
        });*/

        main(".index_datagrid").datagrid({
            onClickRow : function(rowIndex, rowData){
                $.get("api/detail?id=" + rowData.id,function(data){
                    main("form .index_url").textbox("setValue", data.url);
                    main("form .index_remark").textbox("setValue", data.remark);
                    main("form .index_method").textbox("setValue", data.method);
                });
                main('.index_request_data').datagrid('load',{
                    'id': rowData.id
                });
                main('.index_response_data').datagrid('load',{
                    'id': rowData.id
                });
            }
        });
        main(".win").window(winParam);
        main('.index_datagrid').datagrid({
            queryParams: {
                name: 'BOSS',
            }
        });
        init();
        main(".doSearch").on("click",function(){
            main('.index_datagrid').datagrid('load',{
                'remark': main(".index_toolbar .index_remark").textbox("getValue"),
                'createBy': main(".index_toolbar .index_createBy").textbox("getValue"),
                'method' : main(".index_toolbar .index_method").textbox("getValue"),
                'name' : select_tree().name,
            });
        });

        main(".remove").on("click",function(){
            var row = main('.index_datagrid').datagrid('getSelected');
            $.post("api/del",{"id":row.id},function(data){
                if(data.code==0){
                    $.messager.alert('api','删除成功!');
                    main('.index_datagrid').datagrid('reload');
                }else{
                    $.messager.alert('api','删除失败!');
                }
            })
        })

        main(".add").on("click",function(){
            var node = select_tree();
            if(!node){
                $.messager.alert('api','请选择平台');
                return;
            }
            main('.win iframe').attr("src","api.jsp?cache"+new Date().getTime());
            main('.win').window('open');
        })

        main(".edit").on("click",function(){
            var row = main('.index_datagrid').datagrid('getSelected');
            if(row){
                main('.win iframe').attr("src","api.jsp?id=" + row.id + "&cache"+new Date().getTime());
                main('.win').window('open');
            }
        });

        main(".menu_tree li").on("click",function(){
            $(".menu_tree .select").removeClass("select")
            $(this).addClass("select")
            var index = $(this).attr("index")
            var tree_data = menu_tree[index];
            main(".index_suff").text("192.168.1.211:8080/emro_"+ tree_data.name.toLowerCase() +"/");
            main('.index_datagrid').datagrid('load',{
                'name': tree_data.name
            });
        });

    })
})(jQuery)