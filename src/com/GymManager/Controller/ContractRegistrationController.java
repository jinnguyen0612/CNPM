package com.GymManager.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.GymManager.Entity.AccountEntity;
import com.GymManager.Entity.CustomerEntity;
import com.GymManager.Entity.RegisterEntity;
import com.GymManager.Entity.StaffEntity;
import com.GymManager.ExtraClass.Message;

@Controller
@RequestMapping("admin/contract-registration")
@Transactional
public class ContractRegistrationController extends MethodAdminController {
	@Autowired
	SessionFactory factory;
	@Autowired
	public JavaMailSender mailer;

	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model) {
		model.addAttribute("registerList", getAllRegister());
		return "admin/contract-registration";
	}

	// checkout
	@RequestMapping(value = "/checkout/{id}.htm", method = RequestMethod.GET)
	public String checkout(HttpServletRequest request, ModelMap model, @PathVariable("id") String id,
			RedirectAttributes redirectAttributes, HttpSession ss) throws MessagingException {
		RegisterEntity registerEntity = getRegister(id);

		if (getRegister(id).getStatus() == 1) {
			redirectAttributes.addFlashAttribute("message",
					new Message("error", "Đăng ký này đã thanh toán đừng vọc phá nữa !!!"));

			return "redirect:admin/login.htm";
		}
		if (getRegister(id).getStatus() == 2) {
			redirectAttributes.addFlashAttribute("message",
					new Message("error", "Đăng ký này đã huỷ, không thể thanh toán !!!"));

			return "redirect:admin/login.htm";
		}

		AccountEntity accountEntity = (AccountEntity) ss.getAttribute("admin");

		StaffEntity staffEntity = accountEntity.getStaff();

		boolean isSucces = updateStatusRegister(registerEntity, 1, staffEntity);
		if (isSucces) {
			redirectAttributes.addFlashAttribute("message", new Message("success", "Thanh toán thành công"));
			String mailMessage = "Bạn đã thanh toán thành công hợp đồng đăng ký tập với mã đăng ký là: " + id;
			try {
				MimeMessage mail = mailer.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(mail, true);
				helper.setFrom("nguyenminhnhat301101@gmail.com", "PTITGYM");
				helper.setTo(registerEntity.getCustomer().getEmail());
				helper.setReplyTo("nguyenminhnhat301101@gmail.com");
				helper.setSubject("Thanh toán hợp đồng đăng ký PTITGYM");
				helper.setText(mailMessage);
				mailer.send(mail);
			} catch (Exception e) {
				// TODO: handle exception
			}

		} else {
			redirectAttributes.addFlashAttribute("message", new Message("success", "Thanh toán thất bại"));
		}
		redirectAttributes.addFlashAttribute("registerList", getAllRegister());
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

	@RequestMapping(value = "/cancel/{id}.htm", method = RequestMethod.GET)
	public String cancel(HttpServletRequest request, ModelMap model, @PathVariable("id") String id,
			RedirectAttributes redirectAttributes, HttpSession ss) throws MessagingException {
		RegisterEntity registerEntity = getRegister(id);

		if (getRegister(id).getStatus() == 1) {
			redirectAttributes.addFlashAttribute("message",
					new Message("error", "Đăng ký này đã thanh toán đừng vọc phá nữa !!!"));

			return "redirect:admin/login.htm";
		}
		if (getRegister(id).getStatus() == 2) {
			redirectAttributes.addFlashAttribute("message",
					new Message("error", "Đăng ký này đã thanh toán đừng vọc phá nữa !!!"));

			return "redirect:admin/login.htm";
		}

		AccountEntity accountEntity = (AccountEntity) ss.getAttribute("admin");

		StaffEntity staffEntity = accountEntity.getStaff();

		boolean isSucces = updateStatusRegister(registerEntity, 2, staffEntity);
		if (isSucces) {
			redirectAttributes.addFlashAttribute("message", new Message("success", "Huỷ thành công"));
			String mailMessage = "Hợp đồng đăng ký tập với mã đăng ký là: " + id + "của bạn đã huỷ";
			try {
				MimeMessage mail = mailer.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(mail, true);
				helper.setFrom("nguyenminhnhat301101@gmail.com", "PTITGYM");
				helper.setTo(registerEntity.getCustomer().getEmail());
				helper.setReplyTo("nguyenminhnhat301101@gmail.com");
				helper.setSubject("Huỷ hợp đồng đăng ký PTITGYM");
				helper.setText(mailMessage);
				mailer.send(mail);
			} catch (Exception e) {
				// TODO: handle exception
			}

		} else {
			redirectAttributes.addFlashAttribute("message", new Message("success", "Huỷ thất bại"));
		}
		redirectAttributes.addFlashAttribute("registerList", getAllRegister());
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

	// filter

	@RequestMapping(value = "", params = "btnFilter", method = RequestMethod.GET)
	public String saleFilter(@RequestParam Map<String, String> allParams, ModelMap model, HttpServletRequest request) {

		Session session = factory.getCurrentSession();

		String whereClause = "";

		String birthday = toHqlRangeCondition(allParams.get("birthdayLeft"), allParams.get("birthdayRight"),
				"registerDate");
		String price = toHqlRangeCondition(allParams.get("priceLeft"), allParams.get("priceRight"), "money");

		String hqlStatus = "";
		if (request.getParameterValues("status") != null) {
			hqlStatus = toHqlSingleColumOr("status", request.getParameterValues("status"));
		}
		;

		List<String> conditionCluaseList = new ArrayList<>();
		conditionCluaseList.addAll(Arrays.asList(birthday, price, hqlStatus));
		whereClause = toHqlWhereClause(conditionCluaseList);
		String hql = "from RegisterEntity " + whereClause;

		System.out.println(hql);
		Query query = session.createQuery(hql);
		List<RegisterEntity> list = query.list();
		model.addAttribute("registerList", list);
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

	public boolean updateStatusRegister(RegisterEntity registerEntity, int status, StaffEntity staffEntity) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			registerEntity.setStatus(status);
			if (status != 2) {
				registerEntity.setStaffEntity(staffEntity);
			}

			session.merge(registerEntity);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return false;
		} finally {
			session.close();
		}
		return true;
	}

}
