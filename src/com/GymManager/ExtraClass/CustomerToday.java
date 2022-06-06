package com.GymManager.ExtraClass;

import com.GymManager.Entity.ClassEntity;
import com.GymManager.Entity.CustomerEntity;
import com.GymManager.Entity.ScheduleEntity;

public class CustomerToday {
	private CustomerEntity customer;
	private ScheduleEntity schedule;
	private ClassEntity classEntity;

	public CustomerEntity getCustomer() {
		return customer;
	}

	public void setCustomer(CustomerEntity customer) {
		this.customer = customer;
	}

	public ScheduleEntity getSchedule() {
		return schedule;
	}

	public void setSchedule(ScheduleEntity schedule) {
		this.schedule = schedule;
	}

	public ClassEntity getClassEntity() {
		return classEntity;
	}

	public void setClassEntity(ClassEntity classEntity) {
		this.classEntity = classEntity;
	}

	public CustomerToday() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CustomerToday(CustomerEntity customer, ScheduleEntity schedule, ClassEntity classEntity) {
		super();
		this.customer = customer;
		this.schedule = schedule;
		this.classEntity = classEntity;
	}

}
