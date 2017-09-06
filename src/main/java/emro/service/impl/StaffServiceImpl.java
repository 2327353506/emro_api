package emro.service.impl;

import emro.dao.StaffDao;
import emro.po.Staff;
import emro.service.StaffService;
import emro.vo.SessionLogin;
import emro.vo.StaffVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class StaffServiceImpl implements StaffService{

    @Autowired
    private StaffDao staffDao;

    @Override
    public Map<String, Object> getStaffList(StaffVo vo) {
        Map<String, Object> map = new HashMap<>();
        map.put("rows", staffDao.findStaffList(vo));
        map.put("total", staffDao.findStaffListCount(vo));
        return map;
    }

    @Override
    public void addStaff(StaffVo vo) {
        staffDao.addStaff(vo);
    }

    @Override
    public void editPswd(StaffVo vo) {
        Staff staff =  staffDao.login(SessionLogin.getLoginId(),vo.getOldPassword().trim());
        if(staff != null){
            staffDao.editPswd(vo);
        }else{
            throw new RuntimeException("密码不正确")
;        }
    }


}
