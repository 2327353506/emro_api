package emro.service;

import emro.vo.ApiVo;

import java.util.List;
import java.util.Map;

public interface ApiService {


    Map<String,Object> getApiList(ApiVo page);


    Map<String,Object> getApiDetail(ApiVo vo);

    List<Map> getRequest(ApiVo vo);

    List<Map> getResponse(ApiVo vo);

    void delApi(ApiVo vo);

    void saveApi(ApiVo vo);
}
