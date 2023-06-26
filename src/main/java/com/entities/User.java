package com.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name = "user_details")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id")
	private int userId;
	@Column(name = "username", length = 150)
	private String username;
	@Column(name = "password", length = 150)
	private String password;

	@Column(name = "avatar")
	@Lob
	private byte[] Avatar;
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(int userId, String username, String password, byte[] avatar) {
		super();
		this.userId = userId;
		this.username = username;
		this.password = password;
		Avatar = avatar;
	}

	public User(String username, String password, byte[] avatar) {
		super();
		this.username = username;
		this.password = password;
		Avatar = avatar;
	}

	public User(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}

	public User(String password, byte[] avatar) {
		super();
		this.password = password;
		Avatar = avatar;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public byte[] getAvatar() {
		return Avatar;
	}

	public void setAvatar(byte[] avatar) {
		Avatar = avatar;
	}

}
