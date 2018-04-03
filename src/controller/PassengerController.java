package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import pojo.Aircraft;
import pojo.Flight;
import pojo.Passenger;
import pojo.Ticket;
import pojo.TicketComplete;
import service.PassengerService;
import service.TicketService;

@Controller
@RequestMapping("Passenger")
public class PassengerController {
	@Autowired
	PassengerService passengerService;
	@Autowired
	TicketService ticketservice;

	/*
	 * 1.1方便首页的登陆按钮直接跳转到WEB-IF下的login.jsp
	 */
	@RequestMapping("jumpLogin")
	public ModelAndView jumpLogin() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;
	}

	/*
	 * 1.2登陆验证
	 */
	@RequestMapping("login")
	public ModelAndView login(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("redirect:../index.jsp");// 重定向后mav.addObject();添加的可能失效
		Integer phone = Integer.valueOf(request.getParameter("phone"));
		String password = (String) request.getParameter("password");
		System.out.println(phone + password);
		Passenger passenger = passengerService.findPassengerByPhone(phone, password);

		if (passenger != null) {
			// 登陆成功后，设置当前在线用户
			request.getSession().setAttribute("onlinePassenger", passenger);
			// System.out.println(passenger.getSex());
			return mav;
		}
		mav.setViewName("login");
		return mav;
	}

	/*
	 * 1.3注销
	 */
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:../index.jsp";
	}

	/*
	 * 2.1方便首页的登陆按钮直接跳转到WEB-IF下的register.jsp
	 */
	@RequestMapping("jumpRegister")
	public ModelAndView jumpRegister() {
		ModelAndView mav = new ModelAndView("register");
		return mav;
	}

	/*
	 * 2.2注册,还是熟悉的参数绑定的问题，导致代码很爆炸
	 */
	@RequestMapping("register")
	public ModelAndView register(HttpServletRequest request) throws ParseException {
		ModelAndView mav = new ModelAndView();
		Passenger passenger = new Passenger();
		// 前端验证保证传过来的Passenger是符合数据库的？
		passenger.setpName(request.getParameter("pName"));
		passenger.setpId(request.getParameter("pId"));
		passenger.setSex(request.getParameter("sex"));
		// String转date
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(request.getParameter("brithday"));
		passenger.setBrithday(formatter.parse(request.getParameter("brithday")));
		passenger.setPhone(Integer.valueOf(request.getParameter("phone")));
		passenger.setPassword(request.getParameter("password"));
		passenger.setCity(request.getParameter("city"));
		passenger.setEmail(request.getParameter("email"));

		// 没找到重复手机号码的，假设只有手机号码惟一
		if (passengerService.findPassengerByPhone(passenger.getPhone()) == null
				&& passengerService.addPassenger(passenger)) {
			/* mav.addObject("info","success"); */

			// 注册成功后自动跳到登陆好的首页
			request.getSession().setAttribute("onlinePassenger", passenger);
			mav.setViewName("redirect:../index.jsp");
			return mav;
		}
		mav.addObject("info", "error");
		mav.setViewName("register");
		return mav;
	}

	/*
	 * 3.1跳转到个人信息页面
	 */
	@RequestMapping("jumpInformation")
	public ModelAndView jumpInformation(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("information");
		// 获取当前乘客模型
		Passenger passenger = (Passenger) session.getAttribute("onlinePassenger");
		// 获取当前乘客所有简单票务
		List<Ticket> ticketslist = ticketservice.findTicketByPhone(passenger.getPhone());
		// 遍历出该乘客所有票务信息，并加入一个TicketComplete列表中
		List<TicketComplete> ticketCompleteslist = new ArrayList<TicketComplete>();
		if (ticketslist != null) {
			for (int i = 0; i < ticketslist.size(); i++) {
				Flight flight = ticketservice.findFlightByFid(ticketslist.get(i).getfId());
				Aircraft aircraft = ticketservice.findAircraftByAid(flight.getaId());
				TicketComplete ticketComplete = new TicketComplete(ticketslist.get(i).gettId(),ticketslist.get(i).getState(),ticketslist.get(i).getReason(), passenger, flight,
						aircraft);
				ticketCompleteslist.add(ticketComplete);
			}
			System.out.println(passenger.getpName());

			// System.out.println(ticketCompleteslist.get(0).getPassenger().getpName());
		}
		mav.addObject("ticketCompleteslist", ticketCompleteslist);
		return mav;
	}

	/*
	 * 3.2修改个人信息
	 */
	@RequestMapping("updateInformation")
	public ModelAndView updateInformation(HttpServletRequest request, Integer phone) throws ParseException {
		ModelAndView mav = new ModelAndView("information");
		Passenger passenger = new Passenger();
		// 前端验证保证传过来的Passenger是符合数据库的？
		passenger.setpName(request.getParameter("pName"));
		passenger.setpId(request.getParameter("pId"));
		passenger.setSex(request.getParameter("sex"));
		// String转date
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		passenger.setBrithday(formatter.parse(request.getParameter("brithday")));
		passenger.setPassword(request.getParameter("password"));
		passenger.setCity(request.getParameter("city"));
		passenger.setEmail(request.getParameter("email"));
		passenger.setPhone(phone);

		if (passengerService.updatePassenger(passenger)) {
			request.getSession().setAttribute("onlinePassenger", passenger);
			// 获取当前乘客所有简单票务
			List<Ticket> ticketslist = ticketservice.findTicketByPhone(passenger.getPhone());
			// 遍历出该乘客所有票务信息，并加入一个TicketComplete列表中
			List<TicketComplete> ticketCompleteslist = new ArrayList<TicketComplete>();
			if (ticketslist != null) {
				for (int i = 0; i < ticketslist.size(); i++) {
					Flight flight = ticketservice.findFlightByFid(ticketslist.get(i).getfId());
					Aircraft aircraft = ticketservice.findAircraftByAid(flight.getaId());
					TicketComplete ticketComplete = new TicketComplete(ticketslist.get(i).gettId(),ticketslist.get(i).getState(),ticketslist.get(i).getReason(), passenger, flight,
							aircraft);
					ticketCompleteslist.add(ticketComplete);
				}
			}
			mav.addObject("ticketCompleteslist", ticketCompleteslist);
			return mav;
		}
		mav.addObject("info", "error");
		return mav;

	}
	/*
	 * 4.1使用Ajax的异步刷新，将退票申请发至数据库
	 */
	@RequestMapping("returnTicket")
	public void returnTicket(Integer tId,String reason,HttpServletResponse response) throws IOException {
		//response.setCharacterEncoding("UTF_8");
		response.setHeader("Content-type","text/html;charset=UTF-8");
		PrintWriter pw=response.getWriter();
		if(tId!=null&&ticketservice.updateTicketByTid(tId, reason)) {
			pw.write("成功提交退票申请");
		}else {
			pw.write("提交失敗");
		}
	}
}
