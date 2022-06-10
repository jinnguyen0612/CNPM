package com.GymManager.Controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.commons.codec.digest.DigestUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.GymManager.Entity.AccountEntity;
import com.GymManager.Entity.ClassEntity;
import com.GymManager.Entity.RegisterEntity;
import com.GymManager.Entity.ScheduleEntity;
import com.GymManager.Entity.TrainingPackEntity;
import com.GymManager.ExtraClass.GymLimit;

@Transactional
public class MethodAdminController {
	@Autowired
	SessionFactory factory;

	public String toPK(String refix, String table, String columnPK) {
		Session session = factory.getCurrentSession();
		String hql = "FROM " + table;
		Query query = session.createQuery(hql);
		int number = query.list().size() + 1;
		boolean isInValid = true;
		String pk = refix;
		DecimalFormat df = new DecimalFormat("000000");
		while (isInValid) {
			String pkTemp = pk + df.format(number);
			String hqlwhere = hql + " WHERE " + columnPK + " = '" + pkTemp + "'";
			query = session.createQuery(hqlwhere);
			if (query.list().size() > 0)
				number++;
			else {
				pk = pkTemp;
				isInValid = false;
			}
		}

		return pk;
	}

	public String toHqlRangeCondition(String beginRange, String endRange, String columnName) {
		String hql = columnName;
		if (!beginRange.isEmpty()) {
			if (endRange.isEmpty()) {
				hql += " = '" + beginRange + "'";
			} else
				hql = " (" + hql + " BETWEEN '" + beginRange + "' AND '" + endRange + "'" + ") ";
		} else {
			if (!endRange.isEmpty()) {
				hql += " <= '" + endRange + "'";
			} else
				hql = "";
		}
		return hql;
	};

	public String toHqlWhereClause(List<String> list) {
		String whereClauses = list.get(0);
		for (int i = 0; i < list.size() - 1; i++) {
			if (!list.get(i + 1).isEmpty())
				if (!whereClauses.isEmpty())
					whereClauses += " AND " + list.get(i + 1);
				else
					whereClauses += list.get(i + 1);

		}
		if (!whereClauses.isEmpty())
			whereClauses = "WHERE " + whereClauses;

		return whereClauses;
	}

	public String toHqlSingleColumAnd(String columName, String[] list) {
		String hql = columName + " = '" + list[0] + "'";
		for (int i = 1; i < list.length; i++) {

			hql += " AND " + columName + " = '" + list[i] + "'";

		}
		return hql;
	}

	public String toHqlSingleColumOr(String columName, String[] list) {
		String hql = " (" + columName + " = '" + list[0] + "'";
		for (int i = 1; i < list.length; i++) {

			hql += " OR " + columName + " = '" + list[i] + "'";

		}
		hql += " )";
		return hql;
	}

	public AccountEntity getAccount(String username) {
		Session session = factory.getCurrentSession();
		return (AccountEntity) session.get(AccountEntity.class, username);
	}

	public String hashPass(String matKhau) {
		String hashpw = DigestUtils.md5Hex(matKhau).toUpperCase();
		return hashpw;
	}

	public boolean checkDuplicateShedule(List<ScheduleEntity> list1, List<ScheduleEntity> list2) {

		for (ScheduleEntity scheduleEntity : list1) {
			for (ScheduleEntity scheduleEntity2 : list2) {
				if (scheduleEntity.getDay() == scheduleEntity2.getDay()
						&& scheduleEntity.getSession() == scheduleEntity2.getSession()) {
					return true; // trung
				}
			}
		}
		return false; // khong trung
	}

	public boolean checkExceedAtTime(ScheduleEntity scheduleEntity) {
		int num = 0;

		for (ClassEntity classEntity : getAllClass()) {

			for (ScheduleEntity scheduleEntity1 : classEntity.getScheduleEntity()) {

				if (scheduleEntity.getDay() == scheduleEntity1.getDay()
						&& scheduleEntity.getSession() == scheduleEntity1.getSession()) {
					num += 1;
				}

			}

		}

		if (num == new GymLimit().getMaxAtTime()) {
			return true;
		}

		System.out.println(num);

		return false;
	}

	public List<ClassEntity> getAllClass() {
		Session session = factory.getCurrentSession();
		String hql = "FROM ClassEntity where maxPP > 1";
		Query query = session.createQuery(hql);
		List<ClassEntity> list = query.list();
		List<ClassEntity> newList = new ArrayList<ClassEntity>();
		for (ClassEntity classEntity : list) {
			if (classEntity.getClassPeriod() != 2) {
				newList.add(classEntity);
			}

		}
		return newList;
	}

}
