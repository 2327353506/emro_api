package emro.dao;

import emro.vo.DataVo;

import java.util.List;

public interface DataDao {

    List getList(DataVo vo);

    int getListCount(DataVo vo);

    List getChList(DataVo vo);
}
