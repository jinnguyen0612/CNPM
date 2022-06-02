package com.GymManager.Controller;

import java.util.List;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.GymManager.Entity.AccountEntity;
import com.GymManager.Entity.StaffEntity;
import com.GymManager.ExtraClass.FormAttribute;
import com.GymManager.ExtraClass.Message;

@Controller
@RequestMapping("admin/account")
@Transactional
public class AccountController extends MethodAdminController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(method= RequestMethod.GET)
	public String index(ModelMap model) {
		AccountEntity account = newAccount();
		model.addAttribute("account",account);
//		model.addAttribute("accountUpdate", account);
		model.addAttribute("aList", getAllAccount());
		return "admin/account";
	}
	
//Clock account

	
	@RequestMapping(value = "clock/{username}.htm")
	public String clockAccount(@PathVariable("username") String username) {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			AccountEntity account = getAccount(username);
			try {
				if(account.getStatus()==0) account.setStatus(1);
				if(account.getStatus()==1) account.setStatus(0);
				session.merge(account);

				t.commit();

				return "redirect:/admin/account.htm";

			}

			finally {
				session.close();
			}
			
	}
	
	
//method
	
	public List<AccountEntity> getAllAccount() {
		Session session = factory.getCurrentSession();
		String hql = "FROM AccountEntity";
		Query query = session.createQuery(hql);
		List<AccountEntity> list = query.list();
		return list;
	}
	
//	public AccountEntity getAccount(String username) {
//		Session session = factory.getCurrentSession();
//		String hql = "FROM AccountEntity Where";
//		Query query = session.createQuery(hql);
//		AccountEntity account = query.account;
//		return list;
//	}
	
	
	
	
	public AccountEntity getAccount(String username) {
		Session session = factory.getCurrentSession();
		return (AccountEntity) session.get(AccountEntity.class, username);
	}

	public AccountEntity newAccount() {
		AccountEntity account = new AccountEntity();
		return account;
	}
}
