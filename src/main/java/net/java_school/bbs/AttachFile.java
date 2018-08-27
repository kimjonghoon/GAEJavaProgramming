package net.java_school.bbs;

import java.util.Date;

public class AttachFile {
	private int attachFileNo;
	private String filekey;
	private String filename;
	private String filetype;
	private long filesize;
	private Date creation;
	private int articleNo;
	private String owner;

	public int getAttachFileNo() {
		return attachFileNo;
	}
	public void setAttachFileNo(int attachFileNo) {
		this.attachFileNo = attachFileNo;
	}
	public String getFilekey() {
		return filekey;
	}
	public void setFilekey(String filekey) {
		this.filekey = filekey;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	public Date getCreation() {
		return creation;
	}
	public void setCreation(Date creation) {
		this.creation = creation;
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
}