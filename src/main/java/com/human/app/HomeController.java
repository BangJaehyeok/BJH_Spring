package com.human.app;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
		
	@RequestMapping("/viewinfo")
	public String doInfo(HttpServletRequest hsr, Model model) {
		String uid=hsr.getParameter("userid");
		String pw=hsr.getParameter("passcode");		
		model.addAttribute("userid",uid);
		model.addAttribute("passcode",pw);		
		return "viewinfo";
	}
	
	@RequestMapping("/newinfo")
	public String doJoin(HttpServletRequest hsr, Model model) {
		String uid=hsr.getParameter("userid");
		String pw=hsr.getParameter("passcode");	
		String name=hsr.getParameter("realname");
		String mobile=hsr.getParameter("mobile");		
		model.addAttribute("userid",uid);
		model.addAttribute("passcode",pw);
		model.addAttribute("realname",name);
		model.addAttribute("mobile",mobile);
		return "newinfo";
	}
	
	@RequestMapping("/getinfo")
	public String getinfo() {
		return "getinfo";
	}
	
	@RequestMapping("/home")
	public String doChoose() {
		return "home";
	}
	@RequestMapping("/selected")
	public String doJob(@RequestParam("path") String strPath) {		
		if(strPath.equals("login")) {
			return "login";
		}else if(strPath.equals("newbie")) {
			return "newbie";
		} else {
			return "choose";
		}		
	}
	
}
