package emro.service.impl;

import com.alibaba.fastjson.JSONObject;
import emro.dao.ApiDao;
import emro.service.ApiService;
import emro.vo.ApiVo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ApiServiceImpl implements ApiService{

    @Autowired
    private ApiDao apiDao;

    @Override
    public Map<String, Object> getApiList(ApiVo vo) {
        Map<String,Object> result = new HashMap<>();
        result.put("total",apiDao.findApiListCount(vo));
        result.put("rows",apiDao.findApiList(vo));
        return result;
    }

    @Override
    public Map<String, Object> getApiDetail(ApiVo vo) {
        Map<String, Object> map = apiDao.findApi(vo);
        map.put("requestParam",apiDao.findApiRequestParam(vo));
        map.put("responseParam",apiDao.findApiResponseParam(vo));
        return map;
    }

    @Override
    public List<Map> getRequest(ApiVo vo) {
        return apiDao.findApiRequestParam(vo);
    }

    @Override
    public List<Map> getResponse(ApiVo vo) {
        return apiDao.findApiResponseParam(vo);
    }

    @Override
    public void delApi(ApiVo vo) {
        apiDao.removeApi(vo);
    }

    @Override
    public void saveApi(ApiVo vo) {
        String requestStr = vo.getRequestParam();
        String responseStr = vo.getResponseParam();
        if(StringUtils.isBlank(vo.getId())){
            apiDao.saveApi(vo);
        }else{
            apiDao.updateApi(vo);
            apiDao.delApiCh(vo);
        }
        saveAPiRequestParam(requestStr,vo);
        saveAPiResponseParam(responseStr,vo);
    }

    private void saveAPiResponseParam(String responseStr, ApiVo vo) {
        JSONObject responseJson = JSONObject.parseObject(responseStr);
        String[] nameArray = responseJson.getString("name").split(",");
        String[] valueArray = responseJson.getString("value").split(",");
        for(int i=0;i<nameArray.length;i++){
            String name = nameArray[i].trim();
            String value = valueArray[i].trim();
            if(StringUtils.isNotBlank(name) || StringUtils.isNotBlank(value)){
                apiDao.saveResponseApi(vo,name,value);
            }
        }
    }

    private void saveAPiRequestParam(String requestStr, ApiVo vo) {
        JSONObject requestJson = JSONObject.parseObject(requestStr);
        String[] nameArray = requestJson.getString("name").split(",");
        String[] valueArray = requestJson.getString("value").split(",");
        String[] isArray = requestJson.getString("isRequired").split(",");
        for(int i=0;i<nameArray.length;i++){
            String name = nameArray[i].trim();
            String value = valueArray[i].trim();
            String isRequired = isArray[i].trim();
            if("true".equals(isRequired)){
                isRequired = "1";
            }else{
                isRequired = "0";
            }
            if(StringUtils.isNotBlank(name) || StringUtils.isNotBlank(value)){
                apiDao.saveRequestApi(vo,name,value,isRequired);
            }
        }
    }
}
