package service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.StaffMapper;
import pojo.Staff;
import service.StaffService;
@Service
public class StaffServiceImpl implements StaffService {
	@Autowired
	StaffMapper staffMapper;
	@Override
	public Staff findStaffById(Integer sId,String password) {
		if(sId!=null) {
			Staff staff=staffMapper.selectByPrimaryKey(sId);
			if(staff!=null&&staff.getPassword().equals(password)) {
				return staff;
			}
		}
		return null;
	}

}
