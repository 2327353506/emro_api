package emro.service.impl;

import com.alibaba.fastjson.JSONObject;
import emro.dao.DataDao;
import emro.service.DataService;
import emro.vo.DataVo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.Writer;
import java.util.*;

@Service
public class DataServiceImpl implements DataService{

    @Autowired
    private DataDao dataDao;

    @Override
    public Map<String, Object> getList(DataVo vo) {
        Map<String, Object> map = new HashMap<>();
        map.put("rows",dataDao.getList(vo));
        map.put("total",dataDao.getListCount(vo));
        return map;
    }

    @Override
    public List getDataChList(DataVo vo) {
        return dataDao.getChList(vo);
    }

    @Override
    public Map<String, Object> createCRUD(DataVo vo) {
        Map<String, Object> res = new HashMap<>();
        List<Map> list = dataDao.getChList(vo);
        for(Iterator<Map> it = list.iterator();it.hasNext();){
            Map map= it.next();
            JSONObject jo = new JSONObject(map);
            String columnName = jo.getString("columnName");
            if(columnName.indexOf("_")>=0){
                while (columnName.indexOf("_") != -1){
                    columnName = columnName.substring(0,columnName.indexOf("_")) +
                            columnName.substring(columnName.indexOf("_") + 1 ,columnName.indexOf("_") + 2 ).toUpperCase() +
                            columnName.substring(columnName.indexOf("_") + 2 );
                }
                map.put("columnAlias",columnName);
            }
        }
        res.put("tableName", vo.getName());
        res.put("list", list);
        return res;
    }

    @Override
    public Map<String, Object> createPOJO(DataVo vo) throws IOException {
        List<Map> list = dataDao.getChList(vo);
        Map<String, Object> res = new HashMap<>();
        ClassPathResource data = new ClassPathResource("/templates/dataType.json");
        String typeStr = jsonRead(data.getFile());
        JSONObject tyoeJson = JSONObject.parseObject(typeStr);
        Set<String> set = new HashSet<>();
        for(Iterator<Map> it = list.iterator();it.hasNext();){
            Map map= it.next();
            JSONObject jo = new JSONObject(map);
            String columnName = jo.getString("columnName");
            String dataType = jo.getString("dataType");
            if(columnName.indexOf("_")>=0){
                while (columnName.indexOf("_") != -1){
                    columnName = columnName.substring(0,columnName.indexOf("_")) +
                            columnName.substring(columnName.indexOf("_") + 1 ,columnName.indexOf("_") + 2 ).toUpperCase() +
                            columnName.substring(columnName.indexOf("_") + 2 );
                }
                map.put("columnAlias",columnName);
            }
            String type = tyoeJson.getJSONObject(dataType).getString("type");
            String packageType = tyoeJson.getJSONObject(dataType).getString("packageType");
            map.put("type",type);
            if(StringUtils.isNotBlank(packageType)){
                set.add(packageType);
            }
        }
        while (vo.getName().indexOf("_") != -1){
            vo.setName(vo.getName().substring(0,vo.getName().indexOf("_")) +
                    vo.getName().substring(vo.getName().indexOf("_") + 1 ,vo.getName().indexOf("_") + 2 ).toUpperCase() +
                    vo.getName().substring(vo.getName().indexOf("_") + 2 ));
        }
        res.put("tableName", vo.getName());
        res.put("list", list);
        res.put("typeList", set);
        return res;
    }

    /**
     *     读取文件类容为字符串
     * @param file
     * @return
     */
    public static String jsonRead(File file){
        Scanner scanner = null;
        StringBuilder buffer = new StringBuilder();
        try {
            scanner = new Scanner(file, "utf-8");
            while (scanner.hasNextLine()) {
                buffer.append(scanner.nextLine());
            }
        } catch (Exception e) {

        } finally {
            if (scanner != null) {
                scanner.close();
            }
        }
        return buffer.toString();
    }

}
