package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;
import utils.AuthUtil;

@WebServlet("/cv/create")
public class CvCreateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) { resp.sendRedirect(req.getContextPath() + "/login"); return; }
        req.getRequestDispatcher("/view/user/cv_create.jsp").forward(req, resp);
    }
}
