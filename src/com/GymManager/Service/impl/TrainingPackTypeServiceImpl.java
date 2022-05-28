package com.GymManager.Service.impl;

import java.util.List;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.GymManager.Entity.TrainingPackTypeEntity;
import com.GymManager.Service.TrainingPackTypeService;

@Service
public class TrainingPackTypeServiceImpl implements TrainingPackTypeService{
	@Autowired
	SessionFactory factory;
	
	@Override
	public List<TrainingPackTypeEntity> getAllPackType(Integer offset, Integer maxResult) {
		Session session = factory.openSession();
		try 
		{
			String hql = "From TrainingPackTypeEntity";
			Query query = session.createQuery(hql);
			query.setFirstResult((offset != null) ? offset : 0);
			List<TrainingPackTypeEntity> result = query.list();
			if (result != null)
                return result;
		}
		catch (Exception e) {
			System.out.println("Lỗi : " + e);
		}
		return null;
	}

	@Override
	public boolean insertPackType(TrainingPackTypeEntity trainingPackTypeEntity) {
		Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        try {
            session.save(trainingPackTypeEntity);
            t.commit();
            return true;
        } catch (Exception e) {
            t.rollback();
        } finally {
            session.close();
        }
        return false;
	}

	@Override
	public boolean updatePackType(TrainingPackTypeEntity trainingPackTypeEntity) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(trainingPackTypeEntity);
			t.commit();
			return true;
		} catch (Exception e) {
			t.rollback();
		}
		return false;
	}

	@Override
	public TrainingPackTypeEntity getPackByID(String packTypeID) {
		Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        try {
            TrainingPackTypeEntity trainingPackTypeEntity = (TrainingPackTypeEntity) session.get(TrainingPackTypeEntity.class, packTypeID);
            return trainingPackTypeEntity;
        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
	}
	
}
