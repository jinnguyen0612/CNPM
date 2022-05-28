package com.GymManager.Service.impl;

import javax.transaction.SystemException;
import javax.transaction.Transaction;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.GymManager.Entity.AccountEntity;
import com.GymManager.Service.RegisterService;

@Service
public class RegisterServiceImpl implements RegisterService{
	@Autowired
	SessionFactory factory;
	@Override
	public boolean insertAccount(AccountEntity accountEntity) throws IllegalStateException, SystemException {
		Session session = factory.openSession();
		Transaction t = (Transaction) session.beginTransaction();
		try 
		{
			session.save(accountEntity);
			t.commit();
			return true;
		}
		catch(Exception e)
		{
			t.rollback();
		}
		finally {
			session.close();
		}
		return false;
	}

}
