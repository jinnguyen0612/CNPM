package com.GymManager.Controller;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.apache.commons.codec.digest.DigestUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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

import com.GymManager.CompositePK.RegisterDetailPK;
import com.GymManager.Entity.AccountEntity;
import com.GymManager.Entity.ClassEntity;
import com.GymManager.Entity.CustomerEntity;
import com.GymManager.Entity.RegisterDetailEntity;
import com.GymManager.Entity.RegisterEntity;
import com.GymManager.Entity.ScheduleEntity;
import com.GymManager.Entity.TrainingPackEntity;
import com.GymManager.ExtraClass.FormAttribute;
import com.GymManager.ExtraClass.Message;
import com.GymManager.ExtraClass.RandomPassword;
import com.microsoft.sqlserver.jdbc.SQLServerException;

@Controller
@RequestMapping("admin/customer")
@Transactional
public class CustomerController extends MethodAdminController {
	@Autowired
	SessionFactory factory;
	@Autowired
	public JavaMailSender mailer;

	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model) {
		CustomerEntity customer = newCustomer();
		model.addAttribute("customer", customer);
		model.addAttribute("cFormAttribute",
				new FormAttribute("Thêm mới khách hàng", "admin/customer.htm", "btnCreate"));
		model.addAttribute("cList", getAllCustomer());
		model.addAttribute("register", newRegister());
		return "admin/customer";
	}

	// get view create customer

	@RequestMapping(value = "add.htm", method = RequestMethod.GET)
	public String getCreate(ModelMap model, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("idModal", "modal-create");
		return "redirect:/admin/customer.htm";

	}

	// create customer
	@RequestMapping(method = RequestMethod.POST, params = "btnCreate")
	public String createCustomer(ModelMap model, @Validated @ModelAttribute("customer") CustomerEntity customer,
			BindingResult result, RedirectAttributes redirectAttributes, HttpServletRequest request) {

		if (!result.hasErrors()) {
			Session session = factory.openSession();

			Transaction t = session.beginTransaction();
			try {

				session.save(customer);

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Them thanh cong !!!"));
				return "redirect:/admin/customer.htm";

			} catch (Exception e) {

				t.rollback();
				System.out.println(e.getCause());
				if (e.getCause().toString().contains("UNIQUE_KHACHHANG_SDT")) {
					result.rejectValue("phone", "customer", "số điện thoại này đã được sử dụng");
				}

				if (e.getCause().toString().contains("UCHECK_KHACHHANG_SDT")) {
					result.rejectValue("phone", "customer", "số điện thoại không đúng định dạng");
				}

				if (e.getCause().toString().contains("CK_KHACHHANG_NGAYSINH")) {
					result.rejectValue("birthday", "customer", "Ngày sinh phải nhỏ hơn ngày hiện tại");
				}
				if (e.getCause().toString().contains("UNIQUE_KHACHHANG_EMAIL")) {
					result.rejectValue("email", "customer", "email này đã được sử dụng");
				}
				if (e.getCause().toString().contains("String or binary data would be truncated")) {
					result.rejectValue("customerId", "customer", "Ma khong qua 8 ky tu");
				}
			}

			finally {
				session.close();
			}
		}

		model.addAttribute("idModal", "modal-create");
		model.addAttribute("cFormAttribute",
				new FormAttribute("Thêm mới khách hàng", "admin/customer.htm", "btnCreate"));
		model.addAttribute("cList", getAllCustomer());

		return "admin/customer";

	}

	// update customer //

	// return views update
	@RequestMapping(value = "update/{id}.htm", method = RequestMethod.GET)
	public String getUpdate(ModelMap model, @PathVariable("id") String id) {

		model.addAttribute("customer", getCustomer(id));
		model.addAttribute("idModal", "modal-create");
		model.addAttribute("cList", getAllCustomer());
		model.addAttribute("cFormAttribute", new FormAttribute("Chỉnh sửa thông tin khách hàng",
				"admin/customer/update/" + id + ".htm", "btnUpdate"));
		return "admin/customer";

	}

	@RequestMapping(value = "update/{id}.htm", method = RequestMethod.POST, params = "btnUpdate")
	public String updateCustomer(ModelMap model, @Validated @ModelAttribute("customer") CustomerEntity customer,
			BindingResult result, RedirectAttributes redirectAttributes, @PathVariable("id") String id) {
		if (!result.hasErrors()) {

			Session session = factory.openSession();

			Transaction t = session.beginTransaction();
			try {
				customer.setAccount(getCustomer(id).getAccount());

				session.update(customer);

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Cập nhật thành công !!!"));

				return "redirect:/admin/customer.htm";

			} catch (Exception e) {

				System.out.println(e.getCause());
				if (e.getCause().toString().contains("UNIQUE_KHACHHANG_SDT")) {
					result.rejectValue("phone", "customer", "số điện thoại này đã được sử dụng");
				}

				if (e.getCause().toString().contains("UCHECK_KHACHHANG_SDT")) {
					result.rejectValue("phone", "customer", "số điện thoại không đúng định dạng");
				}

				if (e.getCause().toString().contains("CK_KHACHHANG_NGAYSINH")) {
					result.rejectValue("birthday", "customer", "Ngày sinh phải nhỏ hơn ngày hiện tại");
				}
				if (e.getCause().toString().contains("UNIQUE_KHACHHANG_EMAIL")) {
					result.rejectValue("email", "customer", "email này đã được sử dụng");
				}
				if (e.getCause().toString().contains("String or binary data would be truncated")) {
					result.rejectValue("customerId", "customer", "Ma khong qua 8 ky tu");
				}
				t.rollback();

			} finally {
				session.close();
			}
		}
		model.addAttribute("cFormAttribute", new FormAttribute("Chỉnh sửa thông tin khách hàng",
				"admin/customer/update/" + id + ".htm", "btnUpdate"));
		model.addAttribute("idModal", "modal-create");
		model.addAttribute("cList", getAllCustomer());
		return "admin/customer";
	}

	// create account customer

	@RequestMapping(value = "{id}/create-account.htm", method = RequestMethod.POST)
	public String getCreateAccount(ModelMap model, RedirectAttributes redirectAttributes, @PathVariable("id") String id,
			HttpServletRequest request) {

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		String userName = request.getParameter("userName");
		System.out.println(userName);

		CustomerEntity customer = getCustomer(id);
		redirectAttributes.addFlashAttribute("error", "Tên tài khoản không được bỏ trống");
		if (!userName.equals("")) {
			try {

				RandomPassword radomPassword = new RandomPassword(8);

				AccountEntity accountEntity = new AccountEntity(userName,
						DigestUtils.md5Hex(radomPassword.getPassword()).toUpperCase(), 1, 1, new Date(), customer);

				session.save(accountEntity);

				String mailMessage = "Mật khẩu cho tài khoản PTITGYM của bạn là: " + radomPassword.getPassword();

				MimeMessage mail = mailer.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(mail, true);
				helper.setFrom("nguyenminhnhat301101@gmail.com", "PTITGYM");
				helper.setTo(customer.getEmail());
				helper.setReplyTo("nguyenminhnhat301101@gmail.com");
				helper.setSubject("Tai khoản PTITGYM");
				helper.setText(mailMessage);
				mailer.send(mail);

				customer.setAccount(accountEntity);
				session.merge(customer);
				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Tạo tài khoản thành công !!!"));
				return "redirect:/admin/customer.htm";
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
		redirectAttributes.addFlashAttribute("customerId", id);

		return "redirect:/admin/customer.htm";
	}

	// --------------------------- Register
	// -----------------------------------------------
	// ++++++++++++++ Create

	@RequestMapping(value = "register/{id}.htm", method = RequestMethod.GET)
	public String getRegister(ModelMap model, @PathVariable("id") String id) {
		RegisterEntity register = newRegister();
		register.setCustomer(getCustomer(id));
		model.addAttribute("pack", getAllPackAvailable());
		model.addAttribute("register", register);
		model.addAttribute("customer", newCustomer());
		model.addAttribute("idModal", "modal-register");
		model.addAttribute("cList", getAllCustomer());
		model.addAttribute("formAttribute",
				new FormAttribute("Đăng ký tập", "admin/customer/register/" + id + ".htm", "btnRegister"));
		return "admin/customer";
	}

	@RequestMapping(value = "register/{id}.htm", method = RequestMethod.POST, params = "btnRegister")
	public String comfirmRegister(HttpServletRequest request, ModelMap model, @PathVariable("id") String id,
			RedirectAttributes redirectAttributes, HttpSession ss) throws ParseException {
		String classId = request.getParameter("class");
		RegisterEntity register = newRegister();
		String typeRegister = request.getParameter("typeRegister");
		register.setCustomer(getCustomer(id));
		register.setRegisterDate(new Date());
		register.setStatus(0);
		AccountEntity accountEntity = (AccountEntity) ss.getAttribute("admin");
		register.setAccount(getAccount(accountEntity.getUsername()));
		String errorMessage = "Vui lòng chọn lớp hoặc tạo đăng ký cá nhân";
		boolean isError = false;
		if (request.getParameter("is-select-course-2").equals("1")
				&& request.getParameter("typeRegister2").equals("0")) {
			isError = true;
		}
		if (!typeRegister.equals("0") && !isError) {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				String pClassId = toPK("CN", "ClassEntity", "classId");

				session.save(register);
				if (typeRegister.equals("1")) {
					session.save(new RegisterDetailEntity(register, getClass(classId)));

				} else {
					String dateStart = request.getParameter("date-start");
					TrainingPackEntity pack = getPack(request.getParameter("pack"));
					ClassEntity personalClass = new ClassEntity();
					personalClass.setClassId(pClassId);
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
					personalClass.setDateStart(formatter.parse(dateStart));
					personalClass.setMaxPP(1);
					personalClass.setTrainingPackEntity(pack);

					session.save(personalClass);
					session.save(new RegisterDetailEntity(register, personalClass));

					for (int i = 2; i < 9; i++) {
						String value = request.getParameter("T" + i);
						if (value != null) {
							ScheduleEntity schedule = new ScheduleEntity(personalClass.getClassId(), personalClass, i,
									Integer.parseInt(value));
							session.save(schedule);

						}
					}

				}
				if (request.getParameter("is-select-course-2").equals("1")) {
					String typeRegister2 = request.getParameter("typeRegister2");
					String classId2 = request.getParameter("class2");
					if (typeRegister2.equals("1")) {
						session.save(new RegisterDetailEntity(register, getClass(classId2)));
					} else if (typeRegister2.equals("2")) {
						String dateStart = request.getParameter("date-start2");
						TrainingPackEntity pack = getPack(request.getParameter("pack2"));
						ClassEntity personalClass = new ClassEntity();
						DecimalFormat df = new DecimalFormat("000000");
						personalClass
								.setClassId("CN" + df.format(Integer.parseInt(pClassId.replaceAll("[^0-9]", "")) + 1));
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
						personalClass.setDateStart(formatter.parse(dateStart));
						personalClass.setMaxPP(1);
						personalClass.setTrainingPackEntity(pack);
						session.save(personalClass);
						session.save(new RegisterDetailEntity(register, personalClass));
						for (int i = 2; i < 9; i++) {
							String value = request.getParameter("2-T" + i);
							if (value != null) {
								ScheduleEntity schedule = new ScheduleEntity(personalClass.getClassId(), personalClass,
										i, Integer.parseInt(value));
								session.save(schedule);

							}
						}
					}
				}

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Thêm thành công !!!"));

				return "redirect:/admin/customer.htm";

			} catch (Exception e) {
				t.rollback();
				if (e.getMessage().contains(
						"A different object with the same identifier value was already associated with the session")) {
					errorMessage = "Vui lòng chọn đăng ký hai lớp khác nhau";
				}
				if (e.getMessage().contains("Violation of PRIMARY KEY constraint 'PK_CTTTDK'")) {
					errorMessage = "Vui lòng chọn đăng ký hai lớp khác nhau";
				}

				if (e.getCause().toString().contains("The transaction ended in the trigger")) {
					errorMessage = "Khách hàng này có đăng ký chưa thanh toán, vui lòng thanh toán trước khi đang ký mới";
				}

			} finally {

				session.close();

			}
		}

		model.addAttribute("pack", getAllPackAvailable());
		model.addAttribute("register", register);
		model.addAttribute("customer", newCustomer());
		model.addAttribute("idModal", "modal-register");
		model.addAttribute("cList", getAllCustomer());
		model.addAttribute("message", new Message("error", errorMessage));
		model.addAttribute("formAttribute",
				new FormAttribute("Đăng ký tập", "admin/customer/register/" + id + ".htm", "btnRegister"));
		return "admin/customer";
	}

	// ++++++++++++++ Update
	@RequestMapping(value = "register/update/{id}.htm", method = RequestMethod.GET)
	public String getUpdateRegister(ModelMap model, @PathVariable("id") String id) {
		model.addAttribute("pack", getAllPackAvailable());
		model.addAttribute("register", getRegister(id));
		model.addAttribute("customer", newCustomer());
		model.addAttribute("idModal", "modal-register");
		model.addAttribute("cList", getAllCustomer());
		model.addAttribute("formAttribute", new FormAttribute("Chỉnh sửa thông tin đăng ký",
				"admin/customer/register/update/" + id + ".htm", "btnUpdate"));
		return "admin/customer";
	}

	@RequestMapping(value = "register/update/{id}.htm", method = RequestMethod.POST, params = "btnUpdate")
	public String updateRegister(HttpServletRequest request, ModelMap model, @PathVariable("id") String id,
			RedirectAttributes redirectAttributes, HttpSession ss) {
		RegisterEntity register = getRegister(id);
		String typeRegister = request.getParameter("typeRegister");
		AccountEntity accountEntity = (AccountEntity) ss.getAttribute("admin");
		register.setAccount(getAccount(accountEntity.getUsername()));
		String errorMessage = "Vui lòng chọn lớp hoặc tạo đăng ký cá nhân";
		boolean isError = false;
		if (request.getParameter("is-select-course-2").equals("1")
				&& request.getParameter("typeRegister2").equals("0")) {
			isError = true;
		}
		if (!typeRegister.equals("0") && !isError) {

			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				String pClassId = toPK("CN", "ClassEntity", "classId");
				RegisterDetailEntity[] registerDetailEntities = register.getRegisterDetailList()
						.toArray(RegisterDetailEntity[]::new);
				if (typeRegister.equals("1")) {

					String newClass = request.getParameter("class");
					String oldClass = registerDetailEntities[registerDetailEntities.length - 1].getClassEntity()
							.getClassId();
					if (!newClass.equals(oldClass)) {
						session.delete(registerDetailEntities[registerDetailEntities.length - 1]);
						session.flush();
						session.save(new RegisterDetailEntity(register, getClass(newClass)));
					}

				} else {
					ClassEntity personalClass = registerDetailEntities[registerDetailEntities.length - 1]
							.getClassEntity();
					if (personalClass.getMaxPP() > 1) {
						personalClass = new ClassEntity();
						personalClass.setClassId(pClassId);
						personalClass.setMaxPP(1);
					}
					String dateStart = request.getParameter("date-start");
					TrainingPackEntity pack = getPack(request.getParameter("pack"));
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
					personalClass.setDateStart(formatter.parse(dateStart));
					personalClass.setTrainingPackEntity(pack);

					if (registerDetailEntities[registerDetailEntities.length - 1].getClassEntity().getMaxPP() == 1) {

						session.merge(personalClass);
						ScheduleEntity[] scheduleEntities = personalClass.getScheduleEntity()
								.toArray(ScheduleEntity[]::new);
						for (int i = 0; i < scheduleEntities.length; i++) {
							deleteSchedule(scheduleEntities[i].getId());
						}

					}

					else {
						session.save(personalClass);
						session.delete(registerDetailEntities[registerDetailEntities.length - 1]);
						session.flush();
						session.save(new RegisterDetailEntity(register, personalClass));

					}

					for (int i = 2; i < 9; i++) {
						String value = request.getParameter("T" + i);
						if (value != null) {
							ScheduleEntity schedule = new ScheduleEntity(personalClass.getClassId(), personalClass, i,
									Integer.parseInt(value));
							session.save(schedule);

						}
					}

				}
				if (request.getParameter("is-select-course-2").equals("1")) {
					String typeRegister2 = request.getParameter("typeRegister2");
					if (registerDetailEntities.length < 2) {
						String classId2 = request.getParameter("class2");
						if (typeRegister2.equals("1")) {
							session.save(new RegisterDetailEntity(register, getClass(classId2)));
						} else if (typeRegister2.equals("2")) {
							String dateStart = request.getParameter("date-start2");
							TrainingPackEntity pack = getPack(request.getParameter("pack2"));
							ClassEntity personalClass = new ClassEntity();
							DecimalFormat df = new DecimalFormat("000000");
							personalClass.setClassId(
									"CN" + df.format(Integer.parseInt(pClassId.replaceAll("[^0-9]", "")) + 1));
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
							personalClass.setDateStart(formatter.parse(dateStart));
							personalClass.setMaxPP(1);
							personalClass.setTrainingPackEntity(pack);
							session.save(personalClass);
							session.save(new RegisterDetailEntity(register, personalClass));
							for (int i = 2; i < 9; i++) {
								String value = request.getParameter("2-T" + i);
								if (value != null) {
									ScheduleEntity schedule = new ScheduleEntity(personalClass.getClassId(),
											personalClass, i, Integer.parseInt(value));
									session.save(schedule);

								}
							}
						}
					} else {
						if (typeRegister2.equals("1")) {
							String newClass = request.getParameter("class2");
							String oldClass = registerDetailEntities[registerDetailEntities.length - 2].getClassEntity()
									.getClassId();
							if (!newClass.equals(oldClass)) {
								session.delete(registerDetailEntities[registerDetailEntities.length - 2]);
								session.flush();
								session.save(new RegisterDetailEntity(register, getClass(newClass)));
							}
						} else if (typeRegister2.equals("2")) {
							ClassEntity personalClass = registerDetailEntities[registerDetailEntities.length - 2]
									.getClassEntity();
							if (personalClass.getMaxPP() > 1) {
								personalClass = new ClassEntity();
								personalClass.setClassId(pClassId);
								personalClass.setMaxPP(1);
							}
							String dateStart = request.getParameter("date-start2");
							TrainingPackEntity pack = getPack(request.getParameter("pack2"));
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
							personalClass.setDateStart(formatter.parse(dateStart));
							personalClass.setTrainingPackEntity(pack);
							if (registerDetailEntities[registerDetailEntities.length - 2].getClassEntity()
									.getMaxPP() == 1) {

								session.merge(personalClass);
								ScheduleEntity[] scheduleEntities = personalClass.getScheduleEntity()
										.toArray(ScheduleEntity[]::new);
								for (int i = 0; i < scheduleEntities.length; i++) {
									deleteSchedule(scheduleEntities[i].getId());
								}

							}

							else {
								session.save(personalClass);
								session.delete(registerDetailEntities[registerDetailEntities.length - 2]);
								session.flush();
								session.save(new RegisterDetailEntity(register, personalClass));

							}
							for (int i = 2; i < 9; i++) {
								String value = request.getParameter("2-T" + i);
								if (value != null) {
									ScheduleEntity schedule = new ScheduleEntity(personalClass.getClassId(),
											personalClass, i, Integer.parseInt(value));
									session.save(schedule);

								}
							}
						}

					}

				}

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Cập nhật thành công !!!"));

				return "redirect:/admin/customer.htm";

			} catch (Exception e) {
				t.rollback();
				System.out.println(e.getCause());
				if (e.getMessage().contains(
						"A different object with the same identifier value was already associated with the session")) {
					errorMessage = "Bạn đang chọn lớp mà bạn đã đăng ký trước đó vui lòng chọn lớp khác để cập nhật";
				}
				if (e.getCause().toString().contains("PRIMARY KEY constraint")) {
					errorMessage = "Vui lòng chọn đăng ký hai lớp khác nhau";
				}

			} finally {

				session.close();

			}

		}

		model.addAttribute("idModal", "modal-register");
		model.addAttribute("customer", newCustomer());
		model.addAttribute("cList", getAllCustomer());
		model.addAttribute("register", getRegister(id));
		model.addAttribute("pack", getAllPackAvailable());
		model.addAttribute("message", new Message("error", errorMessage));
		model.addAttribute("formAttribute", new FormAttribute("Chỉnh sửa thông tin đăng ký",
				"admin/customer/register/update/" + id + ".htm", "btnUpdate"));
		return "admin/customer";

	}

	// detail
	@RequestMapping(value = "/detail/{id}.htm", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("id") String id) {
		model.addAttribute("customer", newCustomer());
		model.addAttribute("customerDetail", getCustomer(id));
		model.addAttribute("idModal", "modal-detail");
		model.addAttribute("cList", getAllCustomer());
		return "admin/customer";
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
		String hql = "from CustomerEntity " + whereClause;
		Query query = session.createQuery(hql);
		List<CustomerEntity> list = query.list();
		String status = allParams.get("status");
		if (!status.equals("")) {
			List<CustomerEntity> newList = new ArrayList<CustomerEntity>();

			for (CustomerEntity customerEntity : list) {

				if (customerEntity.getCustomerStatus() == Integer.parseInt(status)) {
					newList.add(customerEntity);
				}

			}
			model.addAttribute("cList", newList);

		} else {
			model.addAttribute("cList", list);
		}

		CustomerEntity customer = newCustomer();
		model.addAttribute("customer", customer);
		model.addAttribute("customerUpdate", customer);
		return "admin/customer";
	}

	// method

	public List<CustomerEntity> getAllCustomer() {
		Session session = factory.getCurrentSession();
		String hql = "FROM CustomerEntity";
		Query query = session.createQuery(hql);
		List<CustomerEntity> list = query.list();
		return list;
	}

	public CustomerEntity getCustomer(String id) {
		Session session = factory.getCurrentSession();
		return (CustomerEntity) session.get(CustomerEntity.class, id);
	}

	public CustomerEntity newCustomer() {
		CustomerEntity customer = new CustomerEntity();
		customer.setCustomerId(this.toPK("KH", "CustomerEntity", "customerId"));
		return customer;
	}

	public RegisterEntity newRegister() {
		RegisterEntity register = new RegisterEntity();
		register.setRegisterId(this.toPK("DK", "RegisterEntity", "registerId"));
		register.setMoney(new BigDecimal(0));
		return register;
	}

	public List<TrainingPackEntity> getAllPackAvailable() {
		Session session = factory.getCurrentSession();
		String hql = "FROM TrainingPackEntity where status = 1";
		Query query = session.createQuery(hql);
		List<TrainingPackEntity> list = query.list();
		return list;
	}

	public TrainingPackEntity getPack(String id) {
		Session session = factory.getCurrentSession();
		return (TrainingPackEntity) session.get(TrainingPackEntity.class, id);
	}

	public ClassEntity getClass(String id) {
		Session session = factory.getCurrentSession();
		return (ClassEntity) session.get(ClassEntity.class, id);
	}

	public RegisterEntity getRegister(String id) {
		Session session = factory.getCurrentSession();
		return (RegisterEntity) session.get(RegisterEntity.class, id);
	}

	public AccountEntity getAccount(String userName) {
		Session session = factory.getCurrentSession();
		return (AccountEntity) session.get(AccountEntity.class, userName);
	}

	public boolean createRegisterDetail(Session session, Transaction t) {

		return true;
	}

	public boolean deleteSchedule(int id) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			String hql = "delete from ScheduleEntity where id= :id";
			Query query = session.createQuery(hql);
			query.setInteger("id", id).executeUpdate();
			t.commit();

		} catch (Exception e) {
			// TODO: handle exception
			t.rollback();
		}
		return true;
	}
}
