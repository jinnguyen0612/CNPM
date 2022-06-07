package com.GymManager.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
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

import com.GymManager.Entity.StaffEntity;
import com.GymManager.Entity.StaffEntity;
import com.GymManager.Entity.AccountEntity;
import com.GymManager.Entity.CustomerEntity;
import com.GymManager.Entity.RegisterEntity;
import com.GymManager.Entity.StaffEntity;
import com.GymManager.Entity.TrainingPackEntity;
import com.GymManager.ExtraClass.FormAttribute;
import com.GymManager.ExtraClass.Message;
import com.GymManager.ExtraClass.RandomPassword;

@Controller
@RequestMapping("admin/employee")
@Transactional
public class EmployeeController extends MethodAdminController {
	@Autowired
	SessionFactory factory;
	@Autowired
	public JavaMailSender mailer;

	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model) {
		StaffEntity staff = newStaff();
		model.addAttribute("staff", staff);
		model.addAttribute("cFormAttribute",
				new FormAttribute("Them moi nhan vien", "admin/employee.htm", "btnCreate"));
		model.addAttribute("cList", getAllStaff());
		return "admin/employee";
	}

	// detail
	@RequestMapping(value = "detail/{id}.htm", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("id") String id) {
		model.addAttribute("staff", newStaff());
		model.addAttribute("staffUpdate", newStaff());
		model.addAttribute("staffDetail", getStaff(id));
		model.addAttribute("idModal", "modal-detail");
		model.addAttribute("cList", getAllStaff());
		return "admin/employee";

	}

	// get view create staff

	@RequestMapping(value = "add.htm", method = RequestMethod.GET)
	public String getCreate(ModelMap model, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("idModal", "modal-create");
		return "redirect:/admin/employee.htm";

	}

	// create staff
	@RequestMapping(method = RequestMethod.POST, params = "btnCreate")
	public String createStaff(ModelMap model, @Validated @ModelAttribute("staff") StaffEntity staff,
			BindingResult result, RedirectAttributes redirectAttributes, HttpServletRequest request) {
//			System.out.println(staff.getStaffId());
		if (!result.hasErrors()) {
			Session session = factory.openSession();

			Transaction t = session.beginTransaction();
			try {

				session.save(staff);

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Them thanh cong !!!"));

				return "redirect:/admin/employee.htm";

			} catch (Exception e) {

				t.rollback();
				System.out.println(e);

				if (e.getCause().toString().contains("UNIQUE_NHANVIEN_SDT")) {
					result.rejectValue("phone", "staff", "So dien thoai nay da duoc su dung");
				}

				if (e.getCause().toString().contains("UCHECK_NHANVIEN_SDT")) {
					result.rejectValue("phone", "staff", "So dien thoai khong dung dinh dang");
				}
				if (e.getCause().toString().contains("CK_NHANVIEN_NGAYSINH")) {
					result.rejectValue("birthday", "staff", "Tuoi nhan vien phai tren 18 tuoi");
				}
				if (e.getCause().toString().contains("UNIQUE_KHACHHANG_EMAIL")) {
					result.rejectValue("email", "staff", "Email nhap sai dinh dang");
				}
				if (e.getCause().toString().contains("String or binary data would be truncated")) {
					result.rejectValue("staffId", "staff", "Ma khong qua 8 ky tu");
				}
			}

			finally {
				session.close();
			}
		}
		model.addAttribute("idModal", "modal-create");
		model.addAttribute("cFormAttribute",
				new FormAttribute("Them moi nhan vien", "admin/employee.htm", "btnCreate"));
		model.addAttribute("staffUpdate", staff);
		return "admin/employee";
	}

	// return views update
	@RequestMapping(value = "update/{id}.htm", method = RequestMethod.GET)
	public String getUpdate(ModelMap model, @PathVariable("id") String id) {

		model.addAttribute("staff", getStaff(id));
		model.addAttribute("idModal", "modal-create");
		model.addAttribute("cList", getAllStaff());
		model.addAttribute("cFormAttribute", new FormAttribute("Chinh sua thong tin khach hang",
				"admin/employee/update/" + id + ".htm", "btnUpdate"));
		return "admin/employee";
	}

	@RequestMapping(value = "update/{id}.htm", method = RequestMethod.POST, params = "btnUpdate")
	public String updateStaff(ModelMap model, @Validated @ModelAttribute("staffUpdate") StaffEntity staff,
			BindingResult result, RedirectAttributes redirectAttributes, @PathVariable("id") String id) {
		if (!result.hasErrors()) {
			Session session = factory.openSession();

			Transaction t = session.beginTransaction();
			try {
				staff.setAccount(getStaff(id).getAccount());
				session.update(staff);

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Sua thanh cong !!!"));

				return "redirect:/admin/employee.htm";

			} catch (Exception e) {

				t.rollback();
				System.out.println(e.getCause());
				if (e.getCause().toString().contains("UNIQUE_NHANVIEN_SDT")) {
					result.rejectValue("phone", "staff", "So dien thoai nay da duoc su dung");
				}

				if (e.getCause().toString().contains("UCHECK_NHANVIEN_SDT")) {
					result.rejectValue("phone", "staff", "So dien thoai khong dung dinh dang");
				}
				if (e.getCause().toString().contains("CK_NHANVIEN_NGAYSINH")) {
					result.rejectValue("birthday", "staff", "Tuoi nhan vien phai tren 18 tuoi");
				}
				if (e.getCause().toString().contains("UNIQUE_KHACHHANG_EMAIL")) {
					result.rejectValue("email", "staff", "Email nhap sai dinh dang");
				}
				if (e.getCause().toString().contains("String or binary data would be truncated")) {
					result.rejectValue("staffId", "staff", "Ma khong qua 8 ky tu");
				}
			}

			finally {
				session.close();
			}
		}
		model.addAttribute("idModal", "modal-update");
		model.addAttribute("staff", newStaff());
		model.addAttribute("cList", getAllStaff());
		return "admin/employee";
	}

	// create account staff

	@RequestMapping(value = "{id}/create-account.htm", method = RequestMethod.POST)
	public String getCreateAccount(ModelMap model, RedirectAttributes redirectAttributes, @PathVariable("id") String id,
			HttpServletRequest request) {

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		String userName = request.getParameter("userName");
		System.out.println(userName);

		StaffEntity staff = getStaff(id);
		redirectAttributes.addFlashAttribute("error", "Tai khoan khong duoc bo trong");
		if (!userName.equals("")) {
			try {

				RandomPassword radomPassword = new RandomPassword(8);

				AccountEntity accountEntity = new AccountEntity(userName, radomPassword.getPassword(), 1, 2, new Date(),
						staff);

				session.save(accountEntity);

//						String mailMessage = "Mật khẩu cho tài khoản PTITGYM của bạn là: " + radomPassword.getPassword();
				//
//						MimeMessage mail = mailer.createMimeMessage();
//						MimeMessageHelper helper = new MimeMessageHelper(mail, true);
//						helper.setFrom("nguyenminhnhat301101@gmail.com", "PTITGYM");
//						helper.setTo(customer.getEmail());
//						helper.setReplyTo("nguyenminhnhat301101@gmail.com");
//						helper.setSubject("Tai khoản PTITGYM");
//						helper.setText(mailMessage);
//						mailer.send(mail);
				//
				staff.setAccount(accountEntity);
				session.merge(staff);
				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Tạo tài khoản thành công !!!"));
				return "redirect:/admin/employee.htm";
			} catch (Exception e) {

				t.rollback();
				System.out.println(e);
				if (e.getCause().toString().contains("duplicate key")) {
					redirectAttributes.addFlashAttribute("error", "Tên tài khoản đã tồn tại");
				}
			} finally {
				session.close();
			}

		}

		redirectAttributes.addFlashAttribute("userName", userName);
		redirectAttributes.addFlashAttribute("idModal", "modal-create-account");
		redirectAttributes.addFlashAttribute("staffId", id);

		return "redirect:/admin/employee.htm";
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
		String hql = "from StaffEntity " + whereClause;
		Query query = session.createQuery(hql);
		List<StaffEntity> list = query.list();
		model.addAttribute("cList", list);
		StaffEntity staff = newStaff();
		model.addAttribute("staff", staff);
		model.addAttribute("staffUpdate", staff);
		return "admin/employee";
	}

	// method

	public List<StaffEntity> getAllStaff() {
		Session session = factory.getCurrentSession();
		String hql = "FROM StaffEntity";
		Query query = session.createQuery(hql);
		List<StaffEntity> list = query.list();
		return list;
	}

	public StaffEntity getStaff(String id) {
		Session session = factory.getCurrentSession();
		return (StaffEntity) session.get(StaffEntity.class, id);
	}

	public StaffEntity newStaff() {
		StaffEntity staff = new StaffEntity();
		staff.setStaffId(this.toPK("NV", "StaffEntity", "staffId"));
		return staff;
	}

}
