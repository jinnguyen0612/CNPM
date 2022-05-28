package com.GymManager.Service;

import java.util.List;

import com.GymManager.Controller.ClassController;
import com.GymManager.Entity.ClassEntity;

public interface ClassService {
	public List<ClassEntity> getAllClass(Integer offset, Integer maxResult);
	public boolean insertClass(ClassEntity classEntity);
	public boolean updateClass(ClassEntity classEntity);
}
