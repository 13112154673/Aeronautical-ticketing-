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
import com.alibaba.fastjson.serializer.SerializerFeature;

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
	public ModelAndView loginStaff(Integer sId, String password, HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("redirect:../backstageIndex.jsp");
		Staff staff = staffservice.findStaffById(sId, password);
		if (staff != null) {
			// 登陆成功后，设置当前在线用户
			request.getSession().setAttribute("onlineStaff", staff);
			mav.setViewName("redirect:backstage");
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
		// 存储退票列表
		List<Ticket> ticketslist2 = new ArrayList<Ticket>();
		List<TicketComplete> ticketlistWithState2 = new ArrayList<TicketComplete>();
		// 存储改签列表
		List<Ticket> ticketslist1 = new ArrayList<Ticket>();
		List<TicketComplete> ticketlistWithState1 = new ArrayList<TicketComplete>();

		// 遍历找出所需状态的票,退票2和改签1状态
		for (Ticket ticket : ticketslist) {
			if (ticket.getState() == 1) {
				ticketslist1.add(ticket);
			} else if (ticket.getState() == 2) {
				ticketslist2.add(ticket);
			}
		}
		// 显示所有退票状态的机票
		if (ticketslist2 != null) {
			for (int i = 0; i < ticketslist2.size(); i++) {
				Flight flight = ticketservice.findFlightByFid(ticketslist2.get(i).getfId());
				Aircraft aircraft = ticketservice.findAircraftByAid(flight.getaId());
				Passenger passenger = passengerservice.findPassengerByPhone(ticketslist2.get(i).getPhone());
				TicketComplete ticketComplete = new TicketComplete(ticketslist2.get(i).gettId(),
						ticketslist2.get(i).getState(), ticketslist2.get(i).getReason(), passenger, flight, aircraft);
				ticketlistWithState2.add(ticketComplete);
			}
		}
		// 显示所有改签状态的机票
		if (ticketslist1 != null) {
			for (int i = 0; i < ticketslist1.size(); i++) {
				Flight flight = ticketservice.findFlightByFid(ticketslist1.get(i).getfId());
				Aircraft aircraft = ticketservice.findAircraftByAid(flight.getaId());
				Passenger passenger = passengerservice.findPassengerByPhone(ticketslist1.get(i).getPhone());
				Flight newflight = ticketservice.findFlightByFid(ticketslist1.get(i).getNewfId());
				TicketComplete ticketComplete = new TicketComplete(ticketslist1.get(i).gettId(),
						ticketslist1.get(i).getState(), ticketslist1.get(i).getReason(), passenger, flight, aircraft,
						newflight);
				ticketlistWithState1.add(ticketComplete);
			}
		}

		/*
		 * 找出所有航空飞机公司名称，剔除重复。采用map实现，遍历将arraylist插入map中，如果不存在则创建键和值，存在则往对应的键的值中插入飞机编号
		 * 不过数据库设计的时候没分离出来，也就先这样写着好了
		 */
		List<Aircraft> aircraftlist = ticketservice.findAllAircraft();
		HashMap<String, ArrayList<String>> aircraftmap = new HashMap<>();
		for (Aircraft aircraft : aircraftlist) {
			// 判断该为空还是大小为0，删除元素后list大小为0还是为null？？，这里假设定义map完便new了arraylist
			if (aircraftmap.get(aircraft.getCompany()) == null) {
				ArrayList<String> aIdlist = new ArrayList<>();
				aIdlist.add(aircraft.getaId());
				aircraftmap.put(aircraft.getCompany(), aIdlist);
			} else {
				aircraftmap.get(aircraft.getCompany()).add(aircraft.getaId());
			}
		}
		String allAircraft = JSON.toJSONString(aircraftmap);
		// 前者传回map，后者传回map对象打包的JSON，二者区别在于分隔符是=还是:
		mav.addObject("allAircraft", aircraftmap);
		mav.addObject("allAircraftJson", allAircraft);
		mav.addObject("ticketListWithState2", ticketlistWithState2);
		mav.addObject("ticketListWithState1", ticketlistWithState1);
		mav.setViewName("backstage");
		return mav;

	}

	/*
	 * 1.3用ajax获取航班的json
	 */
	@RequestMapping("showFlight")
	public void showFlight(Integer start, HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 返回给前台
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		Page p = new Page();
		p.setStart(start);

		int total = flightservice.total();
		p.caculateLast(total);
		List<Flight> allFlight = flightservice.findAllFlight(p);

		// List<FlightComplete> allFlightComplete = new ArrayList<FlightComplete>();
		Iterator<Flight> iterator = allFlight.iterator();

		// 不知道怎么将页码传回去，就只好弄成拼成一个json回去了
		JSONArray jArray = new JSONArray();
		jArray.add(p);
		while (iterator.hasNext()) {
			Flight flight = iterator.next();
			/*
			 * // 根据每个初始航班内的aid找到每一个对应的飞机，并将其加入新的列表内 allFlightComplete.add(new
			 * FlightComplete(flight, ticketservice.findAircraftByAid(flight.getaId())));
			 */
			jArray.add(new FlightComplete(flight, ticketservice.findAircraftByAid(flight.getaId())));
		}

		

		out.print(JSONArray.toJSONString(jArray,SerializerFeature.WriteDateUseDateFormat));

	}

	/*
	 * 2.1对应passenger的returnTicket退票申请，将员工确认后的票从数据库中删除？航班内座位数量增加
	 */
	@RequestMapping("returnTicketAgree")
	public void returnTicketAgree(Integer tId, HttpServletResponse response) throws IOException {
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		if (tId != null) {
			Ticket ticket =ticketservice.fIndTicketByTid(tId);
			Flight flight=flightservice.findFlight(ticket.getfId());
			if(0==ticket.getCobinChoose()) {
				flight.setEconomyCount(flight.getFristclassCount()+1);
			}else {
				flight.setFristclassCount(flight.getEconomyCount()+1);
			}
			flightservice.updateFlight(flight);
			ticketservice.deleteTicket(tId);
			pw.write("成功");
		} else {
			pw.write("失败");
		}
	}

	/*
	 * 2.2对应passenger的updateTicket改签申请，改签后原航班内座位数量增加，新航班座位减少,前台设置不能更改为0的舱位把
	 */
	@RequestMapping("updateTicket")
	public void updateTicket(Integer tId, HttpServletResponse response) throws IOException {
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		if (tId != null) {
			// 应该事务操作，不过现在还没改
			Ticket ticket = ticketservice.fIndTicketByTid(tId);
			Flight oldflight = flightservice.findFlight(ticket.getfId());
			Flight newflight = flightservice.findFlight(ticket.getNewfId());
			// 标识改签是否成功，未成功原因：更改航班对应座位数不足
			String isenough = "false";
			// 0代表头等舱，1代表经济舱
			if (0 == ticket.getCobinChoose()) {
				int FristclassCount = newflight.getFristclassCount() - 1;
				if (FristclassCount >= 0) {
					oldflight.setFristclassCount(oldflight.getFristclassCount() + 1);
					newflight.setFristclassCount(FristclassCount);
					isenough = "true";
				}
			} else {
				int EconomyCount = newflight.getEconomyCount() - 1;
				if (EconomyCount >= 0) {
					oldflight.setEconomyCount(oldflight.getEconomyCount());
					newflight.setFristclassCount(EconomyCount);
					isenough = "true";
				}
			}
			if ("true".equals(isenough)) {
				flightservice.updateFlight(oldflight);
				flightservice.updateFlight(newflight);
				ticketservice.updateTicketByTid(tId);
			}
			pw.write(isenough);
		}
	}

	/*
	 * 2.3反对改签，将机票状态设置为4
	 */
	@RequestMapping("opposeUpdate")
	public void opposeUpdate(Integer tId, HttpServletResponse response) throws IOException {
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		if (ticketservice.updateTicketByTid(tId, true)) {
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
