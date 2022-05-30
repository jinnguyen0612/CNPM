package com.GymManager.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.GymManager.Entity.AccountEntity;

public class StaffInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession ss = request.getSession();

		if (ss.getAttribute("admin") == null) {
			response.sendRedirect(request.getContextPath() + "/admin/login.htm");
			return false;
		}
		AccountEntity accountEntity = (AccountEntity) ss.getAttribute("admin");
		if (accountEntity.getPolicyId() == 2) {
			response.sendRedirect(request.getContextPath() + "/admin/login.htm");
			return false;
		}
		return true;
	}

}
