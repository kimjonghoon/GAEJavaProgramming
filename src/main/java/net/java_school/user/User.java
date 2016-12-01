package net.java_school.user;

import java.io.Serializable;
import java.util.EnumSet;
import java.util.Set;

import net.java_school.spring.security.AppRole;

@SuppressWarnings("serial")
public class User implements Serializable {
	private String email;
	private Set<AppRole> authorities;
	
	public User() {}
	
	public User(String email) {
		this.email = email;
		Set<AppRole> roles = EnumSet.of(AppRole.ROLE_USER);
		this.authorities = roles;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Set<AppRole> getAuthorities() {
		return authorities;
	}

	public void setAuthorities(Set<AppRole> authorities) {
		this.authorities = authorities;
	}
	
}