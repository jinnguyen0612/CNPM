package com.GymManager.Controller;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.GymManager.Entity.AccountEntity;
import com.GymManager.ExtraClass.Message;

@Controller
@RequestMapping("admin/profile")
@Transactional
public class ProfileController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model) {
		model.addAttribute("tabId", "profile-overview");
		return "admin/profile";
	}

	@RequestMapping(params = "btnChangePw")
	public String changePW(HttpSession ss, @RequestParam("password") String PW, @RequestParam("newpassword") String nPW,
			@RequestParam("renewpassword") String rnPW, ModelMap model) {

		Boolean isErrors = false;
		AccountEntity accountOld = (AccountEntity) ss.getAttribute("admin");
		AccountEntity account = getAccount(accountOld.getUsername());

		if (account.getPassword().trim().equals(PW) == false) {
			model.addAttribute("message1", "Sai mật khẩu!");
		} else {
			if (nPW.trim().isEmpty()) {
				model.addAttribute("message3", "Nội dung không được để trống!");
				isErrors = true;
			}

			if (rnPW.trim().isEmpty()) {
				model.addAttribute("message2", "Nội dung không được để trống!");
				isErrors = true;
			}

			if (isErrors) {
				model.addAttribute("tabId", "profile-change-password");
				model.addAttribute("password", PW);
				model.addAttribute("newpassword", nPW);
				model.addAttribute("renewpassword", rnPW);
				return "admin/profile";
			}

			if (nPW.equals(rnPW) == false) {
				model.addAttribute("message2", "Mật khẩu không trùng khớp!");
			} else {
				Session session = factory.openSession();
				Transaction t = session.beginTransaction();
				account.setPassword(nPW);
				try {
					session.merge(account);
					t.commit();
					model.addAttribute("message", new Message("success", "Chỉnh sửa thành công!"));
				} catch (Exception e) {
					t.rollback();
					model.addAttribute("message", new Message("error", "Chỉnh sửa thất bại!"));
				}
			}
		}
		model.addAttribute("tabId", "profile-change-password");
		model.addAttribute("password", PW);
		model.addAttribute("newpassword", nPW);
		model.addAttribute("renewpassword", rnPW);

		return "admin/profile";
	}

	public AccountEntity getAccount(String userName) {
		Session session = factory.getCurrentSession();
		return (AccountEntity) session.get(AccountEntity.class, userName);
	}

}
