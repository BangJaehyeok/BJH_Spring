package com.human.app;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private HttpSession session;
	
	@Autowired
	private SqlSession sqlSession;
		
	@RequestMapping("/newinfo")
	public String doJoin(HttpServletRequest hsr, Model model) {
		String uid=hsr.getParameter("userid");
		String pw=hsr.getParameter("passcode");	
		String name=hsr.getParameter("realname");
		String mobile=hsr.getParameter("mobile");
		String address=hsr.getParameter("address");
		model.addAttribute("userid",uid);
		model.addAttribute("passcode",pw);
		model.addAttribute("realname",name);
		model.addAttribute("mobile",mobile);
		model.addAttribute("address",address);
		return "newinfo";
	}
	
	@RequestMapping(value="/check_user",method=RequestMethod.POST)
	public String check_user(HttpServletRequest hsr) {
		String userid=hsr.getParameter("userid");
		String passcode=hsr.getParameter("passcode");
		//DB에서 유저 확인 : 기존 유저면 booking으로, 없으면 home으로
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
		if(loginid.equals("admin")&&(passcode.equals("123"))){		
			return "booking";//JSP 파일 이름
		} else {
			return "redirect:/home";
		}				
	}
	@RequestMapping("/room")//다른웹사이트가면 세션이 초기화됨. 그 초기화되어서 null값이 될경우를 써준다.
	public String room(HttpServletRequest hsr, Model model) {
		session=hsr.getSession();
		if(session.getAttribute("loginid")==null) {
			return "redirect:/home";
		}		
		iRoom room = sqlSession.getMapper(iRoom.class);
		//iRoom.class에 있는 매퍼값을 즉, sql문을 가져와 room이란 변수에 넣는다
//		ArrayList<Roominfo> roominfo = room.getRoomList();
////		//iRoom인터페이스에 있는 getRoomList()라는 ArrayList배열을 호출한다.
////		//그리고 roominfo라는 변수에 넣는다. 
//		model.addAttribute("list",roominfo);
		//model 어트리뷰트를 통해 list란 이름으로 roominfo 배열변수를 room으로 보낸다.
		
		ArrayList<Roomtype> roomtype = room.getRoomType();
		System.out.println(roomtype);
		model.addAttribute("type",roomtype);
		return "room";//room으로 보낸다.
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
	@RequestMapping(value="/getRoomList",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getRoomList(HttpServletRequest hsr) {
		iRoom room = sqlSession.getMapper(iRoom.class);
		ArrayList<Roominfo> roominfo = room.getRoomList();
		//찾아진 데이터로 JSONArray만들기
		JSONArray ja = new JSONArray();
		for(int i=0;i<roominfo.size();i++) {
			JSONObject jo = new JSONObject();
			jo.put("roomcode", roominfo.get(i).getRoomcode());
			jo.put("roomname", roominfo.get(i).getRoomname());
			jo.put("typename", roominfo.get(i).getTypename());
			jo.put("howmany", roominfo.get(i).getHowmany());
			jo.put("howmuch", roominfo.get(i).getHowmuch());
			ja.add(jo);
		}
		return ja.toString();
	}
	
	@RequestMapping(value="/deleteRoom",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String deleteRoom(HttpServletRequest hsr) {
		int roomcode = Integer.parseInt(hsr.getParameter("roomcode"));
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doDeleteRoom(roomcode);
		return "ok"; //그냥 ok라는 텍스트를 보냄. json데이터를 보내지않음.
	}
	
	@RequestMapping(value="/addRoom",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String addRoom(HttpServletRequest hsr) {
		String rname = hsr.getParameter("roomname");
		int rtype= Integer.parseInt(hsr.getParameter("roomtype"));
		int howmany = Integer.parseInt(hsr.getParameter("howmany"));
		int howmuch = Integer.parseInt(hsr.getParameter("howmuch"));
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doAddRoom(rname, rtype, howmany, howmuch);
		return "ok";
	}
	
	@RequestMapping(value="/updateRoom",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String updateRoom(HttpServletRequest hsr) {
		iRoom room = sqlSession.getMapper(iRoom.class);
		int rcode = Integer.parseInt(hsr.getParameter("roomcode"));
		String rname = hsr.getParameter("roomname");
		int rtype= Integer.parseInt(hsr.getParameter("roomtype"));
		int howmany = Integer.parseInt(hsr.getParameter("howmany"));
		int howmuch = Integer.parseInt(hsr.getParameter("howmuch"));		
		room.doUpdateRoom(rcode, rname, rtype, howmany, howmuch);
		return "ok";
	}
	
}
