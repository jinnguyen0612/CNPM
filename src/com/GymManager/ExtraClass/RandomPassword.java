package com.GymManager.ExtraClass;

public class RandomPassword {
	private String password;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public RandomPassword() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RandomPassword(int leghtPass) {
		super();
		String password = "";
		for (int j = 0; j < leghtPass; j++) {
			password += randomCharacter();

		}
		this.password = password;
	}

	public static char randomCharacter() {

		int rand = (int) (Math.random() * 62);

		if (rand <= 9) {

			int number = rand + 48;

			return (char) (number);
		} else if (rand <= 35) {

			int uppercase = rand + 55;

			return (char) (uppercase);
		} else {

			int lowercase = rand + 61;

			return (char) (lowercase);
		}
	}

}
