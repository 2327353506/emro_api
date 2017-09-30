(function($){
    var main = function(val){
        if(val){
            return $("#system").find(val);
        }else{
            return $("#system");
        }
    };
    var menu_tree = [
        { name:"账号管理",icon:"img/boss.png",href : "page/sysStaff.jsp"},
        { name:"数据管理",icon:"img/boss.png",href : "page/sysData.jsp"}
    ];
    var add_tab = function(title,content){
        var tab = main('.system_tab').tabs('getTab',title);
        if(tab){
            main('.system_tab').tabs('select',title);
        }else{
            main('.system_tab').tabs('add',{
                title: title,
                selected: true,
                content:content,
                closable:true,
                tools:[{
                    iconCls: 'icon-refresh',
                    handler:function(title){
                        var tab = main('.system_tab').tabs('select',title);
                        tab.panel('refresh')
                    }
                }]
            });
        }
    }
    var init = function(){
        var menu_html = ""
        $(menu_tree).each(function(index){

                menu_html = menu_html +
                    "<li index='"+ index +"'  mt-name='"+ this.name +
                    "' mt-icon='"+ this.icon +"'><a href='#'  value=''><span><img src='"+
                    this.icon +"' width='35px' height='35px'></img></span><span style='display:block;'>"+
                    this.name +"</span></a></li>";

        });
        main(".menu_tree").html(menu_html);
    };
    $(function(){
        init();
        main(".menu_tree li").on("click",function(){
            $(".menu_tree .select").removeClass("select")
            $(this).addClass("select")
            var index = $(this).attr("index")
            var tree_data = menu_tree[index];
            var content = "<iframe src='"+ tree_data.href +"' height='100%'width='100%' style='border: none;'>";
            add_tab(tree_data.name,content);
        });
    })
})(jQuery)