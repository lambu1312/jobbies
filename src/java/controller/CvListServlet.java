/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CvDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;
import utils.AuthUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/cv/list")
public class CvListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) {
            req.setAttribute("error", "Bạn chưa có JobSeeker profile.");
            req.getRequestDispatcher("/view/usercv_list.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("cvs", new CvDAO().listByJobSeeker(jobSeekerId));
        req.getRequestDispatcher("/view/user/cv_list.jsp").forward(req, resp);
    }
}



