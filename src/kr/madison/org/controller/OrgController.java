package kr.madison.org.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import kr.madison.common.controller.CommonController;
import kr.madison.common.vo.GridVO;
import kr.madison.org.service.OrgService;
import kr.madison.org.vo.OrgVO;
import kr.madison.util.Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/Org/*")
public class OrgController extends CommonController{
	
	final private int pageRow = 15;

	@Autowired
	OrgService orgService;
	
	@RequestMapping("/")
	public ModelAndView index(OrgVO paramVO){
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("org/introOrg");
		
		return mav;
	}
	
	@RequestMapping("/orgBoard")
	public ModelAndView orgBoard(@ModelAttribute("paramVO")OrgVO paramVO){	
		ModelAndView mav = new ModelAndView();
		
		int totalCnt = orgService.findOrgBoardTotalCnt(paramVO);
		Util.setPaging(paramVO, totalCnt, pageRow);
		
		List<OrgVO> result = orgService.findOrgBoardList(paramVO);
		
		
		mav.addObject("oblist", result);
		mav.setViewName("org/orgBoard");
		
		return mav;
	}
	
	@RequestMapping("/BoardView")
	public ModelAndView boardView(@ModelAttribute("paramVO") OrgVO paramVO, HttpServletResponse res){
		ModelAndView mav = new ModelAndView();
		OrgVO vo = orgService.getOrgBoardData(paramVO);
		paramVO.setOrgtypeid(vo.getOrgtypeid());
		List<OrgVO> replies = orgService.findBoardReply(paramVO);
		int repcount = orgService.getReplyCount(paramVO);
		
		if(vo != null){
			orgService.modBoardCount(paramVO);
		}
		
		mav.setViewName("org/orgBoardView");
		mav.addObject("vo", vo);
		mav.addObject("repCnt", repcount);
		mav.addObject("reps", replies);
		return mav;
	}
	
	@RequestMapping("/BoardEdit")
	public ModelAndView boardEdit(@ModelAttribute("paramVO") OrgVO paramVO, HttpServletResponse res){
		ModelAndView mav = new ModelAndView();
		List<OrgVO> orglist = orgService.findOrgListData(paramVO);
		
		mav.setViewName("org/orgBoardEdit");
		mav.addObject("orglist", orglist);
		
		return mav;
	}
	
	@RequestMapping
	@ResponseBody
	public List<OrgVO> findOrgListData(OrgVO paramVO){
		List<OrgVO> result = orgService.findOrgListData(paramVO);
		
		return result;
	}
	
	@RequestMapping("/loadOrgImage/{orgid}")
	@ResponseBody
	public byte[] loadOrgImage(@PathVariable("orgid") Integer orgid, OrgVO paramVO){
		byte[] result = null;
		paramVO.setOrgid(orgid);
		try{
			result = orgService.loadOrgImage(paramVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping("/findOrgList")
	@ResponseBody
	public GridVO findOrgList(OrgVO paramVO){
		GridVO grid = new GridVO();
		
		List<OrgVO> result = orgService.findOrgList(paramVO);
		
		grid.bindPaging(orgService.getOrgCount(paramVO), paramVO);
		grid.bindData(result);
		
		return grid;
	}
	
	@RequestMapping
	@ResponseBody
	public OrgVO getOrgData(OrgVO paramVO){
		return orgService.getOrgData(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public int addOrgData(OrgVO paramVO){
		return orgService.addOrgData(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public int addOrgBoardData(OrgVO paramVO){
		paramVO.setUserno(session.getUserno());
		return orgService.addOrgBoardData(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public int editOrgData(OrgVO paramVO){
		return orgService.editOrgData(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public int addBoardReply(OrgVO paramVO){
		paramVO.setUserno(session.getUserno());
		int result = orgService.addBoardReply(paramVO);
		
		return result;
	}
	
	@RequestMapping
	@ResponseBody
	public int modBoardLikes(OrgVO paramVO){
		int result = orgService.modBoardLikes(paramVO);
		
		return result;
	}
	
	@RequestMapping
	@ResponseBody
	public int modRepLikes(OrgVO paramVO){
		int result = orgService.modRepLikes(paramVO);
		
		return result;
	}
	
	@RequestMapping
	@ResponseBody
	public int modRepDislikes(OrgVO paramVO){
		int result = orgService.modRepDislikes(paramVO);
		
		return result;
	}
	
	@RequestMapping
	@ResponseBody
	public int getReplyCount(OrgVO paramVO){
		int result = orgService.getReplyCount(paramVO);
		
		return result;
	}
	
	@RequestMapping
	@ResponseBody
	public List<OrgVO> findBoardReply(OrgVO paramVO){
		List<OrgVO> result = orgService.findBoardReply(paramVO);
		
		return result;
	}
	
	@RequestMapping
	@ResponseBody
	public int modBoardData(OrgVO paramVO){
		orgService.modBoardData(paramVO);
		return paramVO.getBrdid();
	}
	
	@RequestMapping
	@ResponseBody
	public void delBoardData(OrgVO paramVO){
		orgService.delBoardData(paramVO);
		orgService.delBoardReplyData(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public int delBoardReplyData(OrgVO paramVO){
		return orgService.delBoardReplyData(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public List<OrgVO> findMyOrgList(OrgVO paramVO){
		return orgService.findMyOrgList(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public OrgVO getMyOrgData(OrgVO paramVO){
		return orgService.getMyOrgData(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public OrgVO getMyOrgDetails(OrgVO paramVO){
		return orgService.getMyOrgDetails(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public int modMyOrgData(OrgVO paramVO){
		return orgService.modMyOrgData(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public int modMyOrgDetail(OrgVO paramVO){
		return orgService.modMyOrgDetail(paramVO);
	}
	
	@RequestMapping
	@ResponseBody
	public int addMyOrgDetail(OrgVO paramVO){
		orgService.addMyOrgDetail(paramVO);
		return paramVO.getDetid();
	}
}