package com.GymManager.Entity;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "LOAIGOI")
public class TrainingPackTypeEntity {
	@Id
	@Column(name = "MaLoai")
	private String packTypeID;
	
	@Column(name = "TenLoai")
	private String packTypeName;
	
	@Column(name = "MoTa")
	private String describe;

	public String getPackTypeID() {
		return packTypeID;
	}
	
	@OneToMany(mappedBy = "trainingPackTypeEntity", fetch = FetchType.EAGER)
	private Collection<TrainingPackEntity> trainingPackEntity;

	public void setPackTypeID(String packID) {
		this.packTypeID = packID;
	}

	public String getPackTypeName() {
		return packTypeName;
	}

	public void setPackTypeName(String packName) {
		this.packTypeName = packName;
	}

	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public TrainingPackTypeEntity(String packID, String packName, String describe) {
		super();
		this.packTypeID = packID;
		this.packTypeName = packName;
		this.describe = describe;
	}

	public TrainingPackTypeEntity() {
		super();
	}

	
}
