package net.java_school.bbs;

import java.util.Date;

public class Comments {
	private int commentNo;
	private int articleNo;
	private String owner;
	private String nickname;
	private String memo;
	private Date regdate;

	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getArticleNo() {
		return articleNo;
	}
	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
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
	public String getMemo() {
		return memo;
	}
	public String getHtmlMemo() {
		if (memo != null) {
			return memo.replace(System.getProperty("line.separator"), "<br />");
		}
		return null;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
}