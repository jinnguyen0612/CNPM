package com.GymManager.Service.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.GymManager.Controller.ClassController;
import com.GymManager.Entity.ClassEntity;
import com.GymManager.Entity.TrainingPackEntity;
import com.GymManager.Service.ClassService;
@Service
public class ClassServiceImpl implements ClassService{

	@Autowired
	SessionFactory factory;
	@Override
	public List<ClassEntity> getAllClass(Integer offset, Integer maxResult) {
		Session session = factory.openSession();
		try 
		{
			String hql = "From ClassEntity";
			Query query = session.createQuery(hql);
			query.setFirstResult((offset != null) ? offset : 0);
			List<ClassEntity> result = query.list();
			if (result != null)
                return result;
		}
		catch (Exception e) {
			System.out.println("Lỗi diiiii : " + e);
		}
		return null;
	}
	@Override
	public boolean insertClass(ClassEntity classEntity) {
		Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        try {
            session.save(classEntity);
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
	public boolean updateClass(ClassEntity classEntity) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(classEntity);
			t.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			t.rollback();
		}
		return false;
	}

}
