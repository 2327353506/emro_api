package emro.Filter;

import com.sun.tools.internal.xjc.reader.xmlschema.bindinfo.BIConversion;
import emro.vo.SessionLogin;
import net.rubyeye.xmemcached.MemcachedClient;
import net.rubyeye.xmemcached.exception.MemcachedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.TimeoutException;

public class LoginFilter implements Filter{

    public static final String login_page = "login.jsp";
    public static final String tologin_page = "/login";
    @Autowired
    private MemcachedClient memcachedClient;


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;
        StringBuffer url = request.getRequestURL();
        SessionLogin login = (SessionLogin) request.getSession().getAttribute("sessionLogin");
        if(url.indexOf("/login")>=0 ||
            url.indexOf("/js/") > 0 ||
            url.indexOf("/css/") > 0 ||
            url.indexOf("/fonts/") > 0 ||
            url.indexOf("/plugin/") > 0
         ){
            filterChain.doFilter(request,response);
            return;
        }else{
            if(login != null){
                filterChain.doFilter(request,response);
            }else{
                Cookie[] cookies = request.getCookies();
                if(cookies != null && cookies.length >0){
                    for (Cookie cookie: cookies) {
                        if("API_LG".equals(cookie.getName())){
                            try {
                                ApplicationContext appC= new FileSystemXmlApplicationContext("classpath:spring-xmemcached.xml");
                                memcachedClient = (MemcachedClient)appC.getBean("memcachedClient");
                                SessionLogin lg = memcachedClient.get(cookie.getValue());
                                if(lg != null){
                                    request.getSession().setAttribute("sessionLogin",lg);
                                    filterChain.doFilter(request,response);
                                    return;
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
                response.sendRedirect(login_page);
            }
        }


    }

    @Override
    public void destroy() {

    }
}
