package vn.customer.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vn.service.ProductService;
import vn.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {"/header"})
public class HeaderController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*
		 * ProductService productService = new ProductServiceImpl(); int countP =
		 * productService.getTotalProduct(); int endPage=countP/3; if(countP%3!=0) {
		 * endPage++; } req.setAttribute("endPage",endPage); RequestDispatcher rq
		 * =req.getRequestDispatcher("/WEB-INF/common/customer/header.jsp");
		 * rq.forward(req, resp);
		 */
	}
	
}
