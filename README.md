#### 20210826 (목) 작업
- public String doInfo(HttpServletRequest hsr, Model model) {
		String uid=hsr.getParameter("userid");
		String addr=hsr.getParameter("address");
- 원래는 위처럼 쓰는 거지만
		
- public String doInfo(@RequestParam("userid") String uid, 
			@RequestParam("address") String addr, Model model) {	
- @RequestParam을 이용해 이렇게 쓸 수도 있다.
- 그러나 @RequestParam은 값이 강제로 지정되서 무조껀 쓰이게 된다. 그리고 코딩이 너무 길어진다. 그래서 보통은 위의 방법을 많이 쓴다. 필요할때 값을 가져와 쓸 수 있기 때문.

- 만약 Parameter를 통해 지정해줘야할 값들이 너무 많다면 코딩이 길어지고 지저분해진다. 그래서 클래스를 하나 만들어서 거기에 ParamList라고해서 파라미터 객체들을 만들어준다.
- 그래서 클래스에 해당하는 변수를 지정하고 그 변수를 이용해 간단하게 호출해준다.
- Command 객체라고한다.

- public String doInfo(ParamList pl, Model model) {		
		System.out.println("uid="+pl.userid);
		System.out.println("addr="+pl.address);
		model.addAttribute("loginid",pl.userid);
		model.addAttribute("region",pl.address);
- 많이 쓰이지는 않는다.

- GET/POST방식으로 전달된 데이터를 Spring Framework에서 받는 방법
1. HttpServletRequest
2. @RequestParam
3. Command object
4. @PathVariable <- RestAPI

- RestAPI 특징 : 전송되는 데이터가 감춰진다.(데이터 은닉) 
- ?,&, = 을 사용안하고 /으로 연결함.

- 데이터를 전송하고 받을 때 서로의 데이터 전송방식이 같아야한다.
- 즉, GET방식인지 POST방식인지 서로 일치해야 에러없이 받을 수 있다.

- redirect:요청경로명  요청경로명으로 돌아가라는 뜻.
	
- JSP(Java Server Page) <-SunMicroSystem-> Oracle/SQLServer/MySQL
- JSP가 오랜시간동안 사랑받았다.
- <% 자바프로그램코드, 변수/메소드 선언 %> : 이런 표시가 있다면 웹서버 안에서 먼저 실행된다.
- <%=변수/표현식/계산식 %>
- <%--코멘트--%>
- <%@ 지시자 %@>

1. Javascript.jQuery <script></script>
2. JSP <% %>

- 이제 로그인창에서 로그인을 하면 예약관리 창으로 들어간다.
- 그리고 예약관리에서 객실관리 창으로 들어갈 수 있다.
- 예약관리(booking.jsp), 객실관리(room.jsp)]
- 두개의 창 모두 우측상단에 로그아웃 버튼을 만들어 로그아웃할 수 있게한다.


#### 20210825 (수) 작업
- STS : Spring Tool Suite
- Spring 3까지는 일반 스프링
- Spring 4부터는 Spring Boot라고 한다.

- MVC란? 
- HTML에서 <body>는 눈에 보이는 곳 <view>라고 할 수 있고, <script>부분은 프로그래밍 부분이다. jQuery이전에는 body에서도 어느정도의 프로그래밍 코드가 있었지만, 지금은 jQuery를 통해 body에는 프로그래밍 코드가 전혀없다. id만 지정해주면 script에서 id를 가져오기만해서 프로그래밍을 한다. 즉, view하는 부분과 coding부분이 완전히 구분이 되어버린 것이다. 이처럼 스프링에서도

- MVC(Model View Controller) : View는 body태그 , Controller는 script영역, Model은 id역할. 화면에 보이는 영역과 컨트롤로직부분을 모델이 중개해주는 것.
- 웹앱 안쪽에 views - home.jsp - 기본클라이언트 웹페이지 소스(view에 해당)
- HomeController : 서버프로그램소스, script역할.

- @RequestMapping(value = "/", method = RequestMethod.GET)
->기본경로 뒤에 /로 끝나면 밑의 home을 호출한다.
	public String home(Locale locale, Model model) {
	-> 여기서 나오는 Model model은 말그대로 위의 Model로서 중개자역할이다.
		logger.info("Welcome home! The client locale is {}.", locale);	
	-> logger.info는 디버깅을 위한 문구이다. 이 문구가 console창에 뜨면 정상적으로 작동한다는것.	
		Date date = new Date();
	-> date라는 함수를 만들어줌.
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);		
	-> dateFormat이라는 함수를 정의해줌.
		String formattedDate = dateFormat.format(date);		
		model.addAttribute("serverTime", formattedDate );
	-> model.addAttribute는 addAttribute뒤의 속성들을 같이 전달해주라는 명령.
	-> model에 Attribute를 추가해서 View한테 전달된다. view는 전달된 Model의 속성들을 화면에 출력한다.	
		return "home";
	-> Model이 나타날 jsp의 주소 뷰페이지의 이름을 써넣는다..
	
- Home.jsp에서는 ${Model Attribute} 이런 형식을 통해 보낸 Model의 Attribute를 받는다.

- 실제 회사에서 작업할때는 HomeController를 작업하게된다. Controller가 서버,DB 즉 회사의 컴퓨터, 서버이다.
- View는 웹브라우저, 스마트폰 등등 회사 밖의 전세계 어디나 누구나이다.
- 컨트롤러에서 View로 보내는건 중간에 Model이 해준다.
- 그렇다면 View(사용자)에서 Controller로 보내는 것은? <form>태그(Post/Get) or queryStirng(Get), ajax(Post/Get) 3가지 방식들이 있다.

- 보통 에러는 홈컨트롤러나 홈.jsp파일에서 많이 난다. 무슨 에러가 났다면 대충 여길 보면된다.

- 컨트롤러 만들기 
1. 프로젝트 이름을 우클릭 -> New -> Class -> 클래스 이름주기 
2. mycontroller 열고, 클래스 이름 위에 @Controller 추가
3. 컨트롤러 임포트하기

- 컨트롤러의 RequestMapping에 대한 구조를 외우기.
- Method방식이 get방식이면 생략할 수 있다.
- @RequestMapping(value = "/home", method = RequestMethod.GET)
- @RequestMapping("/home")
- 아래의 방식처럼 생략을 할 수 있다.

- servlet-context에 어떻게 jsp파일을 찾아가는지를 지정해둔다.
- <beans:property name="prefix" value="/WEB-INF/views/" />
  <beans:property name="suffix" value=".jsp" />
- servlet-context에 위처럼 경로를 지정해놓는 것이다. 위 경로가 잘못되어있으면 컴퓨터가 지정경로의 파일을 찾지 못한다.
- 모델클래스를 이용해 컨트롤러의 데이터를 뷰에 보내는 방법이 정석이다.

- 모델을 이용해서 보내는 방법이 아닌 변형방법1(ModelAndView 방법-addObject,setViewName)
- @RequestMapping (value="/contactus") //생략된것을 보아 get방식이다.
	public ModelAndView method2() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("mobile","011-123-456");
		mav.setViewName("contactus");
		return mav;	}	

- 컨트롤러에서 쓴 경로명을 다른 곳에서도 RequestMapping해서 경로명을 지정하면 에러뜬다.
- RequestMapping을 통한 경로명은 컨트롤러가 여러개라할지라도 한군데서만 쓸 수 있고 처리할 수 있다.

- 서버에서 사용자에게 보낼땐 Model, ModelAndView를 쓴다.
- 반대로 사용자(클라이언트)에서 서버로 보낼땐 HttpServletRequest, RequestParam등의 방식을 사용해 보낸다.

- 경로명에 줄줄줄 데이터가 써지는 것 : QueryString(GET방식; 보안이 약함)
- ex) http://localhost:8080/board/confirmId?id=abcd&pw=1234
- 위처럼 url에 데이터가 표시됨

- POST방식은 protocol head에 데이터를 넣어서 url에는 표시가 안됨. 숨겨지는 효과

- 클라이언트에서 get방식으로 서버에 데이터를 보낸다면 위의 예처럼 데이터가 표시된 url째로 날아간다. 쿼리스트링 방식으로 날아간다.
- 그럼 서버에서는 HttpServletRequest를 통해 데이터를 받는다.
- http://localhost:8080/app/info?userid=방재혁&address=천안(쿼리스트링)
- get방식이기때문에 위처럼 url을 쓰면 웹페이지에 해당 값이 써진다.
- @RequestMapping("/info")
	public String doInfo(HttpServletRequest hsr, Model model) {
		String uid=hsr.getParameter("userid");
		String addr=hsr.getParameter("address");
		System.out.println("uid="+uid); -> 디버깅
		System.out.println("addr="+addr); -> 디버깅
		model.addAttribute("loginid",uid);
		model.addAttribute("region",addr);		
		return "viewinfo";
		
- 위의 방식처럼 RequestMapping이 홈컨트롤러에 써지고 HttpServletRequest로 받아 간다.
- userid->uid->loginid, address->addr->region

- Client가 getinfo를 입력함 => Server에서 
- @RequestMapping("/getinfo")
	public String getinfo() {
		return "getinfo";}
- 위처럼 아주 간단한 방식으로 서버에서 getinfo를 받고 getinfo.jsp로 연결한다.
- 참고로 form태그는 id태그가 아닌 name만 이용한다. 오직 name!!

- <form method="GET" action="/app/info">
	<input type=text name=userid><br>
	<input type=text name=address><br><br>
	<input type=submit value="전송">
</form>
- 다시 적지만 form태그는 name이 필수!!

- getinfo.jsp파일이 열리고 그 안에는 form태그가 있다. form태그에서 userid와 address를 입력하고 submit을 누르면
- 다시 그것이 서버로 가서 form action="/info"로 입력했기 때문에 
- 한참 위의 @RequestMapping("/info")
	public String doInfo(HttpServletRequest hsr, Model model) {
	등등이 서버에서 받는다. 그래서 아까처럼 작동이 되어서 
- 다시 클라이언트의 info.jsp가 발동되고 아까 getinfo.jsp에서 입력한 데이터값이
- info.jsp에 출력된다.

- 서버쪽(Controller)짤때와 view쪽(jsp파일)짤 때의 링크소환을 각각 다르게 신경써줘야한다. 

#### 20210824 (화) 작업
- 새로 스프링 레거시 프로젝트를 만든다.
- File - New - Others - Spring - Spring Legacy Project
- 이름 지정하고 밑에 Spring MVC Project 누르고
- com.human.app 누르고 프로젝트 생성
- 그리고 Homecontroller에서 run on server하고
- 404에러 뜨면 포트번호/app까지 지운다음에 실행해서 잘 나오면 굳

- Windows - properties - general - web browser에 크롬 선택
- use external web browser
- 계속 properties - web - JSP Files클릭 - Encoding부분을 ISO 어쩌구/유니코드(UTF-8)로 설정
- 위의 설정을 하면 한글이 거의 깨지지않고 run on server를 하면 크롬창으로 뜨게한다.
- 그리고 home.jsp에서 
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
이걸 추가해준다.

- java는 서버프로그램 Homecontroller.java => 기본 서버프로그램 소스
- resources
- webapp -> 클라이언트 프로그램
- 웹앱 안쪽에 views - home.jsp - 기본클라이언트 웹페이지 소스
- Webpage(HTML/CSS/Javascript) + Java Tag지원 => JSP(Java Server Page)

- 예를 들면 controller만드세요 하면 java폴더의 밑에밑에 쭈욱가서 java파일 형식으로 컨트롤러 파일을 생성한다. 
- 홈컨트롤러도 근본적으로 자바 클래스이다.
- 프로젝트의 환경설정 : 프로그램이 돌아가게하는 환경을 세팅
- web.xml
- pom.xml
- servlet-context.xml
- root-context.xml

