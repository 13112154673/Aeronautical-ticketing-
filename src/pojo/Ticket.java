package pojo;

public class Ticket {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column ticket.t_id
     *
     * @mbg.generated
     */
    private Integer tId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column ticket.phone
     *
     * @mbg.generated
     */
    private Integer phone;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column ticket.f_id
     *
     * @mbg.generated
     */
    private Integer fId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column ticket.state
     *
     * @mbg.generated
     */
    private Integer state;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column ticket.reason
     *
     * @mbg.generated
     */
    private String reason;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column ticket.newf_id
     *
     * @mbg.generated
     */
    private Integer newfId;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column ticket.t_id
     *
     * @return the value of ticket.t_id
     *
     * @mbg.generated
     */
    public Integer gettId() {
        return tId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column ticket.t_id
     *
     * @param tId the value for ticket.t_id
     *
     * @mbg.generated
     */
    public void settId(Integer tId) {
        this.tId = tId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column ticket.phone
     *
     * @return the value of ticket.phone
     *
     * @mbg.generated
     */
    public Integer getPhone() {
        return phone;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column ticket.phone
     *
     * @param phone the value for ticket.phone
     *
     * @mbg.generated
     */
    public void setPhone(Integer phone) {
        this.phone = phone;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column ticket.f_id
     *
     * @return the value of ticket.f_id
     *
     * @mbg.generated
     */
    public Integer getfId() {
        return fId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column ticket.f_id
     *
     * @param fId the value for ticket.f_id
     *
     * @mbg.generated
     */
    public void setfId(Integer fId) {
        this.fId = fId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column ticket.state
     *
     * @return the value of ticket.state
     *
     * @mbg.generated
     */
    public Integer getState() {
        return state;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column ticket.state
     *
     * @param state the value for ticket.state
     *
     * @mbg.generated
     */
    public void setState(Integer state) {
        this.state = state;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column ticket.reason
     *
     * @return the value of ticket.reason
     *
     * @mbg.generated
     */
    public String getReason() {
        return reason;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column ticket.reason
     *
     * @param reason the value for ticket.reason
     *
     * @mbg.generated
     */
    public void setReason(String reason) {
        this.reason = reason == null ? null : reason.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column ticket.newf_id
     *
     * @return the value of ticket.newf_id
     *
     * @mbg.generated
     */
    public Integer getNewfId() {
        return newfId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column ticket.newf_id
     *
     * @param newfId the value for ticket.newf_id
     *
     * @mbg.generated
     */
    public void setNewfId(Integer newfId) {
        this.newfId = newfId;
    }
}