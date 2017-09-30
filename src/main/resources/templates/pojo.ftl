
<#list typeList as tt>
import ${tt};
</#list>

public class ${tableName?cap_first} {

<#list list as p>
    private ${p.type} ${p.columnAlias!p.columnName}; <#if p.columnComment!=''>//</#if>${p.columnComment}

</#list>

<#list list as p>
    public ${p.type} get${(p.columnAlias!p.columnName)?cap_first}() {
        return ${p.columnAlias!p.columnName};
    }

    public void set${(p.columnAlias!p.columnName)?cap_first}(${p.type} ${p.columnAlias!p.columnName}) {
        this.${p.columnAlias!p.columnName} = ${p.columnAlias!p.columnName};
    }

</#list>

}