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
import com.GymManager.Entity.StaffEntity;
import com.GymManager.Entity.PTEntity;
import com.GymManager.Entity.TrainingPackEntity;
import com.GymManager.ExtraClass.FormAttribute;
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

	// detail
	@RequestMapping(value = "detail/{id}.htm", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("id") String id) {
		model.addAttribute("pt", newPT());
		model.addAttribute("ptDetail", getPT(id));
		model.addAttribute("idModal", "modal-detail");
		model.addAttribute("cList", getAllPT());

		return "admin/personal-trainer";

	}

	// get view create pt

	@RequestMapping(value = "add.htm", method = RequestMethod.GET)
	public String getCreate(ModelMap model, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("idModal", "modal-create");
		redirectAttributes.addFlashAttribute("cFormAttribute",
				new FormAttribute("Thêm huấn luyện viên", "admin/personal-trainer.htm", "btnCreate"));
		return "redirect:/admin/personal-trainer.htm";

	}

	// create PT
	@RequestMapping(method = RequestMethod.POST, params = "btnCreate")
	public String createPT(ModelMap model, @Validated @ModelAttribute("pt") PTEntity pt, BindingResult result,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (!result.hasErrors()) {
			Session session = factory.openSession();

			Transaction t = session.beginTransaction();
			try {
				pt.setStatus(0);
				session.save(pt);

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Thêm thành công !!!"));

				return "redirect:/admin/personal-trainer.htm";

			} catch (Exception e) {

				t.rollback();
				System.out.println(e);

				if (e.getCause().toString().contains("UNIQUE_PT_SDT")) {
					result.rejectValue("phoneNumber", "pt", "Số điện thoại này đã được sử dung");
				}

				if (e.getCause().toString().contains("UCHECK_PT_SDT")) {
					result.rejectValue("phoneNumber", "pt", "Số điện thoại không đúng định dạng");
				}
				if (e.getCause().toString().contains("CK_PT_NGAYSINH")) {
					result.rejectValue("birthday", "pt", "Tuổi nhân viên phải trên 18");
				}
				if (e.getCause().toString().contains("UNIQUE_PT_EMAIL")) {
					result.rejectValue("email", "pt", "Email đã được sử dụng");
				}
				if (e.getCause().toString().contains("UNIQUE_PT_CMND")) {
					result.rejectValue("identityCard", "pt", "CMND đã tồn tại");
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
		model.addAttribute("cFormAttribute",
				new FormAttribute("Thêm huấn luyện viên", "admin/personal-trainer.htm", "btnCreate"));
		model.addAttribute("ptUpdate", pt);
		model.addAttribute("cList", getAllPT());
		return "admin/personal-trainer";
	}

	// return views update
	@RequestMapping(value = "update/{id}.htm", method = RequestMethod.GET)
	public String getUpdate(ModelMap model, @PathVariable("id") String id) {

		model.addAttribute("pt", getPT(id));
		model.addAttribute("idModal", "modal-create");
		model.addAttribute("cList", getAllPT());
		model.addAttribute("cFormAttribute", new FormAttribute("Chỉnh sửa thông tin huấn luyện viên",
				"admin/personal-trainer/update/" + id + ".htm", "btnUpdate"));
		return "admin/personal-trainer";
	}

	@RequestMapping(value = "update/{id}.htm", method = RequestMethod.POST, params = "btnUpdate")
	public String updatePT(ModelMap model, @Validated @ModelAttribute("pt") PTEntity pt, BindingResult result,
			RedirectAttributes redirectAttributes, @PathVariable("id") String id) {
		if (!result.hasErrors()) {
			Session session = factory.openSession();

			Transaction t = session.beginTransaction();
			try {
				PTEntity oldPT = getPT(id);
				pt.setStatus(oldPT.getStatus());
				session.update(pt);

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Cập nhật thành công !!!"));

				return "redirect:/admin/personal-trainer.htm";

			} catch (Exception e) {

				t.rollback();
				System.out.println(e.getCause());
				if (e.getCause().toString().contains("UNIQUE_PT_SDT")) {
					result.rejectValue("phoneNumber", "pt", "Số điện thoại này đã được sử dung");
				}

				if (e.getCause().toString().contains("UCHECK_PT_SDT")) {
					result.rejectValue("phoneNumber", "pt", "Số điện thoại không đúng định dạng");
				}
				if (e.getCause().toString().contains("CK_PT_NGAYSINH")) {
					result.rejectValue("birthday", "pt", "Tuổi nhân viên phải trên 18");
				}
				if (e.getCause().toString().contains("UNIQUE_PT_EMAIL")) {
					result.rejectValue("email", "pt", "Email đã được sử dụng");
				}
				if (e.getCause().toString().contains("UNIQUE_PT_CMND")) {
					result.rejectValue("identityCard", "pt", "CMND đã tồn tại");
				}
				if (e.getCause().toString().contains("String or binary data would be truncated")) {
					result.rejectValue("ptID", "pt", "Ma khong qua 8 ky tu");
				}
			}

			finally {
				session.close();
			}
		}
		model.addAttribute("idModal", "modal-update");
		model.addAttribute("cList", getAllPT());
		return "admin/personal-trainer";
	}

	// filter

	@RequestMapping(value = "", params = "btnFilter", method = RequestMethod.GET)
	public String saleFilter(@RequestParam Map<String, String> allParams, ModelMap model, HttpServletRequest request) {

		Session session = factory.getCurrentSession();

		String whereClause = "";
		String hqlGender = "";
		String dateCreate = toHqlRangeCondition(allParams.get("dateLeft"), allParams.get("dateRight"), "birthday");
		if (request.getParameterValues("gender") != null) {
			hqlGender = toHqlSingleColumOr("gender", request.getParameterValues("gender"));
		}

		String hqlStatus = "";
		if (request.getParameterValues("status") != null) {
			hqlStatus = toHqlSingleColumOr("status", request.getParameterValues("status"));
		}

		List<String> conditionCluaseList = new ArrayList<>();
		conditionCluaseList.addAll(Arrays.asList(dateCreate, hqlGender, hqlStatus));
		whereClause = toHqlWhereClause(conditionCluaseList);
		String hql = "from PTEntity " + whereClause;
		System.out.println(hql);
		Query query = session.createQuery(hql);
		List<PTEntity> list = query.list();
		model.addAttribute("cList", list);
		PTEntity pt = newPT();
		model.addAttribute("pt", pt);
		model.addAttribute("ptUpdate", pt);
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
