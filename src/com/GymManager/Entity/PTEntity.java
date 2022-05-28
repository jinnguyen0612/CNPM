package com.GymManager.Entity;

import java.util.*;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="PT")
public class PTEntity {	
	@Id
	@Column(name = "MaPT")
	private String ptID;
	
	@Column(name = "HoTen")
	private String ptName;
	
	@Column(name = "Phai")
	private int gender;
	
	@Column(name = "CMND")
	private String identityCard;
	
	@Column(name = "DiaChi")
	private String address;
	
	@Column(name = "Email")
	private String email;
	
	@Column(name = "NgaySinh")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;
	
	@Column(name = "SDT")
	private String phoneNumber;
	
	@Column(name = "TrangThai")
	private int status;
	
	@OneToMany(mappedBy ="ptEntity", fetch = FetchType.EAGER)
	private Collection<ClassEntity> classEntity;

	public Collection<ClassEntity> getClassEntity() {
		return classEntity;
	}


	public void setClassEntity(Collection<ClassEntity> classEntity) {
		this.classEntity = classEntity;
	}


	public PTEntity(Collection<ClassEntity> classEntities) {
		super();
	}


	public String getPtID() {
		return ptID;
	}

	public void setPtID(String ptID) {
		this.ptID = ptID;
	}

	public String getPtName() {
		return ptName;
	}

	public void setPtName(String ptName) {
		this.ptName = ptName;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public String getIdentityCard() {
		return identityCard;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}


	

	public PTEntity(String ptID, String ptName, int gender, String identityCard, String address, String email,
			Date birthday, String phoneNumber, int status, Collection<ClassEntity> classEntity) {
		super();
		this.ptID = ptID;
		this.ptName = ptName;
		this.gender = gender;
		this.identityCard = identityCard;
		this.address = address;
		this.email = email;
		this.birthday = birthday;
		this.phoneNumber = phoneNumber;
		this.status = status;
		this.classEntity = classEntity;
	}


	public PTEntity() {
		super();
	}


	
	
}
