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

import com.entities.FishOrder;
import com.entities.TopSoldFish;

@SuppressWarnings("deprecation")
public class FishOrderDao {
	private HibernateTemplate hibernateTemplate;

	@SuppressWarnings({ "unchecked" })
	@Transactional
	public List<TopSoldFish> getTopFiveSoldFish() {
		final String hql = "SELECT f.fishName, COUNT(f.fishName) AS fishCount FROM FishOrder f GROUP BY f.fishName ORDER BY fishCount DESC";
		List<Object[]> results = this.hibernateTemplate.execute(new HibernateCallback<List<Object[]>>() {
			public List<Object[]> doInHibernate(Session session) throws HibernateException {
				Query<Object[]> query = session.createQuery(hql);
				query.setMaxResults(5);
				return query.list();
			}
		});

		List<TopSoldFish> topSoldFishList = new ArrayList<TopSoldFish>();
		for (Object[] obj : results) {
			TopSoldFish topSoldFish = new TopSoldFish();
			topSoldFish.setFishName(obj[0].toString());
			topSoldFish.setFishCount(Long.parseLong(obj[1].toString()));
			topSoldFishList.add(topSoldFish);
		}

		return topSoldFishList;
	}

	@Transactional
	public List<FishOrder> getAllFishOrders() {
		 String queryString = "FROM FishOrder fo ORDER BY fo.orderDate DESC";
		    Query<FishOrder> query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery(queryString, FishOrder.class);
		    List<FishOrder> fishOrders = query.getResultList();
		    return fishOrders;
	}

	@Transactional
	public void updateDeliveredStatus(Long orderId, String status) {
		FishOrder fishOrder = this.hibernateTemplate.get(FishOrder.class, orderId);
		fishOrder.setDeliveredStatus(status);
		hibernateTemplate.update(fishOrder);
	}

	@SuppressWarnings({ "unchecked", "deprecation" })
	@Transactional
	public List<FishOrder> getCheckoutFishDetails() {
		String queryString = "FROM FishOrder fo WHERE fo.checkoutStatus = 'checkout' AND fo.deliveredStatus = 'New Order' ORDER BY fo.orderDate DESC";
		List<FishOrder> fishOrders = (List<FishOrder>) hibernateTemplate.find(queryString);
		return fishOrders;
	}

	@Transactional
	public int countNewOrders() {
		String queryString = "SELECT COUNT(fo) FROM FishOrder fo WHERE fo.checkoutStatus = 'checkout' AND fo.deliveredStatus = 'New Order'";
		Long count = (Long) hibernateTemplate.find(queryString).get(0);
		return count.intValue();
	}

	/*
	 * public List<FishOrder> getCheckoutFishDetails() { String queryString =
	 * "FROM FishOrder fo WHERE fo.checkoutStatus = 'checkout' AND fo.deliveredStatus = 'New Order'"
	 * ; return (List<FishOrder>) hibernateTemplate.find(queryString); }
	 */
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
}
