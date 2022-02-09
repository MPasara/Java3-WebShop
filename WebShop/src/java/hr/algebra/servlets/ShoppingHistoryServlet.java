/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.servlets;

import hr.algebra.models.Bill;
import hr.algebra.models.Item;
import hr.algebra.models.UserShoppingHistoryItem;
import hr.algebra.repository.Repository;
import hr.algebra.repository.SqlRepository;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mladen
 */
public class ShoppingHistoryServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ShoppingHistoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShoppingHistoryServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final Repository repo = new SqlRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            List<UserShoppingHistoryItem> completeShoppingHistoryList = repo.getCompleteShoppingHistory();
            session.setAttribute("completeShoppingHistoryList", completeShoppingHistoryList);
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingHistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        /*try {
            List<Bill> allBills = repo.getAllBills();
            session.setAttribute("allBills", allBills);
            List<Item> allBillItems = null;
            
            for (Bill bill : allBills) {
            allBillItems = repo.getAllBillItems(bill.getId());
            }
            session.setAttribute("allBillItems", allBillItems);
            System.out.println(allBills);
            } catch (SQLException ex) {
            Logger.getLogger(ShoppingHistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            response.sendRedirect("userShoppingHistory.jsp");*/
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/userShoppingHistory.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
