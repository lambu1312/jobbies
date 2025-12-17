/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.Account;

public class AuthUtil {
    public static Account getLoggedAccount(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        if (s == null) return null;

        Object a = s.getAttribute("account"); // bạn đang dùng tên khác thì đổi tại đây
        if (a instanceof Account) return (Account) a;

        // fallback nếu bạn đang dùng "acc"
        a = s.getAttribute("acc");
        if (a instanceof Account) return (Account) a;

        return null;
    }
}

