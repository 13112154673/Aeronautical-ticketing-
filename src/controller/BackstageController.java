package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;

import pojo.Aircraft;
import pojo.Flight;
import pojo.FlightComplete;
import pojo.Passenger;
import pojo.Staff;
import pojo.Ticket;
import pojo.TicketComplete;
import service.FlightService;
import service.PassengerService;
import service.StaffService;
import service.TicketService;
import system.Page;

@Controller
@RequestMapping("Backstage")
public class BackstageController {
	@Autowired
	StaffService staffservice;
	@Autowired
	TicketService ticketservice;
	@Autowired
	PassengerService passengerservice;
	@Autowired
	FlightService flightservice;

	/*
	 * 1.1员工登陆
	 */
	@RequestMapping("loginstaff")
	public ModelAndView login(Integer sId, String password, HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("redirect:../backstageIndex.jsp");
		Staff staff = staffservice.findStaffById(sId, password);

		// 获取所有简单票务
		List<Ticket> ticketslist = ticketservice.findAllTicket();
		// 遍历出该乘客所有票务信息，并加入一个TicketComplete列表中
		List<TicketComplete> ticketCompleteslist = new ArrayList<TicketComplete>();

		// 遍历找出所需状态的票,退票状态
		Iterator<Ticket> iter = ticketslist.iterator();
		while (iter.hasNext()) {
			if (iter.next().getState() != 2) {
				iter.remove();
			}
		}
		// 显示所有退票状态的机票
		if (ticketslist != null) {
			for (int i = 0; i < ticketslist.size(); i++) {
				Flight flight = ticketservice.findFlightByFid(ticketslist.get(i).getfId());
				Aircraft aircraft = ticketservice.findAircraftByAid(flight.getaId());
				Passenger passenger = passengerservice.findPassengerByPhone(ticketslist.get(i).getPhone());
				TicketComplete ticketComplete = new TicketComplete(ticketslist.get(i).gettId(),
						ticketslist.get(i).getState(), ticketslist.get(i).getReason(), passenger, flight, aircraft);
				ticketCompleteslist.add(ticketComplete);
			}
		}
		
		/*找出所有航空飞机公司名称，剔除重复。采用map实现，遍历将arraylist插入map中，如果不存在则创建键和值，存在则往对应的键的值中插入飞机编号
		不过数据库设计的时候没分离出来，也就先这样写着好了*/
		List<Aircraft> aircraftlist =ticketservice.findAllAircraft();
		HashMap<String, ArrayList<String>> aircraftmap =new HashMap<>();
		for(Aircraft aircraft:aircraftlist) {
			//判断该为空还是大小为0，删除元素后list大小为0还是为null？？，这里假设定义map完便new了arraylist
			if(aircraftmap.get(aircraft.getCompany())==null ) {
				ArrayList<String> aIdlist =new  ArrayList<>();
				aIdlist.add(aircraft.getaId());
				aircraftmap.put(aircraft.getCompany(), aIdlist);
			}else {
				aircraftmap.get(aircraft.getCompany()).add(aircraft.getaId());
			}
				
		}
		String allAircraft =JSON.toJSONString(aircraftmap);
		
		if (staff != null) {
			// 登陆成功后，设置当前在线用户
			request.getSession().setAttribute("onlineStaff", staff);
			//前者传回map，后者传回map对象打包的JSON，二者区别在于分隔符是=还是:
			mav.addObject("allAircraft", aircraftmap);
			mav.addObject("allAircraftJson", allAircraft);
			mav.addObject("ticketListWithState2", ticketCompleteslist);
			mav.setViewName("backstage");
			return mav;
		}
		mav.addObject("error", "error");
		return mav;
	}
	/*
	 * 1.2向页面登入信息的跳转，包括每次操作后都执行这一跳转
	 */
	@RequestMapping("backstage")
	public ModelAndView jumpbackstage(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		// 获取所有简单票务
		List<Ticket> ticketslist = ticketservice.findAllTicket();
		// 遍历出该乘客所有票务信息，并加入一个TicketComplete列表中
		List<TicketComplete> ticketCompleteslist = new ArrayList<TicketComplete>();
		// 遍历找出所需状态的票,退票状态
		Iterator<Ticket> iter = ticketslist.iterator();
		while (iter.hasNext()) {
			if (iter.next().getState() != 2) {
				iter.remove();
			}
		}
		// 显示所有退票状态的机票
		if (ticketslist != null) {
			for (int i = 0; i < ticketslist.size(); i++) {
				Flight flight = ticketservice.findFlightByFid(ticketslist.get(i).getfId());
				Aircraft aircraft = ticketservice.findAircraftByAid(flight.getaId());
				Passenger passenger = passengerservice.findPassengerByPhone(ticketslist.get(i).getPhone());
				TicketComplete ticketComplete = new TicketComplete(ticketslist.get(i).gettId(),
						ticketslist.get(i).getState(), ticketslist.get(i).getReason(), passenger, flight, aircraft);
				ticketCompleteslist.add(ticketComplete);
			}
		}
		/*// 显示所有航班
		Page p = new Page();
		p.setStart(0);
		p.setCount(4);
		int total = flightservice.total();
		p.caculateLast(total);
		List<Flight> allFlight = flightservice.findAllFlight(p);
		System.out.println(allFlight.size());

		List<FlightComplete> allFlightComplete = new ArrayList<FlightComplete>();
		Iterator<Flight> iterator = allFlight.iterator();
		while (iterator.hasNext()) {
			Flight flight = iterator.next();
			// 根据每个初始航班内的aid找到每一个对应的飞机，并将其加入新的列表内
			allFlightComplete.add(new FlightComplete(flight, ticketservice.findAircraftByAid(flight.getaId())));
		}*/
		
		/*找出所有航空飞机公司名称，剔除重复。采用map实现，遍历将arraylist插入map中，如果不存在则创建键和值，存在则往对应的键的值中插入飞机编号
		不过数据库设计的时候没分离出来，也就先这样写着好了*/
		List<Aircraft> aircraftlist =ticketservice.findAllAircraft();
		HashMap<String, ArrayList<String>> aircraftmap =new HashMap<>();
		for(Aircraft aircraft:aircraftlist) {
			//判断该为空还是大小为0，删除元素后list大小为0还是为null？？，这里假设定义map完便new了arraylist
			if(aircraftmap.get(aircraft.getCompany())==null ) {
				ArrayList<String> aIdlist =new  ArrayList<>();
				aIdlist.add(aircraft.getaId());
				aircraftmap.put(aircraft.getCompany(), aIdlist);
			}else {
				aircraftmap.get(aircraft.getCompany()).add(aircraft.getaId());
			}
		}
		String allAircraft =JSON.toJSONString(aircraftmap);
		//前者传回map，后者传回map对象打包的JSON，二者区别在于分隔符是=还是:
		mav.addObject("allAircraft", aircraftmap);
		mav.addObject("allAircraftJson", allAircraft);
		mav.addObject("ticketListWithState2", ticketCompleteslist);
		mav.setViewName("backstage");
		return mav;
		
	}
	
	/*
	 * 1.3用ajax获取航班的json
	 */
	@RequestMapping("showFlight")
	public void showFlight(Integer start ,HttpServletRequest request,HttpServletResponse response) throws IOException {
		//返回给前台
		response.setCharacterEncoding("UTF-8");  
		PrintWriter out = response.getWriter();
	
		Page p = new Page();
		p.setStart(start);
		
		int total = flightservice.total();
		p.caculateLast(total);
		List<Flight> allFlight = flightservice.findAllFlight(p);

		//List<FlightComplete> allFlightComplete = new ArrayList<FlightComplete>();
		Iterator<Flight> iterator = allFlight.iterator();
		
		//不知道怎么将页码传回去，就只好弄成拼成一个json回去了
		JSONArray jArray=new JSONArray();
		jArray.add(p);
		while (iterator.hasNext()) {
			Flight flight = iterator.next();
			/*// 根据每个初始航班内的aid找到每一个对应的飞机，并将其加入新的列表内
			allFlightComplete.add(new FlightComplete(flight, ticketservice.findAircraftByAid(flight.getaId())));*/
			jArray.add(new FlightComplete(flight, ticketservice.findAircraftByAid(flight.getaId())));
		}
		
		System.out.println(jArray.toJSONString());
		
		out.print(jArray.toJSONString());
		
	}
	/*
	 * 2.1对应passenger的returnTicket退票申请，将员工确认后的票从数据库中删除？航班内座位数量增加
	 */
	@RequestMapping("returnTicketAgree")
	public void returnTicketAgree(Integer tId, HttpServletResponse response) throws IOException {
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		if (tId != null) {
			ticketservice.deleteTicket(tId);

			pw.write("成功");
		} else {
			pw.write("失败");
		}
	}
	/*
	 * 3.1增加航班
	 */

	@RequestMapping("addFlight")
	public ModelAndView addFlight(HttpServletRequest request) throws ParseException {
		ModelAndView mav = new ModelAndView("redirect:backstage");
		// 没搞定参数绑定前字能用这个蠢方法了！！！！！！
		Flight flight = new Flight();
		flight.setfId(Integer.valueOf(request.getParameter("fId")));
		flight.setaId(request.getParameter("airName"));
		// String转date
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		flight.setArrivalTime(formatter.parse(request.getParameter("arrivalTime")));
		flight.setArrivalPlace(request.getParameter("arrivalPlace"));
		flight.setDepartureTime(formatter.parse(request.getParameter("departureTime")));
		flight.setDeparturePlace(request.getParameter("departurePlace"));
		flight.setFristclassPrice(Integer.valueOf(request.getParameter("fristclassPrice")));
		flight.setFristclassCount(Integer.valueOf(request.getParameter("fristclassCount")));
		flight.setEconomyPrice(Integer.valueOf(request.getParameter("economyPrice")));
		flight.setEconomyCount(Integer.valueOf(request.getParameter("economyCount")));
		if (flightservice.addFlight(flight)) {
			// 成功
			return mav;
		}

		return mav;

	}
}
