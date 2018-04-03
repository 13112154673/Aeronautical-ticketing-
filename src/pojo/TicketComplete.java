package pojo;


/*
 * 这是一个为了方便向前台传完整机票信息而自制的类
 */
public class TicketComplete {
	private Integer tId;
	private Integer state;
	private String reason;


	private Passenger passenger;
	private Flight flight;
	private Aircraft aircraft;
	
	public TicketComplete(Integer tId,Integer state,String reason,Passenger passenger,Flight flight,Aircraft aircraft) {
		this.tId=tId;
		this.state=state;
		this.reason=reason;
		this.passenger=passenger;
		this.flight=flight;
		this.aircraft=aircraft;
	}
	
	public String getReason() {
		return reason;
	}
	
	public void setReason(String reason) {
		this.reason = reason;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
	public Integer gettId() {
		return tId;
	}

	public void settId(Integer tId) {
		this.tId = tId;
	}

	public Passenger getPassenger() {
		return passenger;
	}

	public void setPassenger(Passenger passenger) {
		this.passenger = passenger;
	}

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

	public Aircraft getAircraft() {
		return aircraft;
	}

	public void setAircraft(Aircraft aircraft) {
		this.aircraft = aircraft;
	}
	// 太繁琐了，换类的形式尝试
	/*
	 * private Integer tId; private Integer phone; private String pName; private
	 * String sex; private Integer fId; private String aId; private String company;
	 * private Date departureTime; private Date arrivalTime; private String
	 * departurePlace; private String arrivalPlace; private Integer fristclassPrice;
	 * private Integer economyCount; private Integer economyPrice; private Integer
	 * fristclassCount;
	 * 
	 * public Integer gettId() { return tId; }
	 * 
	 * public void settId(Integer tId) { this.tId = tId; }
	 * 
	 * public Integer getPhone() { return phone; }
	 * 
	 * public void setPhone(Integer phone) { this.phone = phone; }
	 * 
	 * public String getpName() { return pName; }
	 * 
	 * public void setpName(String pName) { this.pName = pName; }
	 * 
	 * public String getSex() { return sex; }
	 * 
	 * public void setSex(String sex) { this.sex = sex; }
	 * 
	 * public Integer getfId() { return fId; }
	 * 
	 * public void setfId(Integer fId) { this.fId = fId; }
	 * 
	 * public String getaId() { return aId; }
	 * 
	 * public void setaId(String aId) { this.aId = aId; }
	 * 
	 * public String getCompany() { return company; }
	 * 
	 * public void setCompany(String company) { this.company = company; }
	 * 
	 * public Date getDepartureTime() { return departureTime; }
	 * 
	 * public void setDepartureTime(Date departureTime) { this.departureTime =
	 * departureTime; }
	 * 
	 * public Date getArrivalTime() { return arrivalTime; }
	 * 
	 * public void setArrivalTime(Date arrivalTime) { this.arrivalTime =
	 * arrivalTime; }
	 * 
	 * public String getDeparturePlace() { return departurePlace; }
	 * 
	 * public void setDeparturePlace(String departurePlace) { this.departurePlace =
	 * departurePlace; }
	 * 
	 * public String getArrivalPlace() { return arrivalPlace; }
	 * 
	 * public void setArrivalPlace(String arrivalPlace) { this.arrivalPlace =
	 * arrivalPlace; }
	 * 
	 * public Integer getFristclassPrice() { return fristclassPrice; }
	 * 
	 * public void setFristclassPrice(Integer fristclassPrice) {
	 * this.fristclassPrice = fristclassPrice; }
	 * 
	 * public Integer getEconomyCount() { return economyCount; }
	 * 
	 * public void setEconomyCount(Integer economyCount) { this.economyCount =
	 * economyCount; }
	 * 
	 * public Integer getEconomyPrice() { return economyPrice; }
	 * 
	 * public void setEconomyPrice(Integer economyPrice) { this.economyPrice =
	 * economyPrice; }
	 * 
	 * public Integer getFristclassCount() { return fristclassCount; }
	 * 
	 * public void setFristclassCount(Integer fristclassCount) {
	 * this.fristclassCount = fristclassCount; }
	 */
}
