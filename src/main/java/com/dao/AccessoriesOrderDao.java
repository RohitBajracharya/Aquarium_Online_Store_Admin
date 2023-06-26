package com.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate5.HibernateCallback;
import org.springframework.orm.hibernate5.HibernateTemplate;

import com.entities.AccessoriesOrder;
import com.entities.FishOrder;
import com.entities.TopSoldAccessories;


@SuppressWarnings("deprecation")
public class AccessoriesOrderDao {
	private HibernateTemplate hibernateTemplate;

	@Transactional
	  public List<TopSoldAccessories> getTopFiveSoldAccessories() {
	        final String hql = "SELECT a.productName, COUNT(a.productName) AS productCount FROM AccessoriesOrder a GROUP BY a.productName ORDER BY productCount DESC";
	        List<Object[]> results = hibernateTemplate.execute(new HibernateCallback<List<Object[]>>() {
	            @SuppressWarnings({ "rawtypes", "unchecked" })
				public List<Object[]> doInHibernate(Session session) throws HibernateException {
	                Query query = session.createQuery(hql);
	                query.setMaxResults(5);
	                return query.list();
	            }
	        });

	        List<TopSoldAccessories> topSoldAccessoriesList = new ArrayList<TopSoldAccessories>();
	        for (Object[] obj : results) {
	            TopSoldAccessories topSoldAccessories = new TopSoldAccessories();
	            topSoldAccessories.setProductName(obj[0].toString());
	            topSoldAccessories.setProductCount(Long.parseLong(obj[1].toString()));
	            topSoldAccessoriesList.add(topSoldAccessories);
	        }

	        return topSoldAccessoriesList;
	    }
	
	@Transactional
	public void updateDeliveredStatus(Long orderId, String status) {
		AccessoriesOrder accessoriesOrder = this.hibernateTemplate.get(AccessoriesOrder.class, orderId);
		accessoriesOrder.setDeliveredStatus(status);
		hibernateTemplate.update(accessoriesOrder);
	}
	
	@SuppressWarnings({ "unchecked", "deprecation" })
	@Transactional
	public List<AccessoriesOrder> getCheckoutAccessoriesDetails() {
		  String queryString = "FROM AccessoriesOrder fo WHERE fo.checkoutStatus = 'checkout' AND fo.deliveredStatus = 'New Order' ORDER BY fo.orderDate DESC";
		    List<AccessoriesOrder> accessoriesOrders = (List<AccessoriesOrder>) hibernateTemplate.find(queryString);
		    return accessoriesOrders;
	}
	
	@SuppressWarnings({ "unchecked", "deprecation" })
	@Transactional
	public int countNewAccessoriesOrders() {
		String queryString = "SELECT COUNT(ao) FROM AccessoriesOrder ao WHERE ao.checkoutStatus = 'checkout' AND ao.deliveredStatus = 'New Order'";
		Long count = (Long) this.hibernateTemplate.find(queryString).get(0);
		return count.intValue();
		}

	@Transactional
	public List<AccessoriesOrder> getAllAccessoriesOrders() {
		 String queryString = "FROM AccessoriesOrder fo ORDER BY fo.orderDate DESC";
		    List<AccessoriesOrder> accessoriesOrders = (List<AccessoriesOrder>) hibernateTemplate.find(queryString);
		    return accessoriesOrders;
	}
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
}
