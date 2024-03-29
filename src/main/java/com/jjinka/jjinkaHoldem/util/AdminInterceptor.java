package com.jjinka.jjinkaHoldem.util;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class AdminInterceptor extends HandlerInterceptorAdapter {
    // preHandle() 메서드 재정의
    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws IOException {

        // 세션을 체크 (authUser가 null인지)
        if (req.getSession().getAttribute("adminId") == null) { // 비로그인상태
            res.setContentType("text/html; charset=utf-8");
            PrintWriter out = res.getWriter();
            out.print("<script>");
            out.print("alert('로그인 후 사용가능합니다.');");
            out.print("location.href='/alphaAdmin/login';");
            out.print("</script>");
            out.flush();
            return false;
        }
        return true; // 기존 매핑된 URL의 컨트롤러로 전달
    }
}
