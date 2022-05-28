package com.GymManager.Entity;

import java.util.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "LOP")
public class ClassEntity {
	@Id
	@Column(name = "MaLop")
	private String classId;
	
	@Column(name = "NgayMoDK")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dateOpen;
	
	@Column(name = "NgayDongDK")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dateClose;
	
	@Column(name = "NgayBatDauLop")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dateStart;
	
	@Column(name = "SoLuongNguoiToiDa")
	private int maxPP;
	
	// join to column
	@Column(name = "PT", insertable = false, updatable= false)
	private String PT;
	

	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "PT")
	private PTEntity ptEntity;

	
	@Column(name = "MaGoi", insertable = false, updatable= false)
	private String packId;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name ="MaGoi")
	private TrainingPackEntity trainingPackEntity;
	
	@OneToMany(mappedBy ="classEntity", fetch = FetchType.EAGER)
	private Collection<ScheduleEntity> scheduleEntity;
	

	public TrainingPackEntity getTrainingPackEntity() {
		return trainingPackEntity;
	}

	public void setTrainingPackEntity(TrainingPackEntity trainingPackEntity) {
		this.trainingPackEntity = trainingPackEntity;
	}

	public String getClassId() {
		return classId;
	}

	public void setClassId(String classId) {
		this.classId = classId;
	}

	public Date getDateOpen() {
		return dateOpen;
	}

	public void setDateOpen(Date dateOpen) {
		this.dateOpen = dateOpen;
	}

	public Date getDateClose() {
		return dateClose;
	}

	public void setDateClose(Date dateClose) {
		this.dateClose = dateClose;
	}

	public Date getDateStart() {
		return dateStart;
	}

	public void setDateStart(Date dateStart) {
		this.dateStart = dateStart;
	}

	public int getMaxPP() {
		return maxPP;
	}

	public void setMaxPP(int maxPP) {
		this.maxPP = maxPP;
	}



	public String getPackId() {
		return packId;
	}

	public void setPackId(String packId) {
		this.packId = packId;
	}





	public String getPT() {
		return PT;
	}

	public void setPT(String pT) {
		PT = pT;
	}

	public PTEntity getPtEntity() {
		return ptEntity;
	}

	public void setPtEntity(PTEntity ptEntity) {
		this.ptEntity = ptEntity;
	}

	public ClassEntity(String classId, Date dateOpen, Date dateClose, Date dateStart, int maxPP, String pT,
			PTEntity ptEntity, String packId, TrainingPackEntity trainingPackEntity) {
		super();
		this.classId = classId;
		this.dateOpen = dateOpen;
		this.dateClose = dateClose;
		this.dateStart = dateStart;
		this.maxPP = maxPP;
		PT = pT;
		this.ptEntity = ptEntity;
		this.packId = packId;
		this.trainingPackEntity = trainingPackEntity;
	}

	public ClassEntity() {
		super();
	}

}
