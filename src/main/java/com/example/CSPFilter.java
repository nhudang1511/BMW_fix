package com.example;
import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

public class CSPFilter implements Filter{
	@Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo cấu hình filter (nếu cần)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
    	
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        httpResponse.setHeader("Content-Security-Policy", "default-src 'self'; script-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com https://maxcdn.bootstrapcdn.com; style-src 'self' https://maxcdn.bootstrapcdn.com; img-src 'self' https://www.asama-bike.com;");
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Dọn dẹp tài nguyên (nếu cần)
    }
}
