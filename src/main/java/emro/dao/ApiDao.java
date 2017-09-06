package emro.dao;

import emro.vo.ApiVo;
import emro.vo.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ApiDao {

    int findApiListCount(ApiVo page);

    List<Map> findApiList(ApiVo page);

    Map<String,Object> findApi(ApiVo vo);

    List<Map> findApiRequestParam(ApiVo vo);

    List<Map> findApiResponseParam(ApiVo vo);

    void removeApi(ApiVo vo);

    void saveApi(ApiVo vo);

    void saveResponseApi(@Param("vo") ApiVo vo, @Param("name")String name, @Param("value")String value);

    void saveRequestApi(@Param("vo")ApiVo vo, @Param("name")String name, @Param("value")String value, @Param("isRequired")String isRequired);

    void updateApi(ApiVo vo);

    void delApiCh(ApiVo vo);
}
