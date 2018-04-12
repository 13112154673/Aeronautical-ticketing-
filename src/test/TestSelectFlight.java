package test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import mapper.FlightMapper;
import pojo.Flight;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestSelectFlight {
	@Autowired
	FlightMapper flightMapper;
	@Test
	public void selectFlightByDate(){
		/*System.out.println("OK");
		List<Flight> list=flightMapper.selectByDate("2018-04-03");
		
		System.out.println(list.get(0).getDepartureTime());*/
		
	}
}
