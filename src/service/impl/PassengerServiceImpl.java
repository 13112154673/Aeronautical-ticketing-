package service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.PassengerMapper;
import pojo.Passenger;
import service.PassengerService;

@Service
public class PassengerServiceImpl implements PassengerService {
	@Autowired
	PassengerMapper passengerMapper;
	
	@Override
	public Passenger findPassengerByPhone(Integer phone,String password) {
		if(phone!=null) {
			Passenger passenger=passengerMapper.selectByPrimaryKey(phone);
			if(passenger!=null&&passenger.getPassword().equals(password)) {
				return passenger;
			}
		}
		return null;
	}
	
	@Override
	public Passenger findPassengerByPhone(Integer phone) {
		if(phone!=null) {
			Passenger passenger=passengerMapper.selectByPrimaryKey(phone);
			if(passenger!=null) {
				return passenger;
			}
		}
		return null;
	}
	
	@Override
	public boolean addPassenger(Passenger passenger) {
		if(passengerMapper.insertSelective(passenger)>0) {
			return true;
		}
		return false;
	}
	
	public boolean updatePassenger(Passenger passenger) {
		if(passengerMapper.updateByPrimaryKeySelective(passenger)>0) {
			return true;
		}
		return false;
	}
}
