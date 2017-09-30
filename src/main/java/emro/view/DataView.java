package emro.view;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import emro.service.DataService;
import emro.service.StaffService;
import emro.util.ResponseMsg;
import emro.vo.DataVo;
import emro.vo.StaffVo;
import freemarker.core.Configurable;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("data")
public class DataView {

    @Autowired
    private DataService dataService;

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> getDataList(DataVo vo){
        return dataService.getList(vo);
    };

    @RequestMapping(value = "/chList",method = RequestMethod.GET)
    @ResponseBody
    public List getDataChList(DataVo vo){
        return dataService.getDataChList(vo);
    };

    @RequestMapping(value = "/create",method = RequestMethod.GET)
    @ResponseBody
    public ResponseMsg createCRUD(DataVo vo){
        ResponseMsg msg = new ResponseMsg();
        try {
            Map map = dataService.createCRUD(vo);
            Configuration cfg = new Configuration();
            cfg.setDirectoryForTemplateLoading(new ClassPathResource("/templates").getFile());
            cfg.setObjectWrapper(new DefaultObjectWrapper());
            cfg.setDefaultEncoding("UTF-8");   //这个一定要设置，不然在生成的页面中 会乱码
            //获取或创建一个模版。
            Template template = cfg.getTemplate("crud.ftl");
            ByteArrayOutputStream out = new ByteArrayOutputStream();

            Writer w = new OutputStreamWriter(out);
            template.process(map,w);
            msg.setData(new String(out.toByteArray(),"utf-8"));
        }catch (Exception e){
            msg.setError(e);
        }
        return msg;
    };

    @RequestMapping(value = "/createPOJO",method = RequestMethod.GET)
    @ResponseBody
    public ResponseMsg createPOJO(DataVo vo){
        ResponseMsg msg = new ResponseMsg();
        try {
            Map map = dataService.createPOJO(vo);
            Configuration cfg = new Configuration();
            cfg.setDirectoryForTemplateLoading(new ClassPathResource("/templates").getFile());
            cfg.setObjectWrapper(new DefaultObjectWrapper());
            cfg.setDefaultEncoding("UTF-8");   //这个一定要设置，不然在生成的页面中 会乱码
            //获取或创建一个模版。
            Template template = cfg.getTemplate("pojo.ftl");
            ByteArrayOutputStream out = new ByteArrayOutputStream();

            Writer w = new OutputStreamWriter(out);
            template.process(map,w);
            msg.setData(new String(out.toByteArray(),"utf-8"));
        }catch (Exception e){
            msg.setError(e);
        }
        return msg;
    };

    public static void main(String[] args) throws IOException, TemplateException {
        Configuration cfg = new Configuration();
        cfg.setDirectoryForTemplateLoading(new ClassPathResource("/templates").getFile());
        cfg.setObjectWrapper(new DefaultObjectWrapper());
        cfg.setDefaultEncoding("UTF-8");   //这个一定要设置，不然在生成的页面中 会乱码
        //获取或创建一个模版。
        Template template = cfg.getTemplate("crud.ftl");
        Map<String,Object> map = new HashMap<>();
        map.put("tableName","order_info");
        JSONArray ja = new JSONArray();
        JSONObject jo = new JSONObject();
        jo.put("columnName","order_status");
        jo.put("columnAlias","orderStatus");
        JSONObject jo1 = new JSONObject();
        jo1.put("columnName","id");
        jo1.put("columnAlias","id");
        ja.add(jo);
        ja.add(jo1);
        map.put("list",ja);
        FileOutputStream out = new FileOutputStream(new File("D://aaa.txt"));
        Writer w = new OutputStreamWriter(out);
        template.process(map,w);

    }

}
