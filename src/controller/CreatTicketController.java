package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

import pojo.Flight;
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
	 * 1.1跳转详细查找页面detailedSearch.jsp，并将搜索信息（出发地和目的地，出发时间可有可无）传入
	 */
	@RequestMapping("detailedSearch")
	public ModelAndView detailedSearch(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("detailedSearch");
		String departurePlace = request.getParameter("departurePlace");
		String arrivalPlace = request.getParameter("arrivalPlace");
		List<Flight> flightlist = new ArrayList<>();
		System.out.println(departurePlace+"-------"+arrivalPlace);
		if(departurePlace!=null&&arrivalPlace!=null) {
			flightlist=flightService.findAllFlight(departurePlace, arrivalPlace,new Page(0,5));
			System.out.println(flightlist.size());
			String flightlistJson =JSON.toJSONString(flightlist, SerializerFeature.WriteDateUseDateFormat);
			mav.addObject("flightslist",flightlistJson);
			System.out.println(flightlistJson);
		}
		return mav;
	}
	/*
	 * 1.2通过搜索信息返回航班列表的JSON
	 */
	@RequestMapping("redetailedSearch")
	public void redetailedSearch(String departurePlace,String arrivalPlace,HttpServletResponse response,HttpServletRequest request) throws IOException {
		response.setCharacterEncoding("UTF-8");  
		PrintWriter out = response.getWriter();
		
		List<Flight> flightlist = new ArrayList<>();
		System.out.println(departurePlace+"-------"+arrivalPlace);
		if(departurePlace!=null&&arrivalPlace!=null) {
			flightlist=flightService.findAllFlight(departurePlace, arrivalPlace,new Page(0,5));
			System.out.println(flightlist.size());
			String flightlistJson =JSON.toJSONString(flightlist, SerializerFeature.WriteDateUseDateFormat);
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
		Flight flight = ticketService.findFlightByFid(ticket.getfId());
		String ticketJson = JSON.toJSONString(flight, SerializerFeature.WriteDateUseDateFormat);

		if (flight != null) {
			out.print(ticketJson);
		} else {
			out.print("error");
		}
	}
}
