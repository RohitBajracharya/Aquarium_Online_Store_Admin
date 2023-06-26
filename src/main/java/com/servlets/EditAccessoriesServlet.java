package com.servlets;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.dao.AccessoriesDao;
import com.entities.Accessories;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
public class EditAccessoriesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EditAccessoriesServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
		AccessoriesDao accessoriesDao = context.getBean("accessoriesDao", AccessoriesDao.class);
		System.out.print(request.getParameter("product_id"));
		int productId = Integer.parseInt(request.getParameter("product-id").trim());
		String productCategory = request.getParameter("product-category");
		String productName = request.getParameter("product-name");
		String productPrice = request.getParameter("product-price");
		String productStock = request.getParameter("product-quantity");
		String productUnit = request.getParameter("product-unit");
		Part productImagePart = request.getPart("product-image");
		InputStream productImage = productImagePart.getInputStream();
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		byte[] buffer = new byte[1024];
		for (int length = 0; (length = productImage.read(buffer)) > 0;) {
			output.write(buffer, 0, length);
		}
		byte[] productImageBytes = output.toByteArray();

		String[] categoryWords = productCategory.split("\\s+");
		StringBuilder sbCategory = new StringBuilder();
		for (int i = 0; i < categoryWords.length; i++) {
			String word = categoryWords[i];
			if (!word.isEmpty()) {
				sbCategory.append(Character.toUpperCase(word.charAt(0)));
				if (word.length() > 1) {
					sbCategory.append(word.substring(1).toLowerCase());
				}
			}
			if (i < categoryWords.length - 1) {
				sbCategory.append(" ");
			}
		}
		productCategory = sbCategory.toString();

		String[] nameWords = productName.split("\\s+");
		StringBuilder sbName = new StringBuilder();
		for (int i = 0; i < nameWords.length; i++) {
			String word = nameWords[i];
			if (!word.isEmpty()) {
				sbName.append(Character.toUpperCase(word.charAt(0)));
				if (word.length() > 1) {
					sbName.append(word.substring(1).toLowerCase());
				}
			}
			if (i < nameWords.length - 1) {
				sbName.append(" ");
			}
		}
		productName = sbName.toString();
		String[] unitWords = productUnit.split("\\s+");
		StringBuilder sbUnit = new StringBuilder();
		for (int i = 0; i < unitWords.length; i++) {
			String word = unitWords[i];
			if (!word.isEmpty()) {
				sbUnit.append(Character.toUpperCase(word.charAt(0)));
				if (word.length() > 1) {
					sbUnit.append(word.substring(1).toLowerCase());
				}
			}
			if (i < unitWords.length - 1) {
				sbUnit.append(" ");
			}
		}
		productUnit = sbUnit.toString();
		Accessories accessories = new Accessories(productId, productCategory, productName, productPrice, productStock,
				productUnit, productImageBytes);
		accessoriesDao.updateAccessories(accessories);
		((ClassPathXmlApplicationContext) context).close();
		response.sendRedirect("stock.jsp");
	}

}
