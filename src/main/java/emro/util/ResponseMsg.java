package emro.util;

public class ResponseMsg {

    private String msg;
    private int code;
    private Object Data;

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public Object getData() {
        return Data;
    }

    public void setData(Object data) {
        Data = data;
    }

    public void setError(Exception e){
        this.setCode(-1);
        this.setData(null);
        e.printStackTrace();
        this.setMsg("接口异常 : "+e.getMessage());
    }
}
