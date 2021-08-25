package com.human.app;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
		
	@RequestMapping("/info")
	public String doInfo(HttpServletRequest hsr, Model model) {
		String uid=hsr.getParameter("userid");
		String addr=hsr.getParameter("address");
		System.out.println("uid="+uid);
		System.out.println("addr="+addr);
		model.addAttribute("loginid",uid);
		model.addAttribute("region",addr);
		//userid->uid->loginid, address->addr->region
		return "viewinfo";		
	}
	
	@RequestMapping("/getinfo")
	public String getinfo() {
		return "getinfo";
	}
	
	@RequestMapping("/choose")
	public String doChoose() {
		return "choose";
	}
	@RequestMapping("/selected")
	public String doJob(HttpServletRequest hsr, Model model) {
		String strPath=hsr.getParameter("path");
		if(strPath.equals("login")) {
			return "getinfo";
		}else if(strPath.equals("newbie")) {
			return "newbie";
		} else {
			return "choose";
		}		
	}
}
