package com.GymManager.Entity;

import java.time.LocalDate;
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
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
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
	@Column(name = "PT", insertable = false, updatable = false)
	private String PT;

	@ManyToOne
	@JoinColumn(name = "PT")
	private PTEntity ptEntity;

	@Column(name = "MaGoi", insertable = false, updatable = false)
	private String packId;

	@ManyToOne
	@JoinColumn(name = "MaGoi")
	private TrainingPackEntity trainingPackEntity;

	@OneToMany(mappedBy = "classEntity", fetch = FetchType.EAGER)
	private Collection<ScheduleEntity> scheduleEntity;

	@OneToMany(mappedBy = "classEntity")
	@LazyCollection(LazyCollectionOption.FALSE)
	private Collection<RegisterDetailEntity> registerDetailEntities;

	public Collection<ScheduleEntity> getScheduleEntity() {
		return scheduleEntity;
	}

	public void setScheduleEntity(Collection<ScheduleEntity> scheduleEntity) {
		this.scheduleEntity = scheduleEntity;
	}

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

	public Collection<RegisterDetailEntity> getRegisterDetailEntities() {
		return registerDetailEntities;
	}

	public void setRegisterDetailEntities(Collection<RegisterDetailEntity> registerDetailEntities) {
		this.registerDetailEntities = registerDetailEntities;
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

	public Date getDateEnd() {
		LocalDate localDateStart = LocalDate.parse(this.getDateStart().toString());
		LocalDate localDateEnd = localDateStart.plusMonths(this.getTrainingPackEntity().getPackDuration());
		return java.sql.Date.valueOf(localDateEnd);
	}

	public int getClassStatus() {
		RegisterDetailEntity[] registerDetailEntities = this.getRegisterDetailEntities()
				.toArray(RegisterDetailEntity[]::new);
		if (this.getRegisterDetailEntitiesAvailable().size() == this.maxPP) {
			return 2; // đã đạt số người đăng ký tối đa;
		}
		if (this.maxPP > 1) {
			Date toDay = new Date();
			if (toDay.after(this.dateOpen) && toDay.before(this.dateClose)) {
				return 1;// có thế đăng ký;
			}
		}
		return 0; // hết hạn dk;
	}

	public int getClassPeriod() {
		Date today = new Date();
		if (today.after(this.dateStart) && today.before(this.getDateEnd())) {
			return 1; // đang dạy;
		} else if (today.after(this.getDateEnd()))
			return 2; // kết thúc
		return 0; // chưa bắt đầu;
	}

	public List<RegisterDetailEntity> getRegisterDetailEntitiesAvailable() {
		List<RegisterDetailEntity> list = new ArrayList<RegisterDetailEntity>();
		for (RegisterDetailEntity registerDetailEntity : this.getRegisterDetailEntities()) {
			if (registerDetailEntity.getRegisterEntity().getStatus() != 2) {
				list.add(registerDetailEntity);
			}
		}
		return list;
	}

}
