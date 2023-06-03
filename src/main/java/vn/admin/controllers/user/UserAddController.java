package vn.admin.controllers.user;

import java.io.File; 
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher; 
import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import vn.models._User; 
import vn.service._UserService; 
import vn.service.impl._UserServiceImpl;
import vn.util.Constant;

@WebServlet(urlPatterns = ("/admin/user/add"))
public class UserAddController extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	_UserService userService = new _UserServiceImpl();
	
	private static final String CSRF_TOKEN_NAME = "csrfToken";
	private static final String SECRET_KEY = UUID.randomUUID().toString();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String token = generateToken();
		
		req.getSession().setAttribute(CSRF_TOKEN_NAME, token);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/admin/user/user_add.jsp");
		dispatcher.forward(req, resp);
	}
	
	private String generateToken() {
		long timestamp = System.currentTimeMillis();
		
		String data = timestamp + SECRET_KEY;
		
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(data.getBytes());
			
			return Base64.getUrlEncoder().withoutPadding().encodeToString(hash);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		_User user = new _User();
		
		HttpSession session = req.getSession();
		
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
		servletFileUpload.setHeaderEncoding("UTF-8");
		
		String CSRFTokenFromRequest = "";
		String CSRFTokenFromSession = (String) session.getAttribute(CSRF_TOKEN_NAME);
		
		try {
			resp.setContentType("text/html");
			resp.setCharacterEncoding("UTF-8");
			req.setCharacterEncoding("UTF-8");
			List<FileItem> items = servletFileUpload.parseRequest(req);
			for (FileItem item : items) {
				if (item.getFieldName().equals("firstname")) {
					user.setFirstname(item.getString("UTF-8"));
				} else if (item.getFieldName().equals("lastname")) {
					user.setLastname(item.getString("UTF-8"));
				} else if (item.getFieldName().equals("id_card")) {
					user.setId_card(item.getString("UTF-8"));
				} else if (item.getFieldName().equals("salt")) {
					user.setSalt(item.getString("UTF-8"));
				} else if (item.getFieldName().equals("hashed_password")) {
					user.setHashed_password(item.getString("UTF-8"));
				} else if (item.getFieldName().equals("_role")) {
					user.set_role(item.getString("UTF-8"));
				} else if (item.getFieldName().equals("addresses")) {
					user.setAddresses(item.getString("UTF-8"));
				} else if (item.getFieldName().equals("phone")) {
					user.setPhone(item.getString("UTF-8"));
				} else if (item.getFieldName().equals("email")) {
					user.setEmail(item.getString("UTF-8"));
				} else if (item.getFieldName().equals("avatar")) {
					if (item.getSize() > 0) {
						String originalFileName = item.getName();
						int index = originalFileName.lastIndexOf(".");
						String ext = originalFileName.substring(index + 1);
						String fileName = System.currentTimeMillis() + "." + ext;
						File file = new File(Constant.DIR + "/user/" + fileName);
						item.write(file);
						user.setAvatar("user/" + fileName);
					} else {
						user.setAvatar(null);
					}
				} else if (item.getFieldName().equals("csrfToken")) {
					CSRFTokenFromRequest = item.getString("UTF-8");
					
				}
			}
			
			if (CSRFTokenFromRequest.equals(null) || !CSRFTokenFromSession.equals(CSRFTokenFromRequest)) {
				resp.sendError(HttpServletResponse.SC_FORBIDDEN);
			} else {
				userService.insert(user);
				resp.sendRedirect(req.getContextPath() + "/admin/user");
			}
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
