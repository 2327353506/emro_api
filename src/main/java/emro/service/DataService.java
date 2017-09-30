package emro.service;

import emro.vo.DataVo;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface DataService {

    Map<String,Object> getList(DataVo vo);

    List getDataChList(DataVo vo);

    Map<String,Object> createCRUD(DataVo vo);

    Map<String,Object> createPOJO(DataVo vo) throws IOException;
}
