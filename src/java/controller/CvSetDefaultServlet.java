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

@WebServlet("/cv/default")
public class CvSetDefaultServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) {
            resp.sendRedirect(req.getContextPath() + "/cv/list");
            return;
        }

        int cvid = Integer.parseInt(req.getParameter("cvid"));
        new CvDAO().setDefault(jobSeekerId, cvid);

        resp.sendRedirect(req.getContextPath() + "/cv/list");
    }
}


