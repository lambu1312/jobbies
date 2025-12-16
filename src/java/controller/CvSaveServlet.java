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
import model.CV;
import utils.AuthUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/cv/save")
public class CvSaveServlet extends HttpServlet {
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

        String cvidRaw = req.getParameter("cvid");
        CV cv = new CV();
        cv.setJobSeekerId(jobSeekerId);

        cv.setTitle(req.getParameter("title"));
        cv.setTemplateCode(req.getParameter("template"));
        cv.setSummary(req.getParameter("summary"));
        cv.setSkills(req.getParameter("skills"));
        cv.setLinks(req.getParameter("links"));

        CvDAO dao = new CvDAO();

        if (cvidRaw == null || cvidRaw.isBlank()) {
            cv.setIsDefault(false);
            int newId = dao.insert(cv);
            resp.sendRedirect(req.getContextPath() + "/cv/edit?cvid=" + newId);
        } else {
            cv.setCvId(Integer.parseInt(cvidRaw));
            dao.update(cv);
            resp.sendRedirect(req.getContextPath() + "/cv/edit?cvid=" + cv.getCvId() + "&saved=1");
        }
    }
}

