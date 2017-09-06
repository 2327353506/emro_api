package emro.view;

import emro.service.StaffService;
import emro.util.ResponseMsg;
import emro.vo.StaffVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Controller
@RequestMapping("staff")
public class StaffView {

    @Autowired
    private StaffService staffService;

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> getStaffList(StaffVo vo){
        return staffService.getStaffList(vo);
    };

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public ResponseMsg addStaff(StaffVo vo){
        ResponseMsg msg = new ResponseMsg();
        try{
            staffService.addStaff(vo);
        }catch (Exception e){
            msg.setError(e);
        }
        return msg;
    };

    @RequestMapping(value = "/editPswd",method = RequestMethod.POST)
    @ResponseBody
    public ResponseMsg editPswd(StaffVo vo, HttpServletResponse response,HttpServletRequest request){
        ResponseMsg msg = new ResponseMsg();
        try{
            staffService.editPswd(vo);
            request.getSession().setAttribute("sessionLogin",null);
            Cookie cookie = new Cookie("API_LG",null);
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
        }catch (Exception e){
            msg.setError(e);
        }
        return msg;
    };
}
