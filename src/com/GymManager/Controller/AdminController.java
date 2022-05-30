package com.GymManager.Controller;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.GymManager.Entity.CustomerEntity;

@Controller
@RequestMapping("admin")
@Transactional
public class AdminController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = "index")
	public String index(ModelMap model) {
		
		return "admin/index";
	}

	

}
