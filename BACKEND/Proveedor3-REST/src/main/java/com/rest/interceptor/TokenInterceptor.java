package com.rest.interceptor;


import java.util.HashMap;
import java.util.Map;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@Component
public class TokenInterceptor implements HandlerInterceptor {
/*
    @Autowired
    private JdbcTemplate jdbcTemplate;*/

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String token = request.getHeader("Authorization");
        if (!isTokenValid(token.substring(7))) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }



        return true;
    }

    private boolean isTokenValid(String token1) {

        if (token1.equals("token987654")) {
            return true;  
        } else {
		return false;
        }
    }
}
