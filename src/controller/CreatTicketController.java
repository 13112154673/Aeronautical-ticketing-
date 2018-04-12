package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

import pojo.Flight;
import pojo.Passenger;
import pojo.Ticket;
import service.FlightService;
import service.TicketService;
import system.Page;

@Controller
@RequestMapping("CreatTicket")
public class CreatTicketController {
	@Autowired
	TicketService ticketService;
	@Autowired
	FlightService flightService;

	/*
	 * 1.1跳转详细查找页面detailedSearch.jsp，并将搜索信息（出发地和目的地，出发时间可有可无）传入该页面，
	 * 由redetailedSearch方法查询航班信息
	 */
	@RequestMapping("detailedSearch")
	public ModelAndView detailedSearch(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("detailedSearch");
		mav.addObject("departurePlace", request.getParameter("departurePlace"));
		mav.addObject("arrivalPlace", request.getParameter("arrivalPlace"));
		// 若没有，则为""
		mav.addObject("departureTime", request.getParameter("departureTime"));
		return mav;
	}

	/*
	 * 1.2通过搜索信息返回航班列表的JSON
	 */
	@RequestMapping("redetailedSearch")
	public void redetailedSearch(String departurePlace, String arrivalPlace, String departureTime,
			HttpServletResponse response, HttpServletRequest request) throws IOException {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		List<Flight> flightlist = new ArrayList<>();

		if (null != departurePlace && null != arrivalPlace) {
			System.out.println(departurePlace + arrivalPlace + departureTime);
			flightlist = flightService.findAllFlight(departurePlace, arrivalPlace, departureTime, new Page(0, 5));
			System.out.println(flightlist.size());
			String flightlistJson = JSON.toJSONString(flightlist, SerializerFeature.WriteDateUseDateFormat);
			out.print(flightlistJson);
			System.out.println(flightlistJson);

		}

	}

	/*
	 * 2.1查询机票，目前只返回出发地和目的地，出发时间和到达时间。
	 */
	@RequestMapping("findTicketByTId")
	public void findTicketByTId(Integer tId, HttpServletResponse response) throws IOException {
		// 返回给前台
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		Ticket ticket = ticketService.fIndTicketByTid(tId);
		if (null != ticket) {
			Flight flight = ticketService.findFlightByFid(ticket.getfId());
			String ticketJson = JSON.toJSONString(flight, SerializerFeature.WriteDateUseDateFormat);

			if (flight != null) {
				out.print(ticketJson);
			}
		} else {
			out.print("error");
		}
	}

	/*
	 * 3.1订票，新增一个Ticket到数据库
	 */
	@RequestMapping("creatTicket")
	public void creatTicket(Integer fId, Integer choose, HttpServletResponse response, HttpSession session)
			throws IOException {
		// 返回给前台
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		// 获取当前乘客模型
		Passenger passenger = (Passenger) session.getAttribute("onlinePassenger");

		Ticket ticket = new Ticket();
		ticket.setPhone(passenger.getPhone());
		ticket.setfId(fId);
		ticket.setCobinChoose(choose);

		if (ticketService.insertTicket(ticket)) {
			out.print("成功购票");
		} else {
			out.print("购票失败");
		}
	}
}
