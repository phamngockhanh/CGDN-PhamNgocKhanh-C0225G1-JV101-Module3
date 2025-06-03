package com.nhom2.calculator1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Objects;

@WebServlet(urlPatterns = "/calculator")
public class CaculateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("calculator.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        double firstOperand = Double.parseDouble(req.getParameter("first_operand"));
        String operator = req.getParameter("operation");
        double secondOperand = Double.parseDouble(req.getParameter("second_operand"));
        double result;
        if (Objects.equals(operator, "+")) {
            result = firstOperand + secondOperand;
        } else if (Objects.equals(operator, "-")) {
            result = firstOperand - secondOperand;
        } else if (Objects.equals(operator, "*")) {
            result = firstOperand * secondOperand;
        } else {
            result = firstOperand / secondOperand;
        }
        resp.setContentType("text/html");
        PrintWriter pw = resp.getWriter();
        pw.println("<h2> Kết quả:  " + result + "</h2>");

    }
}
