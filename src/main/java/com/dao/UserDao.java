package com.dao;

import java.util.List;

import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.orm.hibernate5.HibernateTemplate;


import com.entities.User;

public class UserDao {
	private HibernateTemplate hibernateTemplate;
	// insert data
	@Transactional
	public int insert(User user) {
		Integer i = (Integer) this.hibernateTemplate.save(user);
		return i;
	}

	// updating the data
	@Transactional
	public void updateUser(User user) {
		this.hibernateTemplate.update(user);
	}
	// get single data(object)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional
	public int getUser(User user) {
	    String queryString = "FROM User WHERE username = :username AND password = :password";
	    Query query = this.hibernateTemplate.getSessionFactory().getCurrentSession().createQuery(queryString);
	    query.setParameter("username", user.getUsername());
	    query.setParameter("password", user.getPassword());
	    List<User> userList = (List<User>) ((org.hibernate.query.Query) query).list();
	    if (userList != null && !userList.isEmpty()) {
	        return 1;
	    }
	    return 0;
	}



	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
}
