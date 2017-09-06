<%--
  Created by IntelliJ IDEA.
  User: wangmt
  Date: 2017/9/4
  Time: 16:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="south" style="float: right">
</div>
<script language="javascript">
    $(function(){
        setInterval(function(){
            $("#south").text(new Date().toLocaleString());
        },1000);
    });
</script>
