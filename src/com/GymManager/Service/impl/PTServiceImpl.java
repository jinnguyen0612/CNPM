package com.GymManager.Service.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.GymManager.Entity.PTEntity;
import com.GymManager.Service.PTService;
@Service
public class PTServiceImpl implements PTService{
	@Autowired
	SessionFactory factory;
	@Override
	public PTEntity getPTById(String ID) {
		Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        try {
            PTEntity ptEntity = (PTEntity) session.get(PTEntity.class, ID);
            return ptEntity;
        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
	}
	@Override
	public List<PTEntity> getAllPT(Integer offset, Integer maxResult) {
		Session session = factory.openSession();
		try 
		{
			String hql = "From PTEntity";
			Query query = session.createQuery(hql);
			query.setFirstResult((offset != null) ? offset : 0);
			List<PTEntity> result = query.list();
			if (result != null)
                return result;
		}
		catch (Exception e) {
			System.out.println("Lỗi : " + e);
		}
		return null;
	}

}
