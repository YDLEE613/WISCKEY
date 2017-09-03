package kr.madison.school.vo;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import kr.madison.common.vo.CommonVO;

@JsonSerialize(include=JsonSerialize.Inclusion.ALWAYS)
public class SchoolVO extends CommonVO{
	public int brdid;
	public int swid;
	public String title;
	public String content;
	public String regdate;
	public String moddate;
	public String writer;
	public int count;
	public int likes;
	public int repcount;
	
	public int repid;
	public String repContent;
	public String repRegdate;
	public String replier;
	public int repLikes;
	public int repDislikes;
	public int replierno;
	
	public Integer lid = 0;
	public Integer replid = 0;
	
	public int prepid = 0;
	public int comCount;
	
	
	
	
	public int getReplierno() {
		return replierno;
	}
	public void setReplierno(int replierno) {
		this.replierno = replierno;
	}
	public int getPrepid() {
		return prepid;
	}
	public void setPrepid(int prepid) {
		this.prepid = prepid;
	}
	public int getComCount() {
		return comCount;
	}
	public void setComCount(int comCount) {
		this.comCount = comCount;
	}
	public Integer getLid() {
		return lid;
	}
	public void setLid(Integer lid) {
		this.lid = lid;
	}
	public Integer getReplid() {
		return replid;
	}
	public void setReplid(Integer replid) {
		this.replid = replid;
	}
	public int getRepLikes() {
		return repLikes;
	}
	public void setRepLikes(int repLikes) {
		this.repLikes = repLikes;
	}
	public int getRepDislikes() {
		return repDislikes;
	}
	public void setRepDislikes(int repDislikes) {
		this.repDislikes = repDislikes;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getBrdid() {
		return brdid;
	}
	public void setBrdid(int brdid) {
		this.brdid = brdid;
	}
	public int getSwid() {
		return swid;
	}
	public void setSwid(int swid) {
		this.swid = swid;
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
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getModdate() {
		return moddate;
	}
	public void setModdate(String moddate) {
		this.moddate = moddate;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getRepcount() {
		return repcount;
	}
	public void setRepcount(int repcount) {
		this.repcount = repcount;
	}
	public int getRepid() {
		return repid;
	}
	public void setRepid(int repid) {
		this.repid = repid;
	}
	public String getRepContent() {
		return repContent;
	}
	public void setRepContent(String repContent) {
		this.repContent = repContent;
	}
	public String getRepRegdate() {
		return repRegdate;
	}
	public void setRepRegdate(String repRegdate) {
		this.repRegdate = repRegdate;
	}
	public String getReplier() {
		return replier;
	}
	public void setReplier(String replier) {
		this.replier = replier;
	}
	
	
	
}
