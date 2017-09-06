package emro.service;

import emro.vo.SessionLogin;

public interface LoginService {


    SessionLogin login(String username, String password);
}
