package kr.madison.board.vo;

import kr.madison.common.vo.CommonVO;

import org.codehaus.jackson.map.annotate.JsonSerialize;

@JsonSerialize(include=JsonSerialize.Inclusion.ALWAYS)
public class BoardVO extends CommonVO{
	
	public int brdid;
	public String title;
	public int count;
	public String content;
	public String writer;
	public int frid;
	public String regdate;
	public String moddate;
	public int likes;
	public int dislikes;
	public int repcount;
	
	public int chk_anonymous;
	public int chk_rep_anonymous;
	
	public int repid;
	public String repContent;
	public String replier;
	public String repRegdate;
	public int repLikes;
	public int repDislikes;
	public String responseType;
	public int replierno;
	
	//file upload
	public String type;
	public String CKEditorFuncNum; 
	
	//likes
	public Integer lid = 0;
	public Integer replid = 0;
	
	//comment
	public int prepid = 0;
	public int comCount;
	
	
	
	public int getChk_rep_anonymous() {
		return chk_rep_anonymous;
	}
	public void setChk_rep_anonymous(int chk_rep_anonymous) {
		this.chk_rep_anonymous = chk_rep_anonymous;
	}
	public int getBrdid() {
		return brdid;
	}
	public void setBrdid(int brdid) {
		this.brdid = brdid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getFrid() {
		return frid;
	}
	public void setFrid(int frid) {
		this.frid = frid;
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
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getDislikes() {
		return dislikes;
	}
	public void setDislikes(int dislikes) {
		this.dislikes = dislikes;
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
	public String getReplier() {
		return replier;
	}
	public void setReplier(String replier) {
		this.replier = replier;
	}
	public String getRepRegdate() {
		return repRegdate;
	}
	public void setRepRegdate(String repRegdate) {
		this.repRegdate = repRegdate;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getResponseType() {
		return responseType;
	}
	public void setResponseType(String responseType) {
		this.responseType = responseType;
	}
	public String getCKEditorFuncNum() {
		return CKEditorFuncNum;
	}
	public void setCKEditorFuncNum(String cKEditorFuncNum) {
		CKEditorFuncNum = cKEditorFuncNum;
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
	public int getChk_anonymous() {
		return chk_anonymous;
	}
	public void setChk_anonymous(int chk_anonymous) {
		this.chk_anonymous = chk_anonymous;
	}
	
}
