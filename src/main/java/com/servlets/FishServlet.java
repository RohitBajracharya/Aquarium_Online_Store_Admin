package com.servlets;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.dao.FishDao;
import com.entities.Fish;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
public class FishServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FishServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
		FishDao fishDao = context.getBean("fishDao", FishDao.class);

		String fishType = request.getParameter("fish-type");
		String fishName = request.getParameter("fish-name");
		String fishPrice = request.getParameter("fish-price");
		String fishStock = request.getParameter("fish-quantity");
		String fishUnit = request.getParameter("fish-unit");
		Part fishImagePart = request.getPart("fish-image");
		InputStream fishImage = fishImagePart.getInputStream();
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		byte[] buffer = new byte[1024];
		for (int length = 0; (length = fishImage.read(buffer)) > 0;) {
			output.write(buffer, 0, length);
		}
		byte[] fishImageBytes = output.toByteArray();
		String[] fishTypeWords = fishType.split("\\s+");
		StringBuilder capitalizedFishType = new StringBuilder();
		for (int i = 0; i < fishTypeWords.length; i++) {
			String word = fishTypeWords[i];
			if (!word.isEmpty()) {
				capitalizedFishType.append(Character.toUpperCase(word.charAt(0)));
				if (word.length() > 1) {
					capitalizedFishType.append(word.substring(1));
				}
			}
			if (i < fishTypeWords.length - 1) {
				capitalizedFishType.append(" ");
			}
		}
		String[] fishNameWords = fishName.split("\\s+");
		StringBuilder capitalizedFishName = new StringBuilder();
		for (int i = 0; i < fishNameWords.length; i++) {
			String word = fishNameWords[i];
			if (!word.isEmpty()) {
				capitalizedFishName.append(Character.toUpperCase(word.charAt(0)));
				if (word.length() > 1) {
					capitalizedFishName.append(word.substring(1));
				}
			}
			if (i < fishNameWords.length - 1) {
				capitalizedFishName.append(" ");
			}
		}
		fishType = capitalizedFishType.toString();
		fishName = capitalizedFishName.toString();
		String[] fishUnitWords = fishUnit.split("\\s+");
		StringBuilder capitalizedFishUnit = new StringBuilder();
		for (int i = 0; i < fishUnitWords.length; i++) {
			String word = fishUnitWords[i];
			if (!word.isEmpty()) {
				capitalizedFishUnit.append(Character.toUpperCase(word.charAt(0)));
				if (word.length() > 1) {
					capitalizedFishUnit.append(word.substring(1));
				}
			}
			if (i < fishUnitWords.length - 1) {
				capitalizedFishUnit.append(" ");
			}
		}
		fishUnit = capitalizedFishUnit.toString();

		Fish fish = new Fish(fishType, fishName, fishPrice, fishStock, fishUnit, fishImageBytes);

		if (fishDao.isFishNameExists(fishName)) {
			fishDao.updateFishStock(fishName, fishStock);
			((ClassPathXmlApplicationContext) context).close();
			response.sendRedirect("stock.jsp");
		} else {
			int r = fishDao.insert(fish);
			if (r > 0) {
				((ClassPathXmlApplicationContext) context).close();
				response.sendRedirect("stock.jsp");
			}
		}

	}

}
