package com.project.wsch.vo;

public class BoardVO {
    private int no;                 // 글 번호
    private String subject;         // 제목
    private String startDate;       // 시작 날짜
    private String endDate;         // 종료 날짜
    private String location;        // 장소
    private int fee;             // 참가 비용
    private String content;         // 내용
    private String userid;          // 작성자
    private int hit;                // 조회수
    private String writedate;       // 등록일
    private String ip;              // 작성자 IP
    private String poster;          // 포스터

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getFee() {
        return String.valueOf(fee);
    }

    public void setFee(int fee) {
        this.fee = fee;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public int getHit() {
        return hit;
    }

    public void setHit(int hit) {
        this.hit = hit;
    }

    public String getWritedate() {
        return writedate;
    }

    public void setWritedate(String writedate) {
        this.writedate = writedate;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }
    
    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    @Override
    public String toString() {
        return "BoardVO [no=" + no + ", subject=" + subject + ", startDate=" + startDate + ", endDate=" + endDate
                + ", location=" + location + ", fee=" + fee + ", content=" + content + ", userid=" + userid + ", hit="
                + hit + ", writedate=" + writedate + ", ip=" + ip + ", poster=" + poster + "]";
    }
}
