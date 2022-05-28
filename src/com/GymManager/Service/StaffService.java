package com.GymManager.Service;

import java.util.List;

import com.GymManager.Controller.EmployeeController;
import com.GymManager.Entity.StaffEntity;


public interface StaffService {
	public List<StaffEntity> getAllStaff(Integer offset, Integer maxResult);
	public boolean insertStaff(StaffEntity StaffEntity);
	public boolean updateStaff(StaffEntity StaffEntity);
}

