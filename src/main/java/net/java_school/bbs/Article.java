package net.java_school.bbs;

import java.util.Date;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Article {

    private Integer articleNo;
    private String boardCd;

    @NotNull
    @Size(min = 1, max = 100, message = "{bbs.title.validation.error}")
    private String title;

    @NotNull
    @Size(min = 2, message = "{bbs.content.validation.error}")
    private String content;

    private String owner;
    private String nickname;
    private int hit;
    private Date regdate;
    private int attachFileNum;
    private int commentNum;

    public Integer getArticleNo() {
        return articleNo;
    }

    public void setArticleNo(Integer articleNo) {
        this.articleNo = articleNo;
    }

    public String getBoardCd() {
        return boardCd;
    }

    public void setBoardCd(String boardCd) {
        this.boardCd = boardCd;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getHit() {
        return hit;
    }

    public void setHit(int hit) {
        this.hit = hit;
    }

    public Date getRegdate() {
        return regdate;
    }

    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }

    public int getAttachFileNum() {
        return attachFileNum;
    }

    public void setAttachFileNum(int attachFileNum) {
        this.attachFileNum = attachFileNum;
    }

    public int getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(int commentNum) {
        this.commentNum = commentNum;
    }
}
