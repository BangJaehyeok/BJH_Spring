#### 프로젝트 주의사항
- 해당 프로젝트를 실행하기 전에 오류가 난다면 다음을 확인해보자.
- 프로젝트 자체에 뭔짓을해도 에러가 자꾸 난다면 바꾼 PC의 ojdbc.jar파일의 경로를 다시 설정해보자.
- 그리고 maven update해준 후 다시 실행해보자. 프로젝트 자체에 에러가 없어졌다면 성공.
- 그리고 DB연결에 오류가 생겼을 수도 있다. 해당 오류를 잡기 위해 DB연동된 아이디의 IP주소, SID를 확인해보자. 그리고 그것에 맞춰 servlet-context에서 수정하자.
- 그리고 해당 jsp파일에 써있는 localhost:8080에 대한 IP주소를 실행시키는 톰캣서버에 맞춰 변경하거나 유지한다.
- 위의 모든 상황에도 안된다면 그냥 git에서 다시 받는 것을 추천.

#### 20210906 (월) 작업
1. 예약가능객실에 모든 객실 리스트가 출력되는 것(ajax)
2. 객실선택하면 중간부분에 선택된 객실의 정보가 표시되는 것
3. 예약완료 클릭하면 booking테이블에 저장 & 오른쪽 예약된 객실 목록에 표시

- ALTER TABLE TABLE_NAME MODIFY COLUMN_NAME VARCHAR2(4000);
-> 해당 table의 컬럼 타입을 변경하는 명령



#### 20210903 (금) 작업
- 회사마다 코딩규격이 있다.
- 회원가입, 로그인부분 다시 짜보도록 하자.
- 회원가입보낼땐 form태그로 name으로만 보낸다. DB에 그걸 잘 확인해보자.
- 그리고 로그인하는 것도 dB확인해서 하는걸로 해보자.
- 이번엔 예약관리부분 만들기
- 조회하면 예약가능객실 나오기. select
- 그리고 가운데 div부분에 제이쿼리로 채우기.
- 저 그림에 알맞은 html만들기
- sql table 만들기
- 가장 오른쪽의 예약된 객실에 select해서 조회로 나오게하기.
- html이쁘게 꾸미기.


#### 20210902 (목) 작업
$(document)
.ready(function(){//ajax호출
	$.post("http://localhost:8080/app/getRoomList",{},function(result){
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+'">'+value['roomname']+','+value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
			$('#reserveRoom2').append(str);});
	},'json');})
- C태그 대신 제이쿼리에 이렇게 설정해주면 목록이 뜬다.
- 만약 C태그의 forEach문도 있고 제이쿼리도 ajax호출문이 있다면? 데이터가 두번뜬다.
- 제이쿼리를 통해 클라이언트가 서버에서 가져와 목록을 채운다.
- model Attribute를 통해 보낸건 C태그를 통해 호출한다.

- DB백업 만들기
- Sql디벨로퍼 들어가서 create table room1 as select * from room; 이렇게 room1을 만든다.
- create는 commit해줄 필요없다. insert, update, delete등만 commit이 필요.

- **delete하는 작업
$.post('http://localhost:8080/app/deleteRoom',{roomcode:$('#roomcode').val()}),
			function(result){
		console.log(result);
	},'text');
- 우선 jsp파일에 작업해준다. post형식으로 보내고, deleteRoom이라는 임의의 이름지어주고, text형식으로 받는다.

- {roomcode:$('#roomcode').val()} {}는 객체라는 뜻. #roomcode.val()의 roomcode가 서버로 post형식으로 날아감.

- iRoom.java에 밑의 한줄을 추가한다. 
void doDeleteRoom(int roomcode);
- void를 쓴 이유는 delete는 반환값이 필요없기 때문이고 roomcode는 DB에서 number형식이라 int라고 써준다. 

- 그리고 xml파일에 
- <delete id="doDeleteRoom">
		delete from room where roomcode=#{param1}
	</delete>
 이렇게 delete를 추가해준다. 만약 인터페이스에서 int roomcode말고 다른 것도 있었다면 
 #{param2}이렇게 추가해준다.

@RequestMapping(value="/deleteRoom",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String deleteRoom(HttpServletRequest hsr) {
		int roomcode = Integer.parseInt(hsr.getParameter("roomcode"));
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doDeleteRoom(roomcode);
		return "ok"; //그냥 ok라는 텍스트를 보냄. json데이터를 보내지않음.
- 홈컨트롤러에서 deleteRoom이라는 RequestMapping을 만들어 서버에서 클라이언트에 보내줄 준비를 해준다. 
- hsr.파라미터("roomcode")는 문자열로 받았기 때문에 parseInt로 정수형데이터로 바꿔준다. 그리고 int roomcode 변수에 저장한다.
- 그리고 매퍼로 받은 sql room변수에 room.doDeleteRoom(roomcode)해서 정수형데이터로 바꾼 roomcode를 클라이언트에게 보낸다.

- **insert를 해보자.
- roomcode는 부여되지 않은 상태(roomcode=="")
- 객실명, 타입, 최대숙박인원, 1박요금 -> 데이터 to 서버
- .on('click','#btnAdd',function(){
	let roomname=$('#roomName').val();
	let roomtype=$('#selType').val();
	let howmany=$('#txtNum').val();
	let howmuch=$('#roomPrice').val();
	//validation(유효성 검사)
	if(roomname==''||roomtype==''||howmany==''||howmuch==''){
		alert("누락된 값이 있습니다.");
		return false;
	}
	$.post('http://localhost:8080/app/addRoom',{roomname:roomname,roomtype:roomtype,howmany:howmany,howmuch:howmuch},
	  function(result){
		  if(result=='ok'){
			  location.reload();
		  } },'text')})
- 밑의 script에서 추가버튼을 누를시 생기는 action을 지정해준다.
- 우선 방이름,타입,인원수,방가격을 각각 변수지정해주고, 유효성검사는 빈값이 들어오면 패스하는것, post방식으로 받아들이는 것을 써주고, addRoom이라고 임의로 받을 주소를 만들어주고, delete에서 한것처럼 post로 날아갈 데이터의 객체를 지정해준다.
그리고 if에서 ok라는 것이 서버에서 오면 location.reload()를 하게 해준다.
- 홈컨트롤러에서 JSON데이터가 아닌 text값을 리턴해주기 때문에 text로 받는다고 명시한다.

iRoom.xml에 insert문을 추가해준다.
<insert id="doAddRoom">
	insert into room(roomcode,name,type,howmany,howmuch) 
	values(seq_room.nextval,#{param1},#{param2},#{param3},#{param4})
</insert>
- 이것도 delete할때처럼 반환값이 없고 id만 지정해준다. id는 당연히 인터페이스의 메소드이다.
- 그리고 values를 지정할 때, seq_room.nextval해주고, 나머지는 delete처럼 하면된다.

- void doAddRoom(String roomname,String roomtype,int howmany,int howmuch);
- 인터페이스에도 반환값이 없어서 void로 시작한다. 그리고 doAddRoom메소드에 sql문에 들어갈 변수들을 넣어준다.

@RequestMapping(value="/addRoom",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String addRoom(HttpServletRequest hsr) {
		String rname = hsr.getParameter("roomname");
		String rtype = hsr.getParameter("roomtype");
		int howmany = Integer.parseInt(hsr.getParameter("howmany"));
		int howmuch = Integer.parseInt(hsr.getParameter("howmuch"));
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doAddRoom(rname, rtype, howmany, howmuch);
		return "ok";
	}
- 마지막으로 홈컨트롤러에 서버의 데이터를 클라이언트에게 전해줄 RequestMapping을 만들어준다.
- value엔 addRoom으로 해서 jsp에서 임의로 정한 주소를 써준다. post방식으로 전달한다는 것도 명시해준다. 그리고 delete때처럼 변수들을 각각 지정해준다. DB의 desc를 통해 각각의 데이터 타입을 따라서 변수지정을 해준다.
- 그리고 매퍼sql문을 소환해주고, room변수에 넣어준다. 그리고 인터페이스메소드 지정한것처럼 room.doAddRoom으로 변수지정한 4개의 변수를 넣어준다. return값 넣어주면 ok.

- insert와 update의 결정적 차이는 primary key가 update는 꼭 필요하다.
- insert는 hidden처리된 roomcode가 필요하지않고, 입력시에는 비어있는 상태이다. 그래서 그것을 insert로 인식하는 것이다.
- 그러나 update(수정)할때는 해당 목록에서 객실을 선택한 후 수정하기 때문에 hidden처리된 roomcode는 남아있다. 그래서 roomcode를 지정한 채로 바꾼다면 그것이 수정이되는 것이다.
- hidden된 roomcode가 없다면, insert하는 상황, 만약 있다면 update하는 상황.


#### 20210901 (수) 작업
- jQuery로 room의 옵션 클릭하면 나타나게 하기
- $(document)
.on('click','#selRoom option',function(){ <-셀렉트의 옵션을 클릭하면 작동
	let str=$(this).text(); / console.log(str);로 잘 나오는지 확인
	let ar=str.split(','); <- 콤마(,)를 기준으로 자르는 배열을 만듬.
	}
- $('#roomName,#txtNum,#roomPrice,#selType,#roomcode').val('');
- 위처럼 한번에 묶어서 처리할 수 있다.

- Ajax처리하는 방법
- $(document).ready(function(){
	$.post("http://localhost:8080/app/getRoomList",{},function(result){
		console.log(result);
	},'json');
})
- ajax를 받을 준비를 jsp파일에서 설정해놓는다. script에서 위와같이 코딩을 한다.
- post는 데이터를 받을 때 post형식으로 받는다는 것이다. getRoomList라고 주소를 정해놓는다. {}는 빈값이고 아무런값도 아니라는 뜻, json이라고 마지막에 써서 json데이터를 받는다고 한다.

- 그리고 홈컨트롤러에서 RequestMapping을 만든다.
- @RequestMapping(value="/getRoomList",method=RequestMethod.POST,
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getRoomList(HttpServletRequest hsr) {
		iRoom room = sqlSession.getMapper(iRoom.class);
		ArrayList<Roominfo> roominfo = room.getRoomList();
		
- value를 jsp파일에 지정해둔 경로로 하고, POST방식으로 받기때문에 method를 지정해준다.
- produces는 한글이 깨지는것을 방지하기위한 유니코드설정이다.
- @ResponseBody는 Controller에서 JSP로 JSON데이터 전달하는 역할을 해준다.
- JAVA에서는 JSON이라는 데이터 타입이 없기 때문에 프론트단에서 자바에게 JSON타입의 데이터를 전달해주거나 혹은 반대로 JAVA의 객체데이터를 JSON형태로 프론트단에 전달해야 하는 경우 각각 @RequestBody와 @ResponseBody가 그 역할을 해주고 있다.

- JSONArray ja = new JSONArray();
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
- ja라는 JSONArray변수 그릇을 만든다. 

#### 20210831 (화) 작업
- 회사에서는 에러를 잡아주지 않는다. 기다리지말고 스스로 에러를 잡고 해결해보자.
- 하루종일 스프링과 SQL디벨로퍼의 DB를 연결하는 작업을 수행했다.
- iRoom.xml에서 select, delete, insert 등의 작업을 위해 씌워주고, 그 안에 sql문을 넣는다.
- 오늘은 select문만 해봄.
- mapper의 namespace는 연결된 인터페이스클래스의 경로이다.
- select구문의 id는 인터페이스의 메소드명이다. 그리고 인터페이스클래스가 반환되는 값은 resultType으로 바로 뒤에 준다.
- 그리고 인터페이스를 구성해준다.
- 인터페이스 안에 ArrayList<DB컬럼 변수들이 들어간 클래스명> 메소드명();
- 그리고 DB컬럼 변수들이 들어간 클래스를 만들어준다. 
- 클래스에서 DB컬럼명들을 다 변수정의해준다. ex) String name; int type;...
- 다 정의한 후 오른쪽-> Source -> Generate 어쩌구 using field 클릭해서 모든 변수 선택하고 omit Super 체크하고 생성
- 그리고 기본생성자도 만들어줘야한다. 위와 똑같이 진행한 후 모든 변수를 체크해제하고 omit Super 체크하고 생성하면 기본생성자 ex)public Roomtype() {} 이런게 만들어진다.
- 그리고 다시 모든 변수들을 게터세터 생성해준다.
- 위의 단계로 DB의 데이터를 받을 준비는 되었다. DB가 SQL문을 따라 프로그램으로 왔다.

- 그럼 HomeController를 통해 SQL문을 받은 iRoom.xml을 호출한 후 필요한 jsp파일에 가져다 주는 명령어를 쓴다.
- 기본적으로 HttpServletRequest hsr, Model model을 세팅한후
- iRoom room = sqlSession.getMapper(iRoom.class);
- 위처럼 iRoom.class에 있는 매퍼값을 즉, sql문을 가져와 room이란 변수에 넣는다.
- ArrayList<Roominfo> roominfo = room.getRoomList();
- 그리고 iRoom인터페이스에 있는 getRoomList()라는 ArrayList배열을 호출한다. 이것을 roominfo라는 변수에 넣는다. 
- model.addAttribute("list",roominfo);
- model addAttribute를 통해 list란 이름으로 roominfo 배열변수를 room으로 보낸다.
- return "room"; 하면 완성.

- 이제 jsp파일에서 HomeController에서 보낸 dB를 받아 클라이언트에게 보여줘야한다.
- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
- 우선 jsp파일 안에 C태그를 사용할 수 있게 미리 설정해둔다.
- 해당 배열을 다 써내려가기 보다 C태그의 forEach문을 써서 반복적으로 나타낼 수 있게 한다.
- <c:forEach items="${type}" var="room">
	<option value='${room.typecode}'>${room.typecode}.${room.name}</option>
</c:forEach>
- 위처럼 C태그를 해주는데 items="${type}"해서 해당 model로 설정한 값을 써준다. 
        


#### 20210830 (월) 작업
- cookie : 하나의 개인정보, 클라이언트(웹브라우저)에 보관. 
- ID&PW도 보관(자동로그인), 사이트방문기록 등

- 쿠키와 세션의 공통점 : 개인정보
- 보관형식 - 쿠키: 로컬화일(문자열),  세션 : 객체(변수)
- 관리주체 쿠키 : 웹브라우저, 세션: 웹서버
- 보관위치 쿠키 : 클라이언트 측, 세션 : 웹서버 측
- 프로그램 쿠키 : 자바스크립트 서버프로그램  세션 : 서버프로그램
- 수명주기 쿠키 : 최장365일(영구) 세션 : 웹사이트 벗어나면 소멸

- 대형사이트들은 사용자들의 쿠키를 분석해서 표적 마케팅, 알고리즘을 만든다.

- 마이바티스 사용을 위한 설정하기 appServlet에서 servlet-context에 이걸 추가한다.
	<beans:bean name="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
		<beans:property name="driverClassName" value="oracle.jdbc.driver.OracleDriver" />
		<beans:property name="url" value="jdbc:oracle:thin:@localhost:1521:orcl" />
		<beans:property name="username" value="ora_user" />
		<beans:property name="password" value="human123" />
	
- 그런데 여기서 주의할 점은 @localhost:1521:orcl에서 orcl부분을 확인하고 써야한다.
- 어떻게 확인하냐면 왼쪽 ora_user에서 오른쪽->속성 들어가서 SID부분을 확인하고 써야한다.

- sqlSession 안에 많은것이 들어있다. 
- DataSource : 우리가 가지고 있는 DB(SQL디벨로퍼) DB의 URL, userid, password를 선언
- Mapper : sql문들
- Mapper는 두가지로 구성된다. 하나는 xml 또하나는 interface(.java)
- 마이바티스는 실행되는 sql문을 프로그램코드에 넣지 않고 xml파일에 넣는다.
- interface에는 메소드가 들어가 있다. 
- 그래서 메퍼에는 메소드+sql문이 들어가 있다.
- xml파일의 resultType에는 어디에 반환할지에 대한 클래스 경로,이름을 써준다.
- xml에는 sql문을 통해 가져올 데이터타입을 쭉쭉 적어준다. 그리고 그것만으로는 부족하니까 인터페이스클래스를 하나 만들어서 호출할 준비를 만든다.
- xml의 select id에는 인터페이스의 메소드, reslutType에는 인터페이스의 반환데이터타입
- 메퍼의 namespace는 인터페이스의 경로명+이름을 적어준다.
- 인터페이스는 껍데기. 중간 매개역할. 보내주는 껍데기이다.

- 인터페이스와 xml파일은 긴밀한 관계이다. 서로 짝이 맞아야 xml파일 안의 sql문이 발휘된다.

sql문 가져가기
create table room (
roomcode decimal(2) primary key, --단일컬럼, 전체테이블의 그 칼럼에서 유일한 값을 갖는다.
name varchar2(20),
type decimal(2),
howmany decimal(2),
howmuch decimal(6,0)
);

create table roomtype(
typecode decimal(2) primary key,
name varchar2(20)
);

insert into roomtype values(1,'SuiteRoom');
insert into roomtype values(2,'FamilyRoom');
insert into roomtype values(3,'DoubleRoom');
insert into roomtype values(4,'SingleRoom');

select * from roomtype;

select*from room;
insert into room values(1,'백두산',1,8,500000);
insert into room values(2,'한라산',2,6,450000);
insert into room values(3,'설악산',3,4,300000);
insert into room values(4,'지리산',4,2,150000);

select a.roomcode, a.name, b.name, a.howmany, a.howmuch  from room a, roomtype b
where a.type=b.typecode;



#### 20210827 (금) 작업
- 세션(Session) : 개인정보, 웹서버에 보관, 객체(변수)
- JSP 내장객체(Built-in Object) : 별도 선언안하고 쓸 수 있는 것
- 입출력 out, request, response
- 서블릿 page, config
- 외부환경정보 session, application, pageContext
- 예외처리 exception

- 세션(session) : 여러 웹페이지에서 공유하는 정보.
- 홈컨트롤러의 맨위에 클래스필드로서 정의해놓음. private HttpSession session;
- session.invalidate(); <- 모든 세션변수 삭제됨.

- 세션이 삭제되는 경우
1. session.invalidate();
2. 웹브라우저를 닫아버리면 자동소멸
3. 다른 웹사이트로 이동하면 세션이 사라짐.
4. 웹서버가 다운되면 소멸.

- 세션 생성 : session.setAttribute("userid",loginid);
- set했으면 get해서 꺼내올 수 있다.
- public String booking(HttpServletRequest hsr) {
	session=hsr.getSession();


- HomeController에서의 Session : Session을 세팅
1. HttpSession 변수 하나를 선언&초기화(
2. HttpSession session=(HttpServletRequest) hsr.getSession();
3. session.setAttribute("변수명",값)

- JSP with scriptlet
<% 
	String 변수=(String)session.getAttribute("변수명");
	if(변수값 검사){}else{}
 %>
 
- return "redirect:/booking"; <- RequestMapping의 경로 이름	즉, booking으로 가는 RequestMapping을 거치게 한다.
- return "booking"; <- JSP 파일 이름	

- public String check_user(HttpServletRequest hsr, Model model) {
		String userid=hsr.getParameter("userid");
		String passcode=hsr.getParameter("passcode");
		session=hsr.getSession();
- session을 사용하기 위해서는 HttpServletRequest를 통해 데이터를 받아들이고, 
getSession();을 지정해줘서 세션을 쓸 준비를 해놔야 세션을 사용할 수 있다. 
- HttpServletRequest는 데이터를 받아들이는 역할이다. 

- RequestMapping booking안에 userid/passcode를 체킹하지 않고, RequestMapping Check_user를 새로 만들어서 거기서 체크하게 만든다.
- Controller에서 바로 login 후 booking을 가는 것이 아니라,
- 그 중간에 check하는 곳을 만들어서 여기서 userid/passcode check하게하는 session을 만든다.
- 그렇게 해야 booking.jsp와 room.jsp간 이동이 매우 자유롭다.
- 그 전에는 리퀘스트 booking 안에 POST로 받아 체킹을 하다보니 GET방식인 room과 데이터 전송방식이 달라 이동에 있어 오류가 났다.
- 원래 RequestMapping의 booking안에서 userid/passcode를 체크하게 시켰는데 그런 것이 아니라 check_user를 만들어서 거길 통과시켜서 맞으면 booking을 보여주게한다. 그래서 booking에서 room을갈때, room에서 booking으로 갈때 서로 GET/POST방식의 차이가 없기 때문에 이동이 자유로워진다.
- 그래서 check_user에서 return값을 redirect:/로 booking을 지정해서 check_user로 아이디와 비밀번호를 체킹한 후 RequestMapping booking으로 보낸다.

- room의 리퀘스트 매핑에는 loginid==null값이 될 경우를 만들어준다. 다른웹사이트가면 세션이 초기화된다. 그래서 null값이 될경우를 써준다.

- 되도록이면 거의 모든 작업을 컨트롤러로 해주는게 이상적이다. jsp에서 하면 지저분해진다.

		
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

