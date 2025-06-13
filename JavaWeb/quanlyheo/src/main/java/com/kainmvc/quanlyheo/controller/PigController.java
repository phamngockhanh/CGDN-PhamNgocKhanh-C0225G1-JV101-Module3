package com.kainmvc.quanlyheo.controller;

import com.kainmvc.quanlyheo.entity.Manufacture;
import com.kainmvc.quanlyheo.entity.Pig;
import com.kainmvc.quanlyheo.service.IManufactureService;
import com.kainmvc.quanlyheo.service.IPigService;
import com.kainmvc.quanlyheo.service.ManufatureSerivce;
import com.kainmvc.quanlyheo.service.PigService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


@WebServlet(urlPatterns = "/pig")
public class PigController extends HttpServlet {
    private static IPigService iPigService = new PigService();
    private static IManufactureService iManufactureService = new ManufatureSerivce();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "delete":
                break;
            case "update":
                updateDirect(req, resp);
                break;
            default:
                listPig(req, resp);
                break;
        }
    }

    private void updateDirect(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Pig pig = iPigService.getPigById(id);
        req.setAttribute("pig", pig);
        List<Manufacture> manufactures = iManufactureService.findAll();
        req.setAttribute("manufactures", manufactures);
        req.getRequestDispatcher("view/editPig.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "update":
                updatePig(req, resp);
                break;
            case "delete":
                deletePig(req, resp);
                break;
            default:
                listPig(req, resp);
                break;
        }
    }

    private void deletePig(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String deleteId = req.getParameter("deleteId");
        iPigService.delete(deleteId);
        resp.sendRedirect("/pig?mess=Delete success");
    }

    private void listPig(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pigId = req.getParameter("pigId");
        if(pigId==null){
            pigId = "";
        }
        int idManu = 0;
        int status = -1;
        int limit = 0;
        String idManuParam = req.getParameter("manufactureId");
        if (idManuParam != null) {
            idManu = Integer.parseInt(idManuParam);
        }

        String statusParam = req.getParameter("status");
        if (statusParam != null) {
            status = Integer.parseInt(statusParam);
        }

        String limitParam = req.getParameter("limit");
        if(limitParam !=null){
            limit = Integer.parseInt(limitParam);
        }
        //List<Pig> pigs = iPigService.search(pigId, idManu, status);
        List<Pig> pigs = iPigService.search2(pigId, idManu, status,limit);
        List<Manufacture> manufactures = iManufactureService.findAll();
        req.setAttribute("manufactures", manufactures);
        req.setAttribute("pigs", pigs);
        req.setAttribute("manufactureId",idManu);
        req.setAttribute("status",status);
        req.setAttribute("pigId",pigId);
        req.setAttribute("limit",limit);
        req.getRequestDispatcher("view/listPig.jsp").forward(req, resp);
    }

    private void updatePig(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String timeIn = req.getParameter("timeIn");
        String timeOut = req.getParameter("timeOut");
        double weigthIn = Double.parseDouble(req.getParameter("weightIn"));
        double weigthOut = Double.parseDouble(req.getParameter("weigthOut"));
        int manufactureId = Integer.parseInt(req.getParameter("manufactureId"));
        boolean status;
        if (!timeOut.isEmpty()) {
            status = true;
        } else {
            status = false;
        }
        Pig pig = new Pig(id, timeIn, timeOut, weigthIn, weigthOut, manufactureId, status);
        boolean isUpdated = iPigService.update(pig);
        String mess = "update success";
        if (!isUpdated) {
            mess = "update fail";
        }
        resp.sendRedirect("/pig?mess=" + mess);
    }
}
