package com.human.app;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MyController {
//	@RequestMapping (value="/contactus")
//	public String method1(Model model) {//모델 클래스를 이용
//		model.addAttribute("mobile","010-1234-5678");
//		return "contactus";
//	}
	@RequestMapping (value="/contactus") //변형1, 모델을 통해 보내는 방법이 아닌 변형
	public ModelAndView method2() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("mobile","011-123-456");
		mav.setViewName("contactus");
		return mav;
	}
}
