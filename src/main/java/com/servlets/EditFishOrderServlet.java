package com.servlets;

import java.io.IOException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.dao.FishOrderDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
public class EditFishOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public EditFishOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
		FishOrderDao fishOrderDao = context.getBean("fishOrderDao", FishOrderDao.class);
		long orderId =Long.parseLong(request.getParameter("order_id"));
		 String status = request.getParameter("status");
		 fishOrderDao.updateDeliveredStatus(orderId, status);
		 response.sendRedirect("orders.jsp");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
