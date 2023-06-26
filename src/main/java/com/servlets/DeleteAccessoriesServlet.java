package com.servlets;

import java.io.IOException;


import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.dao.AccessoriesDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class DeleteAccessoriesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeleteAccessoriesServlet() {
        super();

    }
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int productId=Integer.parseInt(request.getParameter("product_id"));
		ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
		AccessoriesDao accessoriesDao = context.getBean("accessoriesDao", AccessoriesDao.class);
		accessoriesDao.deleteAccessories(productId);
		((ClassPathXmlApplicationContext) context).close();
		response.sendRedirect("stock.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
