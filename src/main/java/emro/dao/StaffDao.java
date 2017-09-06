package emro.dao;

import emro.po.Staff;
import emro.vo.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface StaffDao {

    
    List<Map> findStaffList(Page vo);

    int findStaffListCount(Page vo);

    void addStaff(Page vo);

    void editPswd(Page vo);

    Staff login(@Param("username") String trim, @Param("password")String s);
}
