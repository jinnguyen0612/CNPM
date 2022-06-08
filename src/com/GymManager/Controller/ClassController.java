package com.GymManager.Controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.List;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.GymManager.Entity.ClassEntity;
import com.GymManager.Entity.CustomerEntity;
import com.GymManager.Entity.PTEntity;
import com.GymManager.Entity.ScheduleEntity;
import com.GymManager.Entity.TrainingPackEntity;
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
	public String addClass(ModelMap model, @ModelAttribute("classer") ClassEntity classer, BindingResult result,
			RedirectAttributes redirectAttributes, Integer offset, Integer maxResult, HttpServletRequest request) {
		List<TrainingPackEntity> listTP = trainingPackService.getAllPack(offset, maxResult);// gọi list gói tập
		TrainingPackEntity trainingPackEntity = trainingPackService.getPackByPackId(classer.getPackId());

		List<PTEntity> listPT = ptService.getAllPT(offset, maxResult); // gọi listPT
		PTEntity ptEntity = ptService.getPTById(classer.getPT());

		classer.setTrainingPackEntity(trainingPackEntity);
		classer.setPtEntity(ptEntity);
		classService.updateClass(classer);
		// Thêm thời khóa biểu
		boolean check = classService.insertClass(classer);
		if (check) {
			Session session = factory.openSession();
			Transaction transaction = session.beginTransaction();

			for (int i = 2; i < 9; i++) {
				String value = request.getParameter("T" + i);
				if (value != null) {
					ScheduleEntity schedule = new ScheduleEntity(classer.getClassId(), classer, i,
							Integer.parseInt(value));
					session.save(schedule);
				}
			}
			transaction.commit();
			redirectAttributes.addFlashAttribute("message", new Message("success", "Thêm mới thành công !!!"));
			return "redirect:/admin/class.htm";
		} else {
			model.addAttribute("trainingPackEntity", listTP);
			model.addAttribute("ptEntity", listPT);
			model.addAttribute("classer", new ClassEntity());
			model.addAttribute("classUpdate", newClass());
		}
		model.addAttribute("classEntity", getAllClass());
		return "admin/class";
	}

//	// SỬA LỚP
	@RequestMapping(value = "updateClass/{classId}", method = RequestMethod.GET)
	public String update(ModelMap model, @PathVariable("classId") String classId) {
		model.addAttribute("trainingPackEntity", getAllPackAvailable());
		model.addAttribute("ptEntity", getAllPTAvailable());
		model.addAttribute("classEntity", getAllClass());
		model.addAttribute("classer", newClass());
		model.addAttribute("classUpdate", getClassEntity(classId));
		model.addAttribute("idModal", "modal-update");
		return "admin/class";
	}
//	
//	@RequestMapping(value = "updateClass/{classId}", method=RequestMethod.POST)
//	public String update(ModelMap model ,  @ModelAttribute("updateClass") ClassEntity classEntity,Integer offset, Integer maxResult)
//	{
//		Session session = factory.openSession();
//		TrainingPackEntity trainingPackEntity = trainingPackService.getPackByPackId(classEntity.getPackId());
////		PTEntity ptEntity = ptService.getPTById(classEntity.getPT());
//		classEntity.setTrainingPackEntity(trainingPackEntity);
////		classEntity.setPtEntity(ptEntity);
//		boolean check = classService.updateClass(classEntity);
//		if (check) {
//			model.addAttribute("message", "Cập nhật thành công!");
//            List<ClassEntity> listClass = classService.getAllClass(offset, maxResult);
//            model.addAttribute("class", listClass) ;
//        } else {
//        	model.addAttribute("message", "Cập nhật thất bại!");
//            List<ClassEntity> listClass = classService.getAllClass(offset, maxResult) ;
//            model.addAttribute("class", listClass) ;
//        }
//		return "admin/class";
//	}

//	// Sửa lớp
//	@RequestMapping(value = "updateClass/{classId}", method = RequestMethod.GET)
//	public String update(ModelMap model, @PathVariable("classId") String classIdx, Integer offset, Integer maxResult) {
//
//		Session session = factory.openSession();
//		ClassEntity classEntity = (ClassEntity) session.get(ClassEntity.class, classIdx);
//		model.addAttribute("classEntityUpdate", classEntity);
//		List<TrainingPackEntity> trainingPackEntity = trainingPackService.getAllPack(offset, maxResult);
//		model.addAttribute("trainingPackEntity", trainingPackEntity);
//		List<PTEntity> ptEntity = ptService.getAllPT(offset, maxResult);
//		model.addAttribute("ptEntity", ptEntity);
//		return "admin/updateClass";
//	}

	@RequestMapping(value = "updateClass/{classId}", method = RequestMethod.POST)
	public String update(ModelMap model, @ModelAttribute("updateC") ClassEntity classEntity, Integer offset,
			Integer maxResult) {
		Session session = factory.openSession();
		TrainingPackEntity trainingPackEntity = trainingPackService.getPackByPackId(classEntity.getPackId());
		PTEntity ptEntity = ptService.getPTById(classEntity.getPT());

		classEntity.setPtEntity(ptEntity);
		classEntity.setTrainingPackEntity(trainingPackEntity);

		boolean check = classService.updateClass(classEntity);
		if (check) {
			List<ClassEntity> list = classService.getAllClass(offset, maxResult);
			model.addAttribute("pack", list);
//			model.addAttribute("classEntityUpdate", classEntity);
		} else {
			List<ClassEntity> list = classService.getAllClass(offset, maxResult);
			model.addAttribute("pack", list);
//			model.addAttribute("classEntityUpdate", classEntity);
		}
		return "admin/updateClass";
	}

	@RequestMapping(value = "/detail/{id}.htm", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("id") String id, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("classDetail", getClassEntity(id));
		redirectAttributes.addFlashAttribute("idModal", "modal-detail");
		return "redirect:/admin/class.htm";
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

}