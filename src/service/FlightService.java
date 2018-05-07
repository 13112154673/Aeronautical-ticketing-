package service;

import java.util.List;

import pojo.Flight;
import system.Page;

public interface FlightService {
	//0.获取总数
	public int total();
	//1.输出所有航班,带页码
	public List<Flight> findAllFlight(Page page);
	//2.输出所有航班，根据出发地和目的地还有出发日期检索
	public List<Flight> findAllFlight(String departurePlace,String arrivalPlace,String departureTime,Page page);
	//3.增加航班
	public boolean addFlight(Flight flight);
	//4.航班座位变化，
	public Flight findFlight(Integer fId);
	//5.航班座位变化，
	public boolean updateFlight(Flight flight);
}
