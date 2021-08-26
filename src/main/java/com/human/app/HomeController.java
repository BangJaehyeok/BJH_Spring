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
		
	@RequestMapping("/info")
	public String doInfo(ParamList pl, Model model) {		
		System.out.println("uid="+pl.userid);
		System.out.println("addr="+pl.address);
		model.addAttribute("loginid",pl.userid);
		model.addAttribute("region",pl.address);
		//userid->uid->loginid, address->addr->region
		return "viewinfo";		
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
			return "getinfo";
		}else if(strPath.equals("newbie")) {
			return "newbie";
		} else {
			return "choose";
		}		
	}
	@RequestMapping("/today/{address}/{userid}")
	public String showNumber(@PathVariable String address,
							@PathVariable String userid, Model model) {
		model.addAttribute("addr",address);
		model.addAttribute("uid",userid);
		return "today";
	}
}
