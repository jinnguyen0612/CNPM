package com.GymManager.Controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
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

import com.GymManager.Entity.ClassEntity;
import com.GymManager.Entity.CustomerEntity;
import com.GymManager.Entity.PTEntity;
import com.GymManager.Entity.ScheduleEntity;
import com.GymManager.Entity.StaffEntity;
import com.GymManager.Entity.TrainingPackEntity;
import com.GymManager.ExtraClass.FormAttribute;
import com.GymManager.ExtraClass.Message;
import com.GymManager.Service.ClassService;
import com.GymManager.Service.PTService;
import com.GymManager.Service.TrainingPackService;

import antlr.debug.MessageAdapter;

@Controller
@RequestMapping("admin/class")
@Transactional
public class ClassController extends MethodAdminController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ClassService classService;
	@Autowired
	TrainingPackService trainingPackService;
	@Autowired
	PTService ptService;

	@RequestMapping(value = "")
	public String classGym(ModelMap model, Integer offset, Integer maxResult, HttpServletRequest request,
			ClassEntity classEntity) {
		model.addAttribute("trainingPackEntity", getAllPackAvailable());
		model.addAttribute("ptEntity", getAllPTAvailable());
		model.addAttribute("classEntity", getAllClass());
		model.addAttribute("classer", newClass());
		model.addAttribute("classUpdate", newClass());
		return "admin/class";
	}

	@RequestMapping(value = "insert", method = RequestMethod.POST, params = "btnCreate")
	public String addClass(ModelMap model, @Validated @ModelAttribute("classer") ClassEntity classer,
			BindingResult result, RedirectAttributes redirectAttributes, Integer offset, Integer maxResult,
			HttpServletRequest request) {
		TrainingPackEntity trainingPackEntity = trainingPackService.getPackByPackId(classer.getPackId());
		PTEntity ptEntity = ptService.getPTById(classer.getPT());

		classer.setTrainingPackEntity(trainingPackEntity);
		classer.setPtEntity(ptEntity);

		boolean isValid = checkValidClass(classer, result, "classer");

		if (!result.hasErrors() && isValid) {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				session.save(classer);
				for (int i = 2; i < 9; i++) {
					String value = request.getParameter("T" + i);
					if (value != null) {
						ScheduleEntity schedule = new ScheduleEntity(classer.getClassId(), classer, i,
								Integer.parseInt(value));
						session.save(schedule);
					}
				}
				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Thêm mới thành công !!!"));
				return "redirect:/admin/class.htm";

			} catch (Exception e) {
				t.rollback();
				System.out.println(e.getMessage());
				if (e.getCause() != null) {
					System.out.println(e.getCause());
					if (e.getCause().toString().contains("CK_LOP_NGAYBDT")) {
						result.rejectValue("dateStart", "classer",
								"Ngày bắt đầu lớp phải lớn hơn ngày kết thúc đăng ký");
					}
					if (e.getCause().toString().contains("CK_LOP_DONGDK")) {
						result.rejectValue("dateClose", "classer", "Ngày đóng đăng ký lớp phải lớn hơn ngày hiện tại");
					}
					if (e.getCause().toString().contains("CK_LOP_MODK_DONGDK")) {
						result.rejectValue("dateOpen", "classer", "Ngày mở đăng ký phải nhở hơn ngày đóng đăng ký");
					}
				}
			} finally {
				session.close();
			}
		}

		model.addAttribute("trainingPackEntity", getAllPackAvailable());
		model.addAttribute("ptEntity", getAllPTAvailable());
		model.addAttribute("classUpdate", newClass());
		model.addAttribute("classEntity", getAllClass());
		model.addAttribute("idModal", "modal-create");
		return "admin/class";
	}

//	// SỬA LỚP
	@RequestMapping(value = "update/{classId}", method = RequestMethod.GET)
	public String update(ModelMap model, @PathVariable("classId") String classId, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		ClassEntity classEntity = getClassEntity(classId);
		if (classEntity.getClassPeriod() == 1) {
			redirectAttributes.addFlashAttribute("message",
					new Message("error", "Lớp đang trong qua trình giảng dạy không được chỉnh sửa !!!"));
			return "redirect:/admin/class.htm";
		}
		if (classEntity.getClassPeriod() == 2) {
			redirectAttributes.addFlashAttribute("message", new Message("error", "Lớp đã không thể chỉnh sửa !!!"));
			return "redirect:/admin/class.htm";
		}
		model.addAttribute("trainingPackEntity", getAllPackAvailable());
		model.addAttribute("ptEntity", getAllPTAvailable());
		model.addAttribute("classEntity", getAllClass());
		model.addAttribute("classer", newClass());
		model.addAttribute("classUpdate", classEntity);
		model.addAttribute("idModal", "modal-update");
		return "admin/class";
	}

	@RequestMapping(value = "update/{classId}", method = RequestMethod.POST)
	public String update(ModelMap model, @Validated @ModelAttribute("classUpdate") ClassEntity classEntity,
			BindingResult result, Integer offset, Integer maxResult, HttpServletRequest request,
			RedirectAttributes redirectAttributes, @PathVariable("classId") String id) {

		ClassEntity oldClass = getClassEntity(id);
		TrainingPackEntity trainingPackEntity = trainingPackService.getPackByPackId(classEntity.getPackId());
		PTEntity ptEntity = ptService.getPTById(classEntity.getPT());
		classEntity.setPtEntity(ptEntity);
		classEntity.setTrainingPackEntity(trainingPackEntity);

		boolean isValid = true;

		isValid = checkValidClass(classEntity, result, "classUpdate");

		if (oldClass.getRegisterDetailEntities() != null) {
			if (classEntity.getMaxPP() < getClassEntity(id).getRegisterDetailEntities().size()) {
				result.rejectValue("maxPP", "classUpdate",
						"Số lượng người đăng ký tối đa không được nhỏ hơn số người đăng ký hiện tại");
				isValid = false;
			}
			;
		}
		if (!result.hasErrors() && isValid) {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				session.update(classEntity);

				List<ScheduleEntity> scheduleEntities = (List<ScheduleEntity>) oldClass.getScheduleEntity();
				for (ScheduleEntity scheduleEntity : scheduleEntities) {
					deleteSchedule(scheduleEntity.getId());
				}

				for (int i = 2; i < 9; i++) {
					String value = request.getParameter("2-T" + i);
					if (value != null) {
						ScheduleEntity schedule = new ScheduleEntity(classEntity.getClassId(), classEntity, i,
								Integer.parseInt(value));
						session.save(schedule);
					}
				}

				t.commit();
				redirectAttributes.addFlashAttribute("message", new Message("success", "Cập nhật thành công !!!"));
				return "redirect:/admin/class.htm";

			} catch (Exception e) {
				t.rollback();
				System.out.println(e.getMessage());
				if (e.getCause() != null) {
					System.out.println(e);
					System.out.println(e.getCause());
					if (e.getCause() != null) {
						if (e.getCause().toString().contains("CK_LOP_NGAYBDT")) {
							result.rejectValue("dateStart", "classUpdate",
									"Ngày bắt đầu lớp phải lớn hơn ngày kết thúc đăng ký");
						}
						if (e.getCause().toString().contains("CK_LOP_DONGDK")) {
							result.rejectValue("dateClose", "classUpdate",
									"Ngày đóng đăng ký lớp phải lớn hơn ngày hiện tại");
						}
						if (e.getCause().toString().contains("CK_LOP_MODK_DONGDK")) {
							result.rejectValue("dateOpen", "classUpdate",
									"Ngày mở đăng ký phải nhở hơn ngày đóng đăng ký");
						}
					}

				}
			} finally {
				session.close();
			}
		}
		classEntity.setScheduleEntity(oldClass.getScheduleEntity());
		model.addAttribute("trainingPackEntity", getAllPackAvailable());
		model.addAttribute("ptEntity", getAllPTAvailable());
		model.addAttribute("classer", newClass());
		model.addAttribute("classEntity", getAllClass());
		model.addAttribute("idModal", "modal-update");
		return "admin/class";
	}

	@RequestMapping(value = "/detail/{id}.htm", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("id") String id, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("classDetail", getClassEntity(id));
		redirectAttributes.addFlashAttribute("idModal", "modal-detail");
		return "redirect:/admin/class.htm";
	}

	@RequestMapping(value = "", params = "btnFilter", method = RequestMethod.GET)
	public String saleFilter(@RequestParam Map<String, String> allParams, ModelMap model, HttpServletRequest request) {
		List<ClassEntity> list = getAllClass();

		String[] period = request.getParameterValues("period");
		String[] status = request.getParameterValues("status");

		if (period != null) {
			List<ClassEntity> newList = new ArrayList<ClassEntity>();

			for (ClassEntity classEntity : list) {
				for (int i = 0; i < period.length; i++) {
					System.out.println(period[i]);
					if (classEntity.getClassPeriod() == Integer.parseInt(period[i])) {
						System.out.println(period[i]);
						newList.add(classEntity);
					}
				}

			}

			list = newList;

		}

		if (status != null) {
			List<ClassEntity> newList = new ArrayList<ClassEntity>();
			for (ClassEntity classEntity : list) {
				for (int i = 0; i < status.length; i++) {
					System.out.println("s-" + status[i]);
					if (classEntity.getClassStatus() == Integer.parseInt(status[i])) {
						System.out.println("s-c" + status[i]);

						System.out.println("c-c" + classEntity.getClassStatus());
						newList.add(classEntity);
					}
				}
			}
			list = newList;
		}

		model.addAttribute("trainingPackEntity", getAllPackAvailable());
		model.addAttribute("ptEntity", getAllPTAvailable());
		model.addAttribute("classEntity", list);
		model.addAttribute("classer", newClass());
		model.addAttribute("classUpdate", newClass());
		return "admin/class";

	}

	public List<ClassEntity> getAllClass() {
		Session session = factory.getCurrentSession();
		String hql = "FROM ClassEntity where maxPP > 1";
		Query query = session.createQuery(hql);
		List<ClassEntity> list = query.list();
		return list;
	}

	public List<TrainingPackEntity> getAllPackAvailable() {
		Session session = factory.getCurrentSession();
		String hql = "FROM TrainingPackEntity where status = 1";
		Query query = session.createQuery(hql);
		List<TrainingPackEntity> list = query.list();
		return list;
	}

	public ClassEntity newClass() {
		ClassEntity classEntity = new ClassEntity();
		classEntity.setClassId(this.toPK("LP", "ClassEntity", "classId"));
		return classEntity;
	}

	public List<PTEntity> getAllPTAvailable() {
		Session session = factory.getCurrentSession();
		String hql = "FROM PTEntity where status = 0";
		Query query = session.createQuery(hql);
		List<PTEntity> list = query.list();
		return list;
	}

	public ClassEntity getClassEntity(String id) {
		Session session = factory.getCurrentSession();
		return (ClassEntity) session.get(ClassEntity.class, id);
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

	public boolean checkValidClass(ClassEntity classEntity, BindingResult result, String type) {
		boolean isValid = true;
		if (classEntity.getPT().equals("")) {
			isValid = false;
			result.rejectValue("PT", type, "Nội dung này không được bỏ trống");
		}
		if (classEntity.getPackId().equals("")) {
			isValid = false;
			result.rejectValue("packId", type, "Nội dung này không được bỏ trống");
		}
		if (classEntity.getDateStart() == null) {
			isValid = false;
			result.rejectValue("dateStart", type, "Nội dung này không được bỏ trống");
		}
		if (classEntity.getDateClose() == null) {
			isValid = false;
			result.rejectValue("dateClose", type, "Nội dung này không được bỏ trống");
		}
		if (classEntity.getDateOpen() == null) {
			isValid = false;
			result.rejectValue("dateOpen", type, "Nội dung này không được bỏ trống");
		}
		if (classEntity.getMaxPP() < 2) {
			isValid = false;
			result.rejectValue("maxPP", type, "Số người đăng ký phải lớn hơn 2");
		}

		return isValid;
	}

}