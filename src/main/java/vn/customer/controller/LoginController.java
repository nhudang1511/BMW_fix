package vn.customer.controller;

import java.io.Console;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;

import vn.dao.*;
import vn.models.*;

@WebServlet(urlPatterns = { "/login" })
public class LoginController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//resp.sendRedirect("views/login.jsp");
		RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/views/customer/login.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		String username = req.getParameter("user");
		String password = req.getParameter("pass");
		UserDao userDao = new UserDao();
		CartDao cartDao = new CartDao();
		_User account = userDao.login(username, password);
		if(account==null)
		{
			req.setAttribute("error", "Thông tin username hoặc password bị sai, vui lòng nhập lại");
			RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/views/customer/login.jsp");
			rd.forward(req, resp);
		}
		else
		{
			HttpSession session = req.getSession();
			session.setAttribute("account", account);
//			Cookie sessionCookie = new Cookie("JSESSIONID", session.getId());

//			sessionCookie.setSecure(true);
//			sessionCookie.setPath("/");
//			sessionCookie.setHttpOnly(true);
////			resp.addCookie(sessionCookie);			
//			String cookieString = sessionCookie.getName() + "=" + sessionCookie.getValue() + "; Secure; HttpOnly; SameSite=Strict";
//			resp.setHeader("Set-Cookie", cookieString);
//			resp.setHeader("X-Content-Type-Options", "nosniff");
//			resp.addHeader("Set-Cookie", "cookieName=cookieValue; Secure; HttpOnly; SameSite=Strict");

			String s = account.get_role();
			if(s.equals("Admin"))
				resp.sendRedirect(req.getContextPath() + "/admin/dashboard/revenue");
			else if(s.equals("Staff"))
				resp.sendRedirect(req.getContextPath() + "/seller/home");
			else {
				if(cartDao.findcartId(account.get_id()) == -1) {
					cartDao.addCart(account);
				}
				resp.sendRedirect("home"); }
		}
		
	}

}
