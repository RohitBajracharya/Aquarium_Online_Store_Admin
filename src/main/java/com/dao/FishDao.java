package com.dao;

import java.util.ArrayList;
import java.util.List;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate5.HibernateTemplate;
import com.entities.Fish;

public class FishDao {
	private HibernateTemplate hibernateTemplate;

	// insert data
	@Transactional
	public int insert(Fish fish) {
		Integer i = (Integer) this.hibernateTemplate.save(fish);
		return i;
	}

	// deleting the data
	@Transactional
	public void deleteFish(int fishId) {
		Fish fish = this.hibernateTemplate.get(Fish.class, fishId);
		this.hibernateTemplate.delete(fish);
	}

	// updating the data
	@Transactional
	public void updateFish(Fish fish) {
		this.hibernateTemplate.update(fish);
	}

	// retrieve all data
	public List<Fish> getAllFishes() {
		List<Fish> fishes = this.hibernateTemplate.loadAll(Fish.class);
		return fishes;
	}

	// get single data(object)
	public Fish getFish(int fishId) {
		Fish fish = this.hibernateTemplate.get(Fish.class, fishId);
		return fish;
	}

	@SuppressWarnings({ "deprecation", "unchecked" })
	public List<String> getTopFiveSoldFishNames() {
		List<String> topFiveFishNames = new ArrayList<String>();

		String query = "SELECT f.fishName FROM Fish f ORDER BY f.fishSalesCount DESC";
		List<String> fishNames = (List<String>) hibernateTemplate.find(query);

		if (fishNames.size() > 5) {
			topFiveFishNames = fishNames.subList(0, 5);
		} else {
			topFiveFishNames = fishNames;
		}

		return topFiveFishNames;
	}

	@SuppressWarnings({ "unchecked", "deprecation" })
	@Transactional
	public byte[] getFishImage(String fishName) {
		String hql = "select f.fishImage from Fish f where f.name = ?";
		List<byte[]> results = (List<byte[]>) hibernateTemplate.find(hql, fishName);
		if (results != null && !results.isEmpty()) {
			return results.get(0);
		}
		return null;
	}

	@Transactional
	@SuppressWarnings({ "deprecation", "unchecked" })
	public boolean isFishNameExists(String fishName) {
		String queryString = "SELECT COUNT(*) FROM Fish f WHERE f.fishName = :name";
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		Query<Long> query = session.createQuery(queryString, Long.class);
		query.setParameter("name", fishName);
		Long count = query.uniqueResult();
		return count > 0;

	}

	@SuppressWarnings("deprecation")
	@Transactional
	public int getFishStock(String fishName) {
		String queryString = "SELECT fishStock FROM Fish WHERE fishName = :name";
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
        Query<String> query = session.createQuery(queryString, String.class);
        query.setParameter("name", fishName);
        String stockString = query.uniqueResult();
        int stock = Integer.parseInt(stockString);
        return stock;
	}

	@SuppressWarnings({ "deprecation", "unchecked" })
	@Transactional
	public void updateFishStock(String fishName, String newFishStock) {
		int oldStock=getFishStock(fishName);
		System.out.println("old"+oldStock);
		int newStock=Integer.parseInt(newFishStock); 
		System.out.println("new"+newFishStock);
		int totalStock=oldStock+newStock;
		String stockString = Integer.toString(totalStock);
		System.out.println("total"+totalStock);
		String queryString = "UPDATE Fish SET fishStock = :newStock WHERE fishName = :name";
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		Query<String> query = session.createQuery(queryString);
		query.setParameter("newStock", stockString);
		query.setParameter("name", fishName);
		query.executeUpdate();
	}

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

}
