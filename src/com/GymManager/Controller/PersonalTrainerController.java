package com.GymManager.Controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.GymManager.Entity.ClassEntity;
import com.GymManager.Entity.PTEntity;
import com.GymManager.Entity.RegisterDetailEntity;
import com.GymManager.Entity.RegisterEntity;
import com.GymManager.Entity.ScheduleEntity;
import com.GymManager.Entity.PTEntity;
import com.GymManager.Entity.TrainingPackEntity;
import com.GymManager.ExtraClass.Message;

@Controller
@RequestMapping("admin/personal-trainer")
@Transactional
public class PersonalTrainerController extends MethodAdminController {
	@Autowired
	SessionFactory factory;

//	@RequestMapping(value = "", method = RequestMethod.GET)
//	public String index(ModelMap model) {
//		return "admin/personal-trainer";
//	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model) {
		PTEntity pt = newPT();
		model.addAttribute("pt", pt);
		model.addAttribute("ptUpdate", pt);
		model.addAttribute("cList", getAllPT());
		return "admin/personal-trainer";
	}
	
	//detail
		@RequestMapping(value="detail/{id}.htm", method = RequestMethod.GET)
		public String getDetail(ModelMap model, @PathVariable("id") String id) {
			model.addAttribute("pt", newPT());
			model.addAttribute("ptUpdate", newPT());
			model.addAttribute("ptDetail", getPT(id));
			model.addAttribute("idModal", "modal-detail");
			model.addAttribute("cList", getAllPT());
			return "admin/personal-trainer";
			
		}

	// create pt
	@RequestMapping(value="", method = RequestMethod.POST, params = "btnCreate")
	public String createPT(ModelMap model, @Validated @ModelAttribute("pt") PTEntity pt,
			BindingResult result, RedirectAttributes redirectAttributes) {
		System.out.println(pt.getPtID());
		if (!result.hasErrors()) {
			Session session = factory.openSession();

			Transaction t = session.beginTransaction();
			try {

				session.save(pt);

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Them thanh cong!!!"));

				return "redirect:/admin/personal-trainer.htm";

			} catch (Exception e) {

				t.rollback();
				System.out.println(e);
				if (e.getCause().toString().contains("duplicate key")) {
					result.rejectValue("ptID", "pt", "Ma khong duoc trung");
				}
				if (e.getCause().toString().contains("String or binary data would be truncated")) {
					result.rejectValue("ptID", "pt", "Ma khong qua 8 ky tu");
				}
			}

			finally {
				session.close();
			}
		}
		model.addAttribute("idModal", "modal-create");
		model.addAttribute("ptUpdate", pt);
		return "admin/personal-trainer";
	}

	// return views update
	@RequestMapping(value = "update/{id}.htm", method = RequestMethod.GET)
	public String getUpdate(ModelMap model, @PathVariable("id") String id) {

		model.addAttribute("staff", newPT());
		model.addAttribute("ptUpdate", getPT(id));
		model.addAttribute("idModal", "modal-update");
		model.addAttribute("cList", getAllPT());
		return "admin/personal-trainer";
	}

	@RequestMapping(value = "update/{id}.htm", method = RequestMethod.POST, params = "btnUpdate")
	public String updatCustomer(ModelMap model, @Validated @ModelAttribute("ptUpdate") PTEntity pt,
			BindingResult result, RedirectAttributes redirectAttributes, @PathVariable("id") String id) {
		if (!result.hasErrors()) {
			Session session = factory.openSession();

			Transaction t = session.beginTransaction();
			try {

				session.update(pt);

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Them thanh cong !!!"));

				return "redirect:/admin/personal-trainer.htm";

			} catch (Exception e) {

				t.rollback();
				System.out.println(e.getCause());
				if (e.getCause().toString().contains("duplicate key")) {
					result.rejectValue("ptID", "ptUpdate", "Ma da ton tai");
				}
				if (e.getCause().toString().contains("String or binary data would be truncated")) {
					result.rejectValue("ptID", "ptUpdate", "Ma khong duoc qua 8 ky tu");
				}
			}

			finally {
				session.close();
			}
		}
		model.addAttribute("idModal", "modal-update");
		model.addAttribute("pt", newPT());
		model.addAttribute("cList", getAllPT());
		return "admin/personal-trainer";
	}



	// filter

	@RequestMapping(value = "", params = "btnFilter", method = RequestMethod.GET)
	public String saleFilter(@RequestParam Map<String, String> allParams, ModelMap model) {

		Session session = factory.getCurrentSession();

		String whereClause = "";

		String birthday = toHqlRangeCondition(allParams.get("birthdayLeft"), allParams.get("birthdayRight"),
				"birthday");

		String gender = allParams.get("gender");
		if (gender.equals("1") || gender.equals("0")) {
			gender = "gender = " + gender;
		} else
			gender = "";

		List<String> conditionCluaseList = new ArrayList<>();
		conditionCluaseList.addAll(Arrays.asList(birthday, gender));
		whereClause = toHqlWhereClause(conditionCluaseList);
		String hql = "from PTEntity " + whereClause;
		Query query = session.createQuery(hql);
		List<PTEntity> list = query.list();
		model.addAttribute("cList", list);
		PTEntity customer = newPT();
		model.addAttribute("pt", customer);
		model.addAttribute("customerUpdate", customer);
		return "admin/personal-trainer";
	}

	// method

	public List<PTEntity> getAllPT() {
		Session session = factory.getCurrentSession();
		String hql = "FROM PTEntity";
		Query query = session.createQuery(hql);
		List<PTEntity> list = query.list();
		return list;
	}

	public PTEntity getPT(String id) {
		Session session = factory.getCurrentSession();
		return (PTEntity) session.get(PTEntity.class, id);
	}

	public PTEntity newPT() {
		PTEntity pt = new PTEntity();
		pt.setPtID(this.toPK("PT", "PTEntity", "ptID"));
		return pt;
	}


}
