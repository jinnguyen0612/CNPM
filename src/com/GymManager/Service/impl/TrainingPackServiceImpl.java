package com.GymManager.Service.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.GymManager.Entity.TrainingPackEntity;
import com.GymManager.Entity.TrainingPackTypeEntity;
import com.GymManager.Service.TrainingPackService;
@Service
public class TrainingPackServiceImpl implements TrainingPackService{
	@Autowired
	SessionFactory factory;
	@Override
	public List<TrainingPackEntity> getAllPack(Integer offset, Integer maxResult) {
		Session session = factory.openSession();
		try 
		{
			String hql = "From TrainingPackEntity";
			Query query = session.createQuery(hql);
			query.setFirstResult((offset != null) ? offset : 0);
			List<TrainingPackEntity> result = query.list();
			if (result != null)
                return result;
		}
		catch (Exception e) {
			System.out.println("Lỗi : " + e);
		}
		return null;
	}

	@Override
	public boolean insertPack(TrainingPackEntity trainingPackEntity) {
		Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        try {
            session.save(trainingPackEntity);
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
	public boolean updatePack(TrainingPackEntity trainingPackEntity) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(trainingPackEntity);
			t.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			t.rollback();
		}
		return false;
	}

	@Override
	public TrainingPackEntity getPackByPackId(String packID) {
		Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        try {
            TrainingPackEntity trainingPackEntity = (TrainingPackEntity) session.get(TrainingPackEntity.class, packID);
            return trainingPackEntity;
        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
	}

}
