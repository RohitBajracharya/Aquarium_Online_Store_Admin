package com.servlets;

import java.io.IOException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.dao.CustomerDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteCustomerServlet() {
		super();

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int customerId = Integer.parseInt(request.getParameter("customer_id"));
		ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
		CustomerDao customerDao = context.getBean("customerDao", CustomerDao.class);
		customerDao.deleteCustomer(customerId);
		((ClassPathXmlApplicationContext) context).close();
		response.sendRedirect("customer.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
