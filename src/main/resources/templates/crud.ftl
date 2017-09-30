<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="">

    <sql id="Base_Column_List">
<#list list as p>
        ${p.columnName}<#if p.columnAlias??> </#if>${ (p.columnAlias)!''}<#if (p_index != (list?size-1))>,</#if>
</#list>
    </sql>


    <select id="findListCount" resultType="int">
        SELECT
            COUNT(1)
        FROM ${tableName}
    </select>

    <select id="findList" resultType="map">
        SELECT
            <include refid="Base_Column_List"/>
        FROM ${tableName}
        limit 0,10
    </select>

    <select id="findById" resultType="map">
        SELECT
            <include refid="Base_Column_List"/>
        FROM ${tableName}
        WHERE id = ${r"#{id}"}
    </select>


    <update id="update">
        UPDATE
            ${tableName}
        SET
            <#list list as p>
            <if test="${(p.columnAlias)!p.columnName} !=null"> ${p.columnName} = ${r"#{"}${(p.columnAlias)!p.columnName}${r"},"} </if>
            </#list>
        WHERE id = ${r"#{id}"}
    </update>

    <insert id="save" useGeneratedKeys="true" keyProperty="id">
        INSERT INTO
            ${tableName}
        <trim prefix="(" suffix=")" suffixOverrides="," >
            <#list list as p>
            <if test="${(p.columnAlias)!p.columnName} != null and ${(p.columnAlias)!p.columnName} != ''" > ${p.columnName}, </if>
            </#list>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides="," >
            <#list list as p>
            <if test="${(p.columnAlias)!p.columnName} != null and ${(p.columnAlias)!p.columnName} !=''" > ${r"#{"}${(p.columnAlias)!p.columnName}${r"},"} </if>
            </#list>
        </trim>
    </insert>

    <delete id="delete">
        DELETE
        FROM
            ${tableName}
        WHERE id = ${r"#{id}"}
    </delete>

</mapper>