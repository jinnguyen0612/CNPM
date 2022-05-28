package com.GymManager.Service;

import java.util.List;

import com.GymManager.Entity.PTEntity;

public interface PTService {
	public List<PTEntity> getAllPT(Integer offset, Integer maxResult);
	public PTEntity getPTById(String ID);
}
