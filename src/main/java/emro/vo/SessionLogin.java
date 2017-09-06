package emro.vo;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.Serializable;

public class SessionLogin implements Serializable{

    private static final long serialVersionUID = -8997663745497211585L;



    private String username;
    private String password;
    private String name;
    private boolean hasManger;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isHasManger() {
        return hasManger;
    }

    public void setHasManger(boolean hasManger) {
        this.hasManger = hasManger;
    }

    public static String getLoginId(){
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        SessionLogin sessionInfo = (SessionLogin) session.getAttribute("sessionLogin");
        return sessionInfo.getUsername();

    }
}
