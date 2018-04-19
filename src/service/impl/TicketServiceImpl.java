package service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.AircraftMapper;
import mapper.FlightMapper;
import mapper.TicketMapper;
import pojo.Aircraft;
import pojo.AircraftExample;
import pojo.Flight;
import pojo.Ticket;
import pojo.TicketExample;
import pojo.TicketExample.Criteria;
import service.TicketService;

@Service
public class TicketServiceImpl implements TicketService {

	@Autowired
	TicketMapper ticketmapper;
	@Autowired
	FlightMapper flightmapper;
	@Autowired
	AircraftMapper aircraftmapper;

	@Override
	public List<Ticket> findTicketByPhone(Integer phone) {
		if (phone != null) {

			TicketExample ticketExample = new TicketExample();
			Criteria createCriteria = ticketExample.createCriteria();
			createCriteria.andPhoneEqualTo(phone);
			List<Ticket> ticketslist = ticketmapper.selectByExample(ticketExample);
			if (ticketslist.size() > 0) {
				return ticketslist;
			}
		}
		return null;
	}

	@Override
	public boolean updateTicketByTid(Integer tId, String reason) {
		if (tId != null) {
			Ticket ticket = ticketmapper.selectByPrimaryKey(tId);
			ticket.setReason(reason);
			ticket.setState(2);// 设置状态为退票申请中
			System.out.println("OK");
			if (ticket != null && ticketmapper.updateByPrimaryKeySelective(ticket) > 0) {
				return true;
			}
		}
		return false;
	}
	
	@Override
	public boolean updateTicketByTid(Integer tId, Integer newFId) {
		if (tId != null) {
			Ticket ticket = ticketmapper.selectByPrimaryKey(tId);
			ticket.setNewfId(newFId);
			ticket.setState(1);// 设置状态为改签申请中
			if (ticket != null && ticketmapper.updateByPrimaryKeySelective(ticket) > 0) {
				return true;
			}
		}
		return false;
	}

	@Override
	public Flight findFlightByFid(Integer fId) {

		if (fId != null) {
			Flight flight = flightmapper.selectByPrimaryKey(fId);
			if (flight != null) {
				return flight;
			}
		}
		return null;
	}

	@Override
	public Aircraft findAircraftByAid(String aId) {
		if (aId != null) {
			Aircraft aircraft = aircraftmapper.selectByPrimaryKey(aId);
			return aircraft;
		}
		return null;
	}

	@Override
	public List<Ticket> findAllTicket(){
		TicketExample ticketExample = new TicketExample();
		//Criteria createCriteria = ticketExample.createCriteria();
		List<Ticket> ticketslist =new ArrayList<Ticket>();
		ticketslist = ticketmapper.selectByExample(ticketExample);
		return ticketslist;
	}

	@Override
	public boolean deleteTicket(Integer tId) {
		if(ticketmapper.deleteByPrimaryKey(tId)>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public List<Aircraft> findAllAircraft() {
		AircraftExample aircraftExample =new AircraftExample();
		List<Aircraft> aircraftslist =new ArrayList<Aircraft>();
		aircraftslist = aircraftmapper.selectByExample(aircraftExample);
		return aircraftslist;
	}

	@Override
	public Ticket fIndTicketByTid(Integer tId) {
		if (tId != null) {
			Ticket ticket = ticketmapper.selectByPrimaryKey(tId);
			return ticket;
		}
		return null;
	}

	@Override
	public Boolean insertTicket(Ticket ticket) {
		if(ticket!=null && ticketmapper.insertSelective(ticket)>0) {
			return true;
		}
		return false;
	}

	

}
