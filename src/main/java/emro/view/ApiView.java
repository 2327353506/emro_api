package emro.view;


import emro.service.ApiService;
import emro.util.ResponseMsg;
import emro.vo.ApiVo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("api")
public class ApiView {

    @Autowired
    private ApiService apiService;

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> getApiList(ApiVo vo){
        return apiService.getApiList(vo);
    };

    @RequestMapping(value = "/detail",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> getApiDetail(ApiVo vo){
        return apiService.getApiDetail(vo);
    };

    @RequestMapping(value = "/getRequest",method = RequestMethod.GET)
    @ResponseBody
    public List<Map> getRequest(ApiVo vo){
        return apiService.getRequest(vo);
    };

    @RequestMapping(value = "/getResponse",method = RequestMethod.GET)
    @ResponseBody
    public List<Map> getResponse(ApiVo vo){
        return apiService.getResponse(vo);
    };

    @RequestMapping(value = "/del",method = RequestMethod.POST)
    @ResponseBody
    public ResponseMsg delApi(ApiVo vo){
        ResponseMsg msg = new ResponseMsg();
        try{
            apiService.delApi(vo);
        }catch (Exception e){
            msg.setError(e);
        }
        return msg;
    };

    @RequestMapping(value = "/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseMsg saveApi(ApiVo vo){
        ResponseMsg msg = new ResponseMsg();
        try{
            apiService.saveApi(vo);
        }catch (Exception e){
            msg.setError(e);
        }
        return msg;
    };

    @RequestMapping(value = "/addRow",method = RequestMethod.POST)
    @ResponseBody
    public List<Map> addRow(ApiVo vo){
        List<Map> list = new ArrayList<>();
        if(StringUtils.isNotBlank(vo.getName())){
            String[] name = vo.getName().split(",");
            String[] value = vo.getValue().split(",");
            String[] isRequired = vo.getIsRequired().split(",");
            for (int i = 0; i < name.length; i++) {
                Map map = new HashMap();
                map.put("name",name[i].trim());
                map.put("value",value.length>i?value[i].trim():"");
                map.put("isRequired",Boolean.valueOf(isRequired.length>i?isRequired[i].trim():"false"));
                map.put("action","");
                list.add(map);
            }
        }
        Map map = new HashMap();
        map.put("name","");
        map.put("value","");
        map.put("isRequired","");
        map.put("action","");
        list.add(map);
        return list;
    };

    @RequestMapping(value = "/delRow",method = RequestMethod.POST)
    @ResponseBody
    public List<Map> delRow(ApiVo vo){
        List<Map> list = new ArrayList<>();
        if(StringUtils.isNotBlank(vo.getName())){
            String[] name = vo.getName().split(",");
            String[] value = vo.getValue().split(",");
            String[] isRequired = vo.getIsRequired().split(",");
            for (int i = 0; i < name.length; i++) {
                if(i!=vo.getIndex()){
                    Map map = new HashMap();
                    map.put("name",name[i].trim());
                    map.put("value",value.length>i?value[i].trim():"");
                    map.put("isRequired",Boolean.valueOf(isRequired.length>i?isRequired[i].trim():"false"));
                    map.put("action","");
                    list.add(map);
                }
            }
        }
        return list;
    };


    @RequestMapping(value = "/addManyRow",method = RequestMethod.POST)
    @ResponseBody
    public List<Map> addRow(String msg){
        List<Map> list = new ArrayList<>();
        if(StringUtils.isNotBlank(msg)){
            List<String> params = transParam(msg);
            for (String param : params) {
                Map map = new HashMap();
                map.put("name",param);
                map.put("value","");
                map.put("isRequired",false);
                map.put("action","");
                list.add(map);
            }
        }
        return list;
    };


    private List<String> transParam(String paramStr){
        String regex = "\\(([a-z]|[A-Z]|[0-9]|[\\s.,_!<>=+@#{}\\*/%\\-\\'])*\\)";
        // 如果还有括号的话 循环清除
        while (paramStr.matches("[\\s\\S]*\\([\\s\\S]*\\)[\\s\\S]*")){
            paramStr = paramStr.replaceAll(regex, "");
        }
        List<String> rtnList = new ArrayList<>();
        String[] params = paramStr.split(",");
        for(String param : params){
            param = param.trim();
            int indexOf = 0;
            if(param.lastIndexOf(" ") > 0 && param.length() > param.lastIndexOf(" ")){
                indexOf = param.lastIndexOf(" ");
            }
            param = param.substring(indexOf);
            if(param.indexOf(".") > 0 && param.length() > param.indexOf(".")){
                param = param.substring(param.indexOf(".") + 1);
            }
            rtnList.add(param.trim());
        }
        return rtnList;
    }
}
