package com.GymManager.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
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

import com.GymManager.Entity.AccountEntity;
import com.GymManager.Entity.CustomerEntity;
import com.GymManager.Entity.StaffEntity;
import com.GymManager.ExtraClass.FormAttribute;
import com.GymManager.ExtraClass.Message;

@Controller
@RequestMapping("admin/account")
@Transactional
public class AccountController extends MethodAdminController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model) {
		AccountEntity account = newAccount();
		model.addAttribute("account", account);
		model.addAttribute("aList", getAllAccount());
		return "admin/account";
	}

//Clock account

	@RequestMapping(value = "clock/{username}.htm")
	public String clockAccount(@PathVariable("username") String username, RedirectAttributes redirectAttributes) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		AccountEntity account = getAccount(username);
		if (account.getPolicyId() != 2) {
			redirectAttributes.addFlashAttribute("message",
					new Message("error", "Không thể khoá tài khoản không phải quyền nhân viên"));
			return "redirect:/admin/account.htm";
		}
		if (account.getStaff().getStatus() == 0 && account.getStatus() == 0) {
			redirectAttributes.addFlashAttribute("message",
					new Message("error", "Nhân viên sở hữu tài khoản này đã nghỉ làm không thể mở khoá tài khoản"));
			return "redirect:/admin/account.htm";
		}
		try {
			String message = "";
			if (account.getStatus() == 0) {
				redirectAttributes.addFlashAttribute("message", new Message("success", "Khoá tài khoản thành công"));
				message = "Mở khoá tài khoản thành công";
				account.setStatus(1);
			} else if (account.getStatus() == 1) {
				account.setStatus(0);
				message = "Khoá tài khoản thành công";
			}
			session.merge(account);
			redirectAttributes.addFlashAttribute("message", new Message("success", message));

			t.commit();

			return "redirect:/admin/account.htm";

		}

		finally {
			session.close();
		}

	}

	// filter

	@RequestMapping(value = "", params = "btnFilter", method = RequestMethod.GET)
	public String saleFilter(@RequestParam Map<String, String> allParams, ModelMap model, HttpServletRequest request) {

		Session session = factory.getCurrentSession();

		String whereClause = "";
		String hqlStatus = "";
		String dateCreate = toHqlRangeCondition(allParams.get("dateLeft"), allParams.get("dateRight"), "dateCreate");
		if (request.getParameterValues("status") != null) {
			hqlStatus = toHqlSingleColumOr("status", request.getParameterValues("status"));
		}

		String hqlType = "";
		if (request.getParameterValues("type") != null) {
			hqlType = toHqlSingleColumOr("policyId", request.getParameterValues("type"));
		}

		List<String> conditionCluaseList = new ArrayList<>();
		conditionCluaseList.addAll(Arrays.asList(dateCreate, hqlType, hqlStatus));
		whereClause = toHqlWhereClause(conditionCluaseList);
		String hql = "from AccountEntity " + whereClause;
		System.out.println(hql);
		Query query = session.createQuery(hql);
		List<AccountEntity> list = query.list();
		model.addAttribute("aList", list);
		return "admin/account";
	}

//method

	public List<AccountEntity> getAllAccount() {
		Session session = factory.getCurrentSession();
		String hql = "FROM AccountEntity";
		Query query = session.createQuery(hql);
		List<AccountEntity> list = query.list();
		return list;
	}

	public AccountEntity getAccount(String username) {
		Session session = factory.getCurrentSession();
		return (AccountEntity) session.get(AccountEntity.class, username);
	}

	public AccountEntity newAccount() {
		AccountEntity account = new AccountEntity();
		return account;
	}
}
