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
import java.util.List;

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
                listCategory(req,resp);
                break;
            case "update":
                updateDirect(req,resp);
                break;
            case "delete":
                break;
            case "filter":
                listProductFilter(req, resp);
                break;
            default:
                pagination(req,resp);
                break;
        }

    }

    private void pagination(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageNumber = 1;
        int pageSize = 5;

        String pageParam= req.getParameter("pageNumber");

        if (pageParam != null) {
            pageNumber = Integer.parseInt(pageParam);
            try()

        }

        int offset = (pageNumber - 1) * pageSize;
        List<Product> products = productService.findAllWithPagination(offset,pageSize);
        int totalProducts = productService.countProduct();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
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
                updateProduct(req,resp);
                break;
            case "delete":
                deleteProduct(req,resp);
                break;
        }
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
        Product product = new Product(id,productName,releaseYear,price,quantity,manufacturer,status,categoryId);
        boolean isUpdated =  productService.update(product);
        String mess = "update success";
        if(!isUpdated){
            mess="update fail";
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

    private void listProductFilter(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = productService.findByName(req.getParameter("keyword"));
        req.setAttribute("products", products);
        req.getRequestDispatcher("view/listProduct.jsp").forward(req, resp);
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String productName = req.getParameter("computerName");
        int releaseYear = Integer.parseInt(req.getParameter("releaseYear"));
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String manufacturer = req.getParameter("manufacturer");
        boolean status = Boolean.parseBoolean(req.getParameter("status"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        Product product = new Product(productName,releaseYear,price,quantity,manufacturer,status,categoryId);
        boolean isAdded =  productService.add(product);
        String mess = "create success";
        if(!isAdded){
            mess="create fail";
        }
        resp.sendRedirect("product?mess="+mess);

    }

}
