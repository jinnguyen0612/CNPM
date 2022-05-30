package com.GymManager.Controller;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.GymManager.Entity.CustomerEntity;
import com.GymManager.Entity.RegisterEntity;

@Controller
@RequestMapping("admin/contract-registration")
@Transactional
public class ContractRegistrationController extends MethodAdminController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model) {
		model.addAttribute("registerList", getAllRegister());
		return "admin/contract-registration";
	}

	// detail
	@RequestMapping(value = "/detail/{id}.htm", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("id") String id) {

		model.addAttribute("idModal", "modal-detail");
		model.addAttribute("registerList", getAllRegister());
		model.addAttribute("registerDetail", getRegister(id));
		return "admin/contract-registration";

	}

	public List<RegisterEntity> getAllRegister() {
		Session session = factory.getCurrentSession();
		String hql = "FROM RegisterEntity";
		Query query = session.createQuery(hql);
		return query.list();
	}

	public RegisterEntity getRegister(String id) {
		Session session = factory.getCurrentSession();
		return (RegisterEntity) session.get(RegisterEntity.class, id);
	}
}
