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
	//1.4根据机票ID找到对应ticket并添加新航班
	public boolean updateTicketByTid(Integer tId,Integer newFId);
	//1.5根据机票ID找到对应ticket并将原航班更改为新航班，置空新航班
	public boolean updateTicketByTid(Integer tId);
	//1.6根据机票ID找到对应ticket,当isoppose为true时未反对改签，置机票状态为4，为false时表示时乘客撤回动作，将机票状态置为1
	public boolean updateTicketByTid(Integer tId,boolean isoppose);
	//2.根据ticket里的航班ID找到对应航班flight
	public Flight findFlightByFid(Integer fid);
	//3.根据ticket里aid找到对应飞机名字
	public Aircraft findAircraftByAid(String aid);
	//4.获取系统里所有的简单机票
	public List<Ticket> findAllTicket();
	//5.删除一张简单机票
	public boolean deleteTicket(Integer tId);
	//6.获取系统里所有的航空飞机
	public List<Aircraft> findAllAircraft();
	//7.向数据库新插入一个ticket
	public Boolean insertTicket(Ticket ticket);
}
