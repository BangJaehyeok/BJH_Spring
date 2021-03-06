package com.human.app;

import java.sql.Date;
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
import org.springframework.stereotype.Repository;
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
		
	@RequestMapping(value="/join",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	public String doJoin(HttpServletRequest hsr, Model model) {
		String realname=hsr.getParameter("realname");
		String loginid=hsr.getParameter("loginid");
		String passcode=hsr.getParameter("passcode1");
		iMember member=sqlSession.getMapper(iMember.class);
		member.doJoin(realname, loginid, passcode);
		return "home";
	}
	
	@RequestMapping(value="/check_user",method=RequestMethod.POST)
	public String check_user(HttpServletRequest hsr) {
		String userid=hsr.getParameter("userid");
		String passcode=hsr.getParameter("passcode");
		//DB에서 유저 확인 : 기존 유저면 booking으로, 없으면 home으로
		iMember member=sqlSession.getMapper(iMember.class);
		int n=member.doCheckUser(userid,passcode);
		if(n>0) {
			session=hsr.getSession();
		session.setAttribute("loginid", userid);
		return "redirect:/booking";	//RequestMapping의 경로 이름	
		} else {
			return "home";
		}
	}
	
	@RequestMapping(value="/booking",method=RequestMethod.GET)
	public String booking(HttpServletRequest hsr,Model model) {
		session=hsr.getSession();
		String loginid=(String)session.getAttribute("loginid");	
		if(loginid==null){		
			return "redirect:/home";//JSP 파일 이름
		} else {
			iRoom room = sqlSession.getMapper(iRoom.class);
			ArrayList<Roomtype> roomtype = room.getRoomType();
			model.addAttribute("type",roomtype);
			return "booking";
		}
	}
	
	@RequestMapping(value="/getBookRoomList",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getBookRoomList(HttpServletRequest hsr) {
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
	
	@RequestMapping(value="/getBookList",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getBookList(HttpServletRequest hsr) {
		String day1 = hsr.getParameter("day1");
		String day2 = hsr.getParameter("day2");
		String roomtype = hsr.getParameter("roomtype");
		String whichRoom="";
		if(!roomtype.equals("all")) {
			whichRoom=roomtype;
		}
		iBook book = sqlSession.getMapper(iBook.class);
		ArrayList<Booklist> booklist = book.getBookList(day1,day2,whichRoom);
		//찾아진 데이터로 JSONArray만들기		
		JSONArray ja = new JSONArray();
		for(int i=0;i<booklist.size();i++) {
			JSONObject jo = new JSONObject();
			jo.put("roomcode", booklist.get(i).getRoomcode());			
			jo.put("roomname", booklist.get(i).getRoomname());
			jo.put("typename", booklist.get(i).getTypename());
			jo.put("howmany", booklist.get(i).getHowmany());
			jo.put("howmuch", booklist.get(i).getHowmuch());
			jo.put("bookingdate1", booklist.get(i).getBookdate1());
			jo.put("bookingdate2", booklist.get(i).getBookdate2());			
			ja.add(jo);
		}
		return ja.toString();
	}
	
	@RequestMapping(value="/getBookListAll",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getBookListAll(HttpServletRequest hsr) {
		String day1 = hsr.getParameter("day1");
		String day2 = hsr.getParameter("day2");
		iBook book = sqlSession.getMapper(iBook.class);
		ArrayList<Booklistall> booklist = book.getBookListAll(day1,day2);
		//찾아진 데이터로 JSONArray만들기		
		JSONArray ja = new JSONArray();
		for(int i=0;i<booklist.size();i++) {
			JSONObject jo = new JSONObject();
			jo.put("roomcode", booklist.get(i).getRoomcode());			
			jo.put("roomname", booklist.get(i).getRoomname());
			jo.put("typename", booklist.get(i).getTypename());
			jo.put("howmany", booklist.get(i).getHowmany());
			jo.put("howmuch", booklist.get(i).getHowmuch());
			jo.put("bookingdate1", booklist.get(i).getBookdate1());
			jo.put("bookingdate2", booklist.get(i).getBookdate2());			
			ja.add(jo);
		}
		return ja.toString();
	}
	
	@RequestMapping(value="/getBooked",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getBooked(HttpServletRequest hsr) {
		String day1 = hsr.getParameter("day1");
		String day2 = hsr.getParameter("day2");		
		iBook book = sqlSession.getMapper(iBook.class);
		ArrayList<Booked> booked = book.getBooked(day1,day2);
		//찾아진 데이터로 JSONArray만들기
		JSONArray ja = new JSONArray();
		for(int i=0;i<booked.size();i++) {			
			JSONObject jo = new JSONObject();
			jo.put("bookcode", booked.get(i).getBookcode());
			jo.put("roomcode", booked.get(i).getRoomcode());
			jo.put("typename", booked.get(i).getTypename());
			jo.put("roomname", booked.get(i).getRoomname());
			jo.put("roomprice", booked.get(i).getRoompriceall());
			jo.put("bookingpeople", booked.get(i).getBookingpeople());			
			jo.put("roompeople", booked.get(i).getHowmany());
			jo.put("bookdate1", booked.get(i).getBookingdate1());
			jo.put("bookdate2", booked.get(i).getBookingdate2());
			jo.put("bookingname", booked.get(i).getBookingname());			
			jo.put("mobile", booked.get(i).getMobile());
			ja.add(jo);
		}		
		return ja.toString();
	}
	
	@RequestMapping(value="/addBookRoom",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String addBookRoom(HttpServletRequest hsr) {		
		int rcode = Integer.parseInt(hsr.getParameter("roomcode"));
		int rpriceall = Integer.parseInt(hsr.getParameter("roompriceall"));
		int bpeople = Integer.parseInt(hsr.getParameter("bookpeople"));		
		String bookdate1 = hsr.getParameter("bookdate1");
		String bookdate2 = hsr.getParameter("bookdate2");
		String bname = hsr.getParameter("bookName");
		String mobile = hsr.getParameter("mobile");		
		iBook book = sqlSession.getMapper(iBook.class);
		book.doAddBook(rcode,rpriceall, bpeople, bname, bookdate1, bookdate2, mobile);
		return "ok";
	}
	
	@RequestMapping(value="/deleteBookRoom",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String dodeleteBook(HttpServletRequest hsr) {
		int roocode = Integer.parseInt(hsr.getParameter("roomcode"));
		iBook book = sqlSession.getMapper(iBook.class);
		book.doDeleteBook(roocode);
		return "ok"; //그냥 ok라는 텍스트를 보냄. json데이터를 보내지않음.
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
	
	@RequestMapping(value="/updateBook",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String updateBook(HttpServletRequest hsr) {
		iBook book = sqlSession.getMapper(iBook.class);
		int rcode = Integer.parseInt(hsr.getParameter("roomcode"));
		int bpeople = Integer.parseInt(hsr.getParameter("bookingpeople"));
		String bname = hsr.getParameter("bookingname");
		String mobile = hsr.getParameter("mobile");
		book.doUpdateBook(rcode, bpeople, bname, mobile);
		return "ok";
	}
}
