package service;

import pojo.Staff;

public interface StaffService {
	//1.根据员工号码返回staff，进入后台操作页面
	public Staff findStaffById(Integer sId,String password);
}
