package com.GymManager.Service;

import java.util.List;

import com.GymManager.Entity.TrainingPackTypeEntity;

public interface TrainingPackTypeService {
	public List<TrainingPackTypeEntity> getAllPackType(Integer offset, Integer maxResult);
	public boolean insertPackType(TrainingPackTypeEntity trainingPackTypeEntity);
	public boolean updatePackType(TrainingPackTypeEntity trainingPackTypeEntity);
	public TrainingPackTypeEntity getPackByID(String packTypeID);
}
