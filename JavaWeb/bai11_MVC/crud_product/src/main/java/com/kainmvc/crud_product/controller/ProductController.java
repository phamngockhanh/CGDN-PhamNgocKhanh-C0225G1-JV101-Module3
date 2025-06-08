package com.kainmvc.crud_product.controller;


import com.kainmvc.crud_product.entity.Category;
import com.kainmvc.crud_product.entity.Product;
import com.kainmvc.crud_product.sevice.CategoryService;
import com.kainmvc.crud_product.sevice.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductController", urlPatterns = "/product")
public class ProductController extends HttpServlet {
    private static ProductService productService = new ProductService();
    private static CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                listCategory(req, resp);
                break;
            case "update":
                updateDirect(req, resp);
                break;
            case "delete":
                break;
            default:
                pagination(req, resp);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        switch (action) {
            case "create":
                addProduct(req, resp);
                break;
            case "update":
                updateProduct(req, resp);
                break;
            case "delete":
                deleteProduct(req, resp);
                break;
        }
    }

    private void pagination(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageNumber = 1;
        int pageSize = 5;

        String pageParam = req.getParameter("pageNumber");
        String categoryParam = req.getParameter("categoryId");
        String keyword = req.getParameter("keyword") != null ? req.getParameter("keyword").trim() : "";
        int categoryId = 0;
        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryParam);
            } catch (NumberFormatException e) {
                categoryId = 0;
            }
        }
        int totalProducts;
        if (categoryId == 0 && keyword.isEmpty()) {
            totalProducts = productService.countProduct();
        } else {
            totalProducts = productService.countProductWithFilter(keyword, categoryId);
        }
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPages == 0) {
            totalPages = 1;
        }
        if (pageParam != null) {
            try {
                pageNumber = Integer.parseInt(pageParam);
                if (pageNumber > totalPages) {
                    pageNumber = 1;
                }
            } catch (NumberFormatException e) {
                pageNumber = 1;
            }
        }

        List<Category> categories = categoryService.findAll();
        req.setAttribute("categories", categories);

        int offset = (pageNumber - 1) * pageSize;
        List<Product> products;
        if (categoryId == 0 && keyword.isEmpty()) {
            products = productService.findAllWithPagination(offset, pageSize);
        } else {
            products = productService.search(keyword, categoryId, offset, pageSize);
        }

        req.setAttribute("products", products);
        req.setAttribute("currentPage", pageNumber);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalPages", totalPages);

        req.setAttribute("selectedCategoryId", categoryId);
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("view/listProduct.jsp").forward(req, resp);


    }

    private void listProductFilter(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageNumber = 1;
        int pageSize = 5;

        String pageParam = req.getParameter("pageNumber");
        int totalProducts = productService.countProduct();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (pageParam != null) {
            try {
                pageNumber = Integer.parseInt(pageParam);
                if (pageNumber > totalPages) {
                    pageNumber = 1;
                }
            } catch (NumberFormatException e) {
                pageNumber = 1;
            }
        }

        List<Category> categories = categoryService.findAll();
        req.setAttribute("categories", categories);

        int offset = (pageNumber - 1) * pageSize;
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        String inputProductName = req.getParameter("keyword");
        List<Product> products = productService.search(inputProductName, categoryId, offset, pageSize);
        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.setAttribute("selectedCategoryId", categoryId);
        req.setAttribute("inputProductName", inputProductName);
        req.setAttribute("products", products);
        req.setAttribute("currentPage", pageNumber);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("view/listProduct.jsp").forward(req, resp);
    }

    private void updateDirect(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Product product = productService.getProductById(Integer.parseInt(id));
        req.setAttribute("product", product);
        List<Category> categories = categoryService.findAll();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("view/updateProduct.jsp").forward(req, resp);
    }


    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String productName = req.getParameter("computerName");
        int releaseYear = Integer.parseInt(req.getParameter("releaseYear"));
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String manufacturer = req.getParameter("manufacturer");
        boolean status = Boolean.parseBoolean(req.getParameter("status"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        Product product = new Product(id, productName, releaseYear, price, quantity, manufacturer, status, categoryId);
        boolean isUpdated = productService.update(product);
        String mess = "update success";
        if (!isUpdated) {
            mess = "update fail";
        }
        resp.sendRedirect("/product?mess=" + mess);
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int deleteId = Integer.parseInt(req.getParameter("deleteId"));
        productService.delete(deleteId);
        resp.sendRedirect("/product?mess=Delete success");
    }

    private void listProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = productService.findAll();
        req.setAttribute("products", products);
        req.getRequestDispatcher("view/listProduct.jsp").forward(req, resp);
    }

    private void listCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.findAll();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("view/createProduct.jsp").forward(req, resp);
    }


    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Map<String, String> error = new HashMap<>();
        String productName = req.getParameter("computerName");
        int releaseYear = 0;
        try{
           releaseYear = Integer.parseInt(req.getParameter("releaseYear"));
        }catch (NumberFormatException ex){
            ex.printStackTrace();
        }
        double price = 0;
        try{
            price = Double.parseDouble(req.getParameter("price"));
        }catch (NumberFormatException ex){
            ex.printStackTrace();
        }
        int quantity = 0;
        try{
            quantity = Integer.parseInt(req.getParameter("quantity"));
        }catch (NumberFormatException ex){
            ex.printStackTrace();
        }
        String manufacturer = req.getParameter("manufacturer");
        boolean status = Boolean.parseBoolean(req.getParameter("status"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        Product product = new Product(productName, releaseYear, price, quantity, manufacturer, status, categoryId);
         error = productService.add(product);
        if(error.isEmpty()){
            req.getSession().setAttribute("successMessage", "Tạo sản phẩm thành công!");
            resp.sendRedirect("product");
        }else{
            req.setAttribute("error",error);
            req.setAttribute("product",product);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/view/createProduct.jsp").forward(req,resp);
        }

    }

}
