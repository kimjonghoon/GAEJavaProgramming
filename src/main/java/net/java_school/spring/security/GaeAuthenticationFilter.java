package net.java_school.spring.security;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.web.filter.GenericFilterBean;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserServiceFactory;

public class GaeAuthenticationFilter extends GenericFilterBean {
	//private static final String REGISTRATION_URL = "/users/register";
	private AuthenticationDetailsSource<HttpServletRequest, WebAuthenticationDetails> ads = new WebAuthenticationDetailsSource();
	private AuthenticationManager authenticationManager;
	private AuthenticationFailureHandler failureHandler = new SimpleUrlAuthenticationFailureHandler();
	private static final Logger log = Logger.getLogger(GaeAuthenticationFilter.class.getName());

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication == null) {
			// User isn't authenticated. Check if there is a Google Accounts user
			User googleUser = UserServiceFactory.getUserService().getCurrentUser();

			if (googleUser != null) {
				// User has returned after authenticating through GAE. Need to authenticate to Spring Security.
				PreAuthenticatedAuthenticationToken token = new PreAuthenticatedAuthenticationToken(googleUser, null);
				token.setDetails(ads.buildDetails((HttpServletRequest) request));

				try {
					authentication = authenticationManager.authenticate(token);
					// Setup the security context
					SecurityContextHolder.getContext().setAuthentication(authentication);
					// Send new users to the registration page.
					/*
					if (authentication.getAuthorities().contains(AppRole.ROLE_GOOGLE)) {
						((HttpServletResponse) response).sendRedirect(REGISTRATION_URL);
						return;
					}
					*/
				} catch (AuthenticationException e) {
					// Authentication information was rejected by the authentication manager
					failureHandler.onAuthenticationFailure((HttpServletRequest)request, (HttpServletResponse)response, e);
					return;
				}
			}
		}

		chain.doFilter(request, response);
	}

	public void setAuthenticationManager(AuthenticationManager authenticationManager) {
		this.authenticationManager = authenticationManager;
	}

	public void setFailureHandler(AuthenticationFailureHandler failureHandler) {
		this.failureHandler = failureHandler;
	}
}