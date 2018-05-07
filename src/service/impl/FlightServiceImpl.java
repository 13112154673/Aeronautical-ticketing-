package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.FlightMapper;
import pojo.Flight;
import pojo.FlightExample;
import service.FlightService;
import system.Page;

@Service
public class FlightServiceImpl implements FlightService {
	@Autowired
	FlightMapper flightmapper;
	
	@Override
	public List<Flight> findAllFlight(Page page) {
		FlightExample flightExample= new FlightExample();
		flightExample.setOffset(page.getStart());
		flightExample.setLimit(page.getCount());
		List<Flight> allFlight=flightmapper.selectByExample(flightExample);
		return allFlight;
	}

	@Override
	public boolean addFlight(Flight flight) {
		if(flight!=null && flightmapper.insertSelective(flight)>0) {
			
			return true;
		}
		return false;
	}

	@Override
	public int total() {
		FlightExample flightExample= new FlightExample();
		return (int) flightmapper.countByExample(flightExample);
	}

	@Override
	public List<Flight> findAllFlight(String departurePlace, String arrivalPlace,String departureTime,Page page) {
		
		return flightmapper.selectByDate(departurePlace, arrivalPlace, departureTime);
	}

	@Override
	public boolean updateFlight(Flight flight) {
		
		if(flightmapper.updateByPrimaryKeySelective(flight)>0) {
			return true;
		}
		return false;
	}

	@Override
	public Flight findFlight(Integer fId) {
		
		return flightmapper.selectByPrimaryKey(fId);
	}

}
