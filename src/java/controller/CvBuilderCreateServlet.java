/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author faker
 */


import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;
import utils.AuthUtil;

@WebServlet("/cv/builder/create")
public class CvBuilderCreateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) { resp.sendRedirect(req.getContextPath() + "/login"); return; }

        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) { resp.sendRedirect(req.getContextPath() + "/cv/list"); return; }

        // Chuyển sang JSP tạo mới chuyên biệt cho Builder
        req.getRequestDispatcher("/view/user/cv_builder_create.jsp").forward(req, resp);
    }
}
