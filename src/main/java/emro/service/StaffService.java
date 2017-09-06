package emro.service;

import emro.vo.StaffVo;

import java.util.Map;

public interface StaffService {


    Map<String,Object> getStaffList(StaffVo vo);

    void addStaff(StaffVo vo);

    void editPswd(StaffVo vo);

}
