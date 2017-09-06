package emro.service.impl;

import com.alibaba.fastjson.JSONObject;
import emro.dao.StaffDao;
import emro.po.Staff;
import emro.service.LoginService;
import emro.util.PropertyUtil;
import emro.vo.SessionLogin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService{

    @Autowired
    private StaffDao staffDao;

    @Override
    public SessionLogin login(String username, String password) {
        Staff staff = staffDao.login(username.trim(),password.trim());
        if(staff == null){
            throw new RuntimeException("用户名密码错误");
        }
        SessionLogin login = new SessionLogin();
        login.setPassword(staff.getPassword());
        login.setUsername(staff.getUsername());
        login.setName(staff.getName());
        return login;
    }
}
