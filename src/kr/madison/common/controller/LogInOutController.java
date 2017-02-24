package kr.madison.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.madison.common.service.LogInOutService;
import kr.madison.common.vo.LogInOutVO;

@RequestMapping("/LogInOut/*")
@Controller
public class LogInOutController extends CommonController{
	@Autowired
	private LogInOutService logInOutService;
	
	@RequestMapping
	@ResponseBody
	public String Login(HttpServletRequest request, LogInOutVO paramVO){
		String loginResult = null;
		
		try{
			paramVO.setIp(request.getRemoteAddr());
			paramVO.setUseragent(request.getHeader("User-Agent"));
			
			LogInOutVO logVO = logInOutService.Login(paramVO);
			
			if(logVO != null){
				loginResult = logVO.getStatus();
				if(loginResult != null && loginResult.equals("Success")){
					//BeanUtils.copyProperties(logVO, session);
				}
			}else{
				loginResult = "NotFound";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		loginResult = null;
		return loginResult;
	}
}
