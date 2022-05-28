package com.GymManager.Service;

import javax.transaction.SystemException;

import com.GymManager.Entity.AccountEntity;

public interface RegisterService {
	public boolean insertAccount(AccountEntity accountEntity) throws IllegalStateException, SystemException;
}
