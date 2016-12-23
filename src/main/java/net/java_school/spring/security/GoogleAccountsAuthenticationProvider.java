package net.java_school.spring.security;

import java.util.Set;
import java.util.logging.Logger;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class GoogleAccountsAuthenticationProvider implements AuthenticationProvider {
	
	private static final Logger log = Logger.getLogger(GoogleAccountsAuthenticationProvider.class.getName());
	
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		User googleUser = (User) authentication.getPrincipal();
		
		net.java_school.user.User user = new net.java_school.user.User(googleUser.getUserId(), googleUser.getEmail(), googleUser.getNickname());
		
		UserService userService = UserServiceFactory.getUserService();
		
		if (userService.isUserAdmin()) {
			//Set<AppRole> authorities = EnumSet.of(AppRole.ROLE_ADMIN);
			//user.setAuthorities(authorities);
			Set<AppRole> authorities = user.getAuthorities();
			authorities.add(AppRole.ROLE_ADMIN);
		}

		return new GaeUserAuthentication(user, authentication.getDetails());
	}

	public final boolean supports(Class<?> authentication) {
		return PreAuthenticatedAuthenticationToken.class.isAssignableFrom(authentication);
	}

}