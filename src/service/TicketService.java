package service;

import java.util.List;

import pojo.Aircraft;
import pojo.Flight;
import pojo.Ticket;

public interface TicketService {
	//1.1根据乘客手机号找到对应ticket
	public List<Ticket> findTicketByPhone(Integer phone);
	//1.2根据机票Id找到对应机票信息
	public Ticket fIndTicketByTid(Integer tId);
	//1.3根据机票ID找到对应ticket并修改其退票备注
	public boolean updateTicketByTid(Integer tId,String reason);
	//2.根据ticket里的航班ID找到对应航班flight
	public Flight findFlightByFid(Integer fid);
	//3.根据ticket里aid找到对应飞机名字
	public Aircraft findAircraftByAid(String aid);
	//4.获取系统里所有的简单机票
	public List<Ticket> findAllTicket();
	//5.删除一张简单机票
	public boolean deleteTicket(Integer tId);
	//4.获取系统里所有的航空飞机
	public List<Aircraft> findAllAircraft();
}
