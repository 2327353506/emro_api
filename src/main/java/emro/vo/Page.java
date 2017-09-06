package emro.vo;

public class Page {

    private int page = 0;
    private int rows = 10;
    private String limit;


    public int getPage() {
        if(page-1 < 0){
            return 0;
        }
        return page-1;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getRows() {
        if(rows < 0){
            return 10;
        }
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    public String getLimit() {
        if(limit == null){
            return "limit " +
                    this.getPage() * this.getRows() +
                    "," +
                    this.getRows();
        }
        return limit;
    }

    public void setLimit(String limit) {
        this.limit = limit;
    }
}
