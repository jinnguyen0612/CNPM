package com.GymManager.ExtraClass;

public class FormAttribute {
	private String formTitle;
	private String formAction;
	private String btnAction;

	public String getFormTitle() {
		return formTitle;
	}

	public void setFormTitle(String formTitle) {
		this.formTitle = formTitle;
	}

	public String getFormAction() {
		return formAction;
	}

	public void setFormAction(String formAction) {
		this.formAction = formAction;
	}

	public String getBtnAction() {
		return btnAction;
	}

	public void setBtnAction(String btnAction) {
		this.btnAction = btnAction;
	}

	public FormAttribute() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FormAttribute(String formTitle, String formAction, String btnAction) {
		super();
		this.formTitle = formTitle;
		this.formAction = formAction;
		this.btnAction = btnAction;
	}

}
