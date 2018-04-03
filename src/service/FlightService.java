package service;

import java.util.List;

import pojo.Flight;
import system.Page;

public interface FlightService {
	//0.获取总数
	public int total();
	//1.输出所有航班
	public List<Flight> findAllFlight(Page page);
	//2.增加航班
	public boolean addFlight(Flight flight);
}
