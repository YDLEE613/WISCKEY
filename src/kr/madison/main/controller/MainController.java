package kr.madison.main.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.madison.about.vo.AboutVO;
import kr.madison.board.vo.BoardVO;
import kr.madison.career.vo.CareerVO;
import kr.madison.common.controller.CommonController;
import kr.madison.main.service.MainService;
import kr.madison.main.vo.MainVO;
import kr.madison.member.vo.MemberVO;
import kr.madison.school.vo.SchoolVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
public class MainController extends CommonController{
	
	@Autowired
	MainService mainService;

	@RequestMapping("/")
	public ModelAndView Index() throws Exception{
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		mav.setViewName("/main/index");
		
		return mav;
	}
	
	@RequestMapping("/NeedLogin")
	public ModelAndView needLogin(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/common/needLogin");
		
		return mav;
	}
	
	@RequestMapping("/findTopBoardList")
	@ResponseBody
	public List<BoardVO> findTopBoardList(MainVO paramVO){
		List<BoardVO> result = new ArrayList<BoardVO>();
		
		result = mainService.findTopBoardList(paramVO);
		return result;
	}
	
	@RequestMapping("/findRecentNoticeList")
	@ResponseBody
	public List<AboutVO> findRecentNoticeList(MainVO paramVO){
		List<AboutVO> result = new ArrayList<AboutVO>();
		
		result = mainService.findRecentNoticeList(paramVO);
		return result;
	}
	
	@RequestMapping("/findEmployerList")
	@ResponseBody
	public List<CareerVO> findEmployerList(MainVO paramVO){
		List<CareerVO> result = new ArrayList<CareerVO>();
		
		result = mainService.findEmployerList(paramVO);
		return result;
	}
	
	@RequestMapping("/findEducationList")
	@ResponseBody
	public List<SchoolVO> findEducationList(MainVO paramVO){
		List<SchoolVO> result = new ArrayList<SchoolVO>();
		
		result = mainService.findEducationList(paramVO);
		return result;
	}
}
