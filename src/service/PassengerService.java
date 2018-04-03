package service;

import pojo.Passenger;

public interface PassengerService {
	//1.根据手机号码返回Passenger，登录页
	public Passenger findPassengerByPhone(Integer phone,String password);
	//2.根据手机号码返回Passenger，注册用，，，怎么提高复用
	public Passenger findPassengerByPhone(Integer phone);
	//3.向数据库插入一个passenger对象
	public boolean addPassenger(Passenger passenger);
	//4.向数据库更新一个passenger对象
	public boolean updatePassenger(Passenger passenger);
	
}
