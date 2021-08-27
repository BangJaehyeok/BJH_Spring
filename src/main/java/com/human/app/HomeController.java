package com.human.app;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private HttpSession session;
	
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
	@RequestMapping(value="/check_user",method=RequestMethod.POST)
	public String check_user(HttpServletRequest hsr) {
		String userid=hsr.getParameter("userid");
		String passcode=hsr.getParameter("passcode");
		session=hsr.getSession();
		session.setAttribute("loginid", userid);
		session.setAttribute("passcode", passcode);
		return "redirect:/booking";	//RequestMapping의 경로 이름	
	}
	
	@RequestMapping(value="/booking",method=RequestMethod.GET)
	public String booking(HttpServletRequest hsr) {
		session=hsr.getSession();
		String loginid=(String)session.getAttribute("loginid");
		String passcode=(String)session.getAttribute("passcode");		
		if(loginid.equals("admin")&&(passcode.equals("1234"))){		
			return "booking";//JSP 파일 이름
		} else {
			return "redirect:/home";
		}				
	}
	@RequestMapping("/room")//다른웹사이트가면 세션이 초기화됨. 그 초기화되어서 null값이 될경우를 써준다.
	public String room(HttpServletRequest hsr) {
		session=hsr.getSession();
		if(session.getAttribute("loginid")==null) {
			return "redirect:/login";
		}
		return "room";
	}
	@RequestMapping("/logout")
	public String logout(HttpServletRequest hsr) {
		HttpSession session=hsr.getSession();
		session.invalidate();//세션 모두 삭제
		return "redirect:/home";
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
