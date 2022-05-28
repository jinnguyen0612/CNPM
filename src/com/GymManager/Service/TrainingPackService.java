package com.GymManager.Service;

import java.util.List;

import com.GymManager.Entity.TrainingPackEntity;
import com.GymManager.Entity.TrainingPackTypeEntity;

public interface TrainingPackService {
	public List<TrainingPackEntity> getAllPack(Integer offset, Integer maxResult);
	public boolean insertPack(TrainingPackEntity trainingPackEntity);
	public boolean updatePack(TrainingPackEntity trainingPackEntity);
	public TrainingPackEntity getPackByPackId(String packID);
}
