package emro.view;

import emro.service.LoginService;
import emro.util.ResponseMsg;
import emro.vo.SessionLogin;
import net.rubyeye.xmemcached.MemcachedClient;
import org.bouncycastle.jcajce.provider.digest.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.UUID;

@Controller
@RequestMapping("login")
public class LoginView {

    @Autowired
    private LoginService loginService;
    @Autowired
    private MemcachedClient memcachedClient;

    @RequestMapping(method= RequestMethod.POST)
    @ResponseBody
    public ResponseMsg login(String username, String password,
                             HttpServletRequest request, HttpServletResponse response){
        ResponseMsg msg = new ResponseMsg();
        try{
            SessionLogin login = loginService.login(username,password);
            request.getSession().setAttribute("sessionLogin",login);
            String loginKey = UUID.randomUUID().toString().replaceAll("-","");
            Cookie cookie = new Cookie("API_LG", loginKey);
            cookie.setMaxAge(24 * 60 * 60);
            response.addCookie(cookie);
            memcachedClient.set(loginKey,60*60*24,login);
            login = memcachedClient.get(loginKey);
        }catch (Exception e){
            msg.setError(e);
        }
        return msg;
    }

    public static void main(String[] arg){
        String loginKey = UUID.randomUUID().toString().replaceAll("-","");
        System.out.println(loginKey);
    }
}
