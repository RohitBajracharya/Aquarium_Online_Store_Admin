package com.servlets;

import java.io.IOException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.dao.FishDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteFishServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public DeleteFishServlet() {
        super();

    }
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int fishId=Integer.parseInt(request.getParameter("fish_id"));
		ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
		FishDao fishDao = context.getBean("fishDao", FishDao.class);
		fishDao.deleteFish(fishId);
		((ClassPathXmlApplicationContext) context).close();
		response.sendRedirect("stock.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
