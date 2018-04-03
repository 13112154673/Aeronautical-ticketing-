package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

import pojo.Flight;
import pojo.Ticket;
import service.TicketService;

@Controller
@RequestMapping("CreatTicket")
public class CreatTicketController {
	@Autowired
	TicketService ticketTervice;
	
	/*
	 * 1.1跳转详细查找页面detailedSearch.jsp
	 */
	@RequestMapping("detailedSearch")
	public ModelAndView detailedSearch() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("detailedSearch");
		return mav;
	}
	
	@RequestMapping("findTicketByTId")
	public void findTicketByTId(Integer tId,HttpServletResponse response) throws IOException {
		//返回给前台
		response.setCharacterEncoding("UTF-8");  
		PrintWriter out = response.getWriter();
		
		Ticket ticket =ticketTervice.fIndTicketByTid(tId);
		Flight flight =ticketTervice.findFlightByFid(ticket.getfId());
		String ticketJson =JSON.toJSONString(flight,SerializerFeature.WriteDateUseDateFormat);
		
		if(flight!=null) {
			out.print(ticketJson);
		}else {
			out.print("error");
		}
	}
}
