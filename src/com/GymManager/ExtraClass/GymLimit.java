package com.GymManager.ExtraClass;

public class GymLimit {
	public int expiredRegister;
	public int maxAtTime;

	public int getExpiredRegister() {
		return expiredRegister;
	}

	public void setExpiredRegister(int expiredRegister) {
		this.expiredRegister = expiredRegister;
	}

	public int getMaxAtTime() {
		return maxAtTime;
	}

	public void setMaxAtTime(int maxAtTime) {
		this.maxAtTime = maxAtTime;
	}

	public GymLimit() {
		super();
		this.setExpiredRegister(7);
		this.setMaxAtTime(80);
		// TODO Auto-generated constructor stub
	}

}
