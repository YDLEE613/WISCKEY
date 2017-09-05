package kr.madison.org.service;

import java.io.File;
import java.util.List;

import kr.madison.admin.vo.AdminVO;
import kr.madison.common.service.CommonService;
import kr.madison.org.dao.OrgDAO;
import kr.madison.org.vo.OrgVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrgService extends CommonService{

	@Autowired
	OrgDAO orgDAO;
	
	public List<OrgVO> findOrgListData(OrgVO paramVO){
		return orgDAO.findOrgListData(paramVO);
	}
	
	public byte[] loadOrgImage(OrgVO paramVO){
		OrgVO vo = orgDAO.loadOrgImage(paramVO);
		try{
			return vo.getFileContent();
		}catch(NullPointerException e){
			return null;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	public List<OrgVO> findOrgList(OrgVO paramVO){
		return orgDAO.findOrgList(paramVO);
	}

	public int getOrgCount(OrgVO paramVO) {
		return orgDAO.getOrgCount(paramVO);
	}
	
	public OrgVO getOrgData(OrgVO paramVO){
		return orgDAO.getOrgData(paramVO);
	}
	
	public int addOrgData(OrgVO paramVO){
		orgDAO.addOrgData(paramVO);
		return paramVO.getOrgid();
	}
	
	public int editOrgData(OrgVO paramVO){
		return orgDAO.editOrgData(paramVO);
	}
	
	public List<OrgVO> findOrgBoardList(OrgVO paramVO){
		return orgDAO.findOrgBoardList(paramVO);
	}
	
	public int findOrgBoardTotalCnt(OrgVO paramVO){
		return orgDAO.findOrgBoardTotalCnt(paramVO);
	}
	
	public OrgVO getOrgBoardData(OrgVO paramVO){
		return orgDAO.getOrgBoardData(paramVO);
	}

	public void modBoardCount(OrgVO paramVO) {
		orgDAO.modBoardCount(paramVO);
	}
	
	public int addBoardReply(OrgVO paramVO){
		int result = orgDAO.addBoardReply(paramVO);
		
		return result;
	}
	public int modBoardLikes(OrgVO paramVO){
		OrgVO test = orgDAO.checkLikes(paramVO);
		int result = 0;
		if(test == null || test.getLid() == null){
			paramVO.setLikes(1);
			result = orgDAO.addOrgBoardLikes(paramVO);
		}
		else if(test.getLid() != 0 && test.getLid() != null){
			if(test.getLikes() == 0){
				result = orgDAO.modBoardLikes(paramVO);
			}else{
				result = 0;
			}
		}
		
		return result;
	}
	
	public int modRepLikes(OrgVO paramVO){
		OrgVO test = orgDAO.checkRepLikes(paramVO);
		int result = 0;
		if(test == null || test.getReplid() == null){
			paramVO.setRepLikes(1);
			result = orgDAO.addBoardRepLikes(paramVO);
		}
		else if(test.getReplid() != 0 && test.getReplid() != null){
			if(test.getRepLikes() == 0){
				result = orgDAO.modRepLikes(paramVO);
			}else{
				result = 0;
			}
		}
		return result;
	}
	
	public int modRepDislikes(OrgVO paramVO){
		OrgVO test = orgDAO.checkRepLikes(paramVO);
		int result = 0;
		if(test == null || test.getReplid() == null){
			paramVO.setRepDislikes(1);
			result = orgDAO.addBoardRepLikes(paramVO);
		}
		else if(test.getReplid() != 0 && test.getReplid() != null){
			if(test.getRepDislikes() == 0){
				result = orgDAO.modRepDislikes(paramVO);
			}else{
				result = 0;
			}
		}
		return result;
	}
	
	public int getReplyCount(OrgVO paramVO){
		int result = orgDAO.getReplyCount(paramVO);
		
		return result;
	}
	
	public List<OrgVO> findBoardReply(OrgVO paramVO){
		List<OrgVO> result = orgDAO.findBoardReply(paramVO);
		
		return result;
	}
	
	public int modBoardData(OrgVO paramVO){
		orgDAO.modBoardData(paramVO);
		return paramVO.getBrdid();
	}
	
	public void delBoardData(OrgVO paramVO){
		orgDAO.delBoardData(paramVO);
		orgDAO.delBoardReplyData(paramVO);
	}
	
	public int delBoardReplyData(OrgVO paramVO){
		return orgDAO.delBoardReplyData(paramVO);
	}

	public int addOrgBoardData(OrgVO paramVO) {
		orgDAO.addOrgBoardData(paramVO);
		return paramVO.getBrdid();
	}
	
	public List<OrgVO> findMyOrgList(OrgVO paramVO){
		return orgDAO.findMyOrgList(paramVO);
	}
	
	public OrgVO getMyOrgData(OrgVO paramVO){
		return orgDAO.getMyOrgData(paramVO);
	}
	
	public OrgVO getMyOrgDetails(OrgVO paramVO){
		return orgDAO.getMyOrgDetails(paramVO);
	}
	
	public int modMyOrgData(OrgVO paramVO){
		/*if(paramVO.getPrno() != paramVO.getOldprno()){
			orgDAO.modOrgPrAuth(paramVO);
			if(paramVO.getAuthid() != null && paramVO.getAuthid() == 2){
				orgDAO.modOrgOldPrAuth(paramVO);
			}
		}*/
		return orgDAO.modMyOrgData(paramVO);
	}
	
	public int modMyOrgDetail(OrgVO paramVO){
		return orgDAO.modMyOrgDetail(paramVO);
	}
	
	public int addMyOrgDetail(OrgVO paramVO){
		return orgDAO.addMyOrgDetail(paramVO);
	}
	
	public OrgVO getImage(OrgVO paramVO){
		return orgDAO.getImage(paramVO);
	}
	public int modBoardReply(OrgVO paramVO){
		return orgDAO.modBoardReply(paramVO);
	}
	
	public void delBoardReply(OrgVO paramVO){
		orgDAO.delBoardReply(paramVO);
	}
	
	public OrgVO findBoardReplyData(OrgVO paramVO){
		return orgDAO.findBoardReplyData(paramVO);
	}
	
	public List<OrgVO> findCommentList(OrgVO paramVO){
		return orgDAO.findCommentList(paramVO);
	}
	
	public int getCommentCount(OrgVO paramVO){
		return orgDAO.getCommentCount(paramVO);
	}
	
	public int undoBoardLikes(OrgVO paramVO){
		return orgDAO.undoBoardLikes(paramVO);
	}
	public int undoBoardDislikes(OrgVO paramVO){
		return orgDAO.undoBoardDislikes(paramVO);
	}
	public int undoBoardRepLikes(OrgVO paramVO){
		return orgDAO.undoBoardRepLikes(paramVO);
	}
	public int undoBoardRepDislikes(OrgVO paramVO){
		return orgDAO.undoBoardRepDislikes(paramVO);
	}

	public int deleteOrg(OrgVO paramVO) {
		return orgDAO.deleteOrg(paramVO);
	}
}
