package controller;

import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;
import utils.AuthUtil;

@WebServlet("/cv/builder-add") // Đường dẫn mới để không trùng với /cv/create
public class CvBuilderAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) { resp.sendRedirect(req.getContextPath() + "/login"); return; }

        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) { resp.sendRedirect(req.getContextPath() + "/cv/list"); return; }

        // Forward sang trang JSP chuyên biệt cho tạo mới
        req.getRequestDispatcher("/view/user/cv_builder_add.jsp").forward(req, resp);
    }
}