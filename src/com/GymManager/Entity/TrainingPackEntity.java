package com.GymManager.Entity;

import java.util.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "GOITAP")
public class TrainingPackEntity {
	@Id
	@Column(name = "MaGoi")
	private String packID;

	@Column(name = "TenGoi")
	private String packName;

	@Column(name = "ThoiHanGoi")
	private int packDuration;

	@Column(name = "TrangThai")
	private String status;

	@Column(name = "LoaiGoi", insertable = false, updatable = false)
	private String packTypeID;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "LoaiGoi")
	private TrainingPackTypeEntity trainingPackTypeEntity;

	@Column(name = "GiaTien")
	private float money;

	@OneToMany(mappedBy = "trainingPackEntity")
	@LazyCollection(LazyCollectionOption.FALSE)
	private Collection<ClassEntity> classList;

	public Collection<ClassEntity> getClassList() {
		return classList;
	}

	public void setClassList(Collection<ClassEntity> classList) {
		this.classList = classList;
	}

	public String getPackID() {
		return packID;
	}

	public void setPackID(String packID) {
		this.packID = packID;
	}

	public String getPackName() {
		return packName;
	}

	public void setPackName(String packName) {
		this.packName = packName;
	}

	public int getPackDuration() {
		return packDuration;
	}

	public void setPackDuration(int packDuration) {
		this.packDuration = packDuration;
	}

	public String getPackTypeID() {
		return packTypeID;
	}

	public void setPackTypeID(String packTypeID) {
		this.packTypeID = packTypeID;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public TrainingPackTypeEntity getTrainingPackTypeEntity() {
		return trainingPackTypeEntity;
	}

	public void setTrainingPackTypeEntity(TrainingPackTypeEntity trainingPackTypeEntity) {
		this.trainingPackTypeEntity = trainingPackTypeEntity;
	}

	public float getMoney() {
		return money;
	}

	public void setMoney(float money) {
		this.money = money;
	}

	public TrainingPackEntity(String packID, String packName, int packDuration, String status, String packTypeID,
			TrainingPackTypeEntity trainingPackTypeEntity, float money) {
		super();
		this.packID = packID;
		this.packName = packName;
		this.packDuration = packDuration;
		this.status = status;
		this.packTypeID = packTypeID;
		this.trainingPackTypeEntity = trainingPackTypeEntity;
		this.money = money;
	}

	public TrainingPackEntity() {
		super();
	}

}
