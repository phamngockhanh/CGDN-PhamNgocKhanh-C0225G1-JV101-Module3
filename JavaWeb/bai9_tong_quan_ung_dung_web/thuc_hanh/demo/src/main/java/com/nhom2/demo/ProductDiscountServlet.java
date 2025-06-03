package com.nhom2.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/listProduct")
public class ProductDiscountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productDes = req.getParameter("product-description");
        float price = Float.parseFloat(req.getParameter("price"));
        float discount = Float.parseFloat(req.getParameter("discount-percent"));
        double discountPrice = price * discount * 0.01;

        // Tính giảm giá
        double finalPrice = price - discountPrice;

        // Cấu hình phản hồi là HTML
        resp.setContentType("text/html;charset=UTF-8");

        // Ghi ra kết quả
        PrintWriter out = resp.getWriter();
        out.println("<html>");
        out.println("<head><title>Kết quả giảm giá</title></head>");
        out.println("<body>");
        out.println("<h2>Kết quả giảm giá:</h2>");
        out.println("<p><strong>Mô tả sản phẩm:</strong> " + productDes + "</p>");
        out.println("<p><strong>Giá gốc:</strong> $" + price + "</p>");
        out.println("<p><strong>Tỷ lệ giảm giá:</strong> " + discount + "%</p>");
        out.println("<p><strong>Số tiền được giảm:</strong> $" + String.format("%.2f", discountPrice) + "</p>");
        out.println("<p><strong>Giá sau giảm:</strong> $" + String.format("%.2f", finalPrice) + "</p>");
        out.println("</body>");
        out.println("</html>");

    }
}
