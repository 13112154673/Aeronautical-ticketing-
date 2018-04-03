package pojo;



public class FlightComplete {
	private Flight flight;
	private Aircraft aircraft;
	
	public FlightComplete(Flight flight,Aircraft aircraft) {
		this.setFlight(flight);
		this.setAircraft(aircraft);
	}

	public Aircraft getAircraft() {
		return aircraft;
	}

	public void setAircraft(Aircraft aircraft) {
		this.aircraft = aircraft;
	}

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}
}
