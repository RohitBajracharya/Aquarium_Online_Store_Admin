package com.dao;


import java.util.List;

import javax.transaction.Transactional;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate5.HibernateTemplate;

import com.entities.Checkout;

@SuppressWarnings("deprecation")
public class CheckoutDao {
	private HibernateTemplate hibernateTemplate;

	@SuppressWarnings("deprecation")
	public int countOrders() {
		ApplicationContext context=new ClassPathXmlApplicationContext("config.xml");
		FishOrderDao fishOrderDao=context.getBean("fishOrderDao",FishOrderDao.class);
		int fishOrder=fishOrderDao.countNewOrders();
		AccessoriesOrderDao accessoriesOrderDao=context.getBean("accessoriesOrderDao",AccessoriesOrderDao.class);
		int accessoriesOrder=accessoriesOrderDao.countNewAccessoriesOrders();
		int totalOrder=fishOrder+accessoriesOrder;
		return totalOrder;
    }
	
	@SuppressWarnings("unchecked")
	public double calculateGrandTotalSum() {
        String hqlQuery = "SELECT SUM(c.grandTotal) FROM Checkout c";
        List<Double> result = (List<Double>) hibernateTemplate.find(hqlQuery);
        if (result != null && !result.isEmpty() && result.get(0) != null) {
            return result.get(0);
        }
        return 0.0; // Return 0 if no results found
    }

	@Transactional
	public List<Checkout> getAllCheckoutDetails() {
        return hibernateTemplate.loadAll(Checkout.class);
    }

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

}
