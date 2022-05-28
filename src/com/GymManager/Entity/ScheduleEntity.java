package com.GymManager.Entity;

import javax.persistence.*;

@Entity
@Table(name = "TKB_LOP")
public class ScheduleEntity {
	@Id
	@GeneratedValue(strategy = javax.persistence.GenerationType.IDENTITY)
	@Column(name = "Ma", unique = true, nullable = false)
	private Integer id;

	@Column(name="MaLop")
	private String classId;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name ="MaLop", insertable = false, updatable= false)
	private ClassEntity classEntity;
	
	
	@Column(name = "Thu")
	private Integer day;
	@Column(name = "Buoi")
	private int session;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ClassEntity getClassEntity() {
		return classEntity;
	}

	public void setClassEntity(ClassEntity classEntity) {
		this.classEntity = classEntity;
	}

	public Integer getDay() {
		return day;
	}

	public void setDay(Integer day) {
		this.day = day;
	}

	public int getSession() {
		return session;
	}

	public void setSession(int session) {
		this.session = session;
	}

	public ScheduleEntity(String classId, ClassEntity classEntity, Integer day, int session) {
		super();
		this.classId = classId;
		this.classEntity = classEntity;
		this.day = day;
		this.session = session;
	}

	public ScheduleEntity() {
		super();
	}
	
	

	


	
}
