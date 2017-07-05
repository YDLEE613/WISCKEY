package kr.madison.career.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.madison.career.service.CareerService;
import kr.madison.career.vo.CareerVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/Career/*")
public class CareerController {

	@Autowired
	CareerService careerService;
	
	public void setCareerService(CareerService careerService){
		this.careerService = careerService;
	}
	
	//취업공고
	@RequestMapping("/employer")
	public ModelAndView employer(@ModelAttribute("paramVO") CareerVO paramVO){
		ModelAndView mav = new ModelAndView();
		List<CareerVO> vo = careerService.findCareerList(paramVO);
		mav.addObject("careerList", vo);
		mav.setViewName("/career/employer");
		
		return mav;
	}
	
	//취업공고 글쓰기
	@RequestMapping("/writeEmployer")
	public ModelAndView writeEmployer(@ModelAttribute("paramVO") CareerVO paramVO, HttpServletRequest res){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/career/writeEmployer");
		
		return mav;
	}
	//취업공고 보기
	@RequestMapping("/viewEmployer")
	public ModelAndView viewEmployer(@ModelAttribute("paramVO") CareerVO paramVO, HttpServletRequest res){
		ModelAndView mav = new ModelAndView();
		CareerVO vo = careerService.findEmployerContent(paramVO);
		
		if(vo!=null){
			careerService.modEmployerCount(paramVO);
		}
		mav.setViewName("/career/viewEmployer");
		mav.addObject("vo",vo);
		
		return mav;
	}

	@RequestMapping
	@ResponseBody
	public int addEmployerData(CareerVO paramVO){
		int result = careerService.addEmployerData(paramVO);
		
		return result;
	}
	
	
	/*
	 * 
	 * 여기서부턴 취업게시판!!!!!!!
	 */

	//취업게시판
	@RequestMapping("/employBoard")
	public ModelAndView employBoard(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/career/employBoard");
		
		return mav;
	}
}
