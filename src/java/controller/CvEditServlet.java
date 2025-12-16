package controller;

import dao.CvDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;
import model.CV;
import model.JobSeekers;   // nhớ import model này
import utils.AuthUtil;

@WebServlet("/cv/edit")
public class CvEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        JobSeekerDAO jsDao = new JobSeekerDAO();

        // ✅ Lấy JobSeekerId; nếu chưa có thì tự tạo
        Integer jobSeekerId = jsDao.findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) {
            JobSeekers js = new JobSeekers();
            js.setAccountID(acc.getId());
            jobSeekerId = jsDao.insertAndReturnId(js); // bạn cần thêm hàm này
        }

        String cvidRaw = req.getParameter("cvid");
        CV cv = null;

        if (cvidRaw != null && !cvidRaw.isBlank()) {
            int cvid = Integer.parseInt(cvidRaw);
            cv = new CvDAO().getById(cvid, jobSeekerId);

            // nếu cvid không thuộc về user này -> quay về list
            if (cv == null) {
                resp.sendRedirect(req.getContextPath() + "/cv/list");
                return;
            }
        }

        req.setAttribute("cv", cv);       // null = tạo mới
        req.setAttribute("account", acc);

        // ⚠️ đường dẫn JSP phải đúng thư mục thật của bạn:
        // nếu bạn đang dùng /views/... thì đổi lại cho khớp
        req.getRequestDispatcher("/view/cv_edit.jsp").forward(req, resp);
    }
}
