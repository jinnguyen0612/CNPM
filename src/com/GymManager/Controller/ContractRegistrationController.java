package com.GymManager.Controller;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.GymManager.Entity.CustomerEntity;
import com.GymManager.Entity.RegisterEntity;
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
			RedirectAttributes redirectAttributes) throws MessagingException {
		RegisterEntity registerEntity = getRegister(id);
		boolean isSucces = updateStatusRegister(registerEntity, 1);
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

	public boolean updateStatusRegister(RegisterEntity registerEntity, int status) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			registerEntity.setStatus(status);
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
