package com.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate5.HibernateTemplate;

import com.entities.Accessories;


public class AccessoriesDao {
	private HibernateTemplate hibernateTemplate;

	// insert data
	@Transactional
	public int insert(Accessories accessories) {
		Integer i = (Integer) this.hibernateTemplate.save(accessories);
		return i;
	}

	// deleting the data
	@Transactional
	public void deleteAccessories(int accessoriesId) {
		Accessories accessories = this.hibernateTemplate.get(Accessories.class, accessoriesId);
		this.hibernateTemplate.delete(accessories);
	}

	// updating the data
	@Transactional
	public void updateAccessories(Accessories accessories) {
		this.hibernateTemplate.update(accessories);
	}

	// retrieve all data
	public List<Accessories> getAllAccessories() {
		List<Accessories> accessories = this.hibernateTemplate.loadAll(Accessories.class);
		return accessories;
	}

	// get single data(object)
	public Accessories getAccessories(int accessoriesId) {
		Accessories accessories = this.hibernateTemplate.get(Accessories.class, accessoriesId);
		return accessories;
	}
	@Transactional
	@SuppressWarnings({ "deprecation", "unchecked" })
	public boolean isAccessoriesNameExists(String productName) {
		String queryString = "SELECT COUNT(*) FROM Accessories a WHERE a.productName = :name";
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		Query<Long> query = session.createQuery(queryString, Long.class);
		query.setParameter("name", productName);
		Long count = query.uniqueResult();
		return count > 0;

	}

	@SuppressWarnings("deprecation")
	@Transactional
	public int getAccessoriesStock(String productName) {
		String queryString = "SELECT productStock FROM Accessories WHERE productName = :name";
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
        Query<String> query = session.createQuery(queryString, String.class);
        query.setParameter("name", productName);
        String stockString = query.uniqueResult();
        int stock = Integer.parseInt(stockString);
        return stock;
	}

	@SuppressWarnings({ "deprecation", "unchecked" })
	@Transactional
	public void updateAccessoriesStock(String productName, String newAccessoriesStock) {
		int oldStock=getAccessoriesStock(productName);
		System.out.println("old"+oldStock);
		int newStock=Integer.parseInt(newAccessoriesStock); 
		System.out.println("new"+newAccessoriesStock);
		int totalStock=oldStock+newStock;
		String stockString = Integer.toString(totalStock);
		System.out.println("total"+totalStock);
		String queryString = "UPDATE Accessories SET productStock = :newStock WHERE productName = :name";
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		Query<String> query = session.createQuery(queryString);
		query.setParameter("newStock", stockString);
		query.setParameter("name", productName);
		query.executeUpdate();
	}

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

}
