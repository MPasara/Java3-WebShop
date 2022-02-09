/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.servlets;

import hr.algebra.models.Bill;
import hr.algebra.models.Item;
import hr.algebra.models.User;
import hr.algebra.repository.Repository;
import hr.algebra.repository.SqlRepository;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
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
public class CashPaymentServlet extends HttpServlet {

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
            out.println("<title>Servlet CashPaymentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CashPaymentServlet at " + request.getContextPath() + "</h1>");
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
        try {
            //processRequest(request, response);
            HttpSession session = request.getSession();
            List<Item> cartItems = (List<Item>) session.getAttribute("cartItems");
            String total = request.getParameter("total");
            session.setAttribute("total", total);
            User user = (User) session.getAttribute("user");
            
            Bill bill = new Bill();
            bill.setDateOfPurchase(LocalDateTime.now());
            bill.setUserId(user.getId());
            bill.setPaymentMethod("Cash on delivery");
            bill.setTotal(Double.parseDouble(total));
            
            System.out.println(bill.toString());
            
            repo.createBill(bill);
            for (Item cartItem : cartItems) {
                repo.bindItemsWithBill(cartItem, bill);
            }
            
            session.setAttribute("bill", bill);
            
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cashPayment.jsp");
            dispatcher.forward(request, response);
            
            
        } catch (SQLException ex) {
            Logger.getLogger(CashPaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        //processRequest(request, response);
        System.out.println("cash payment post");
        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("user");
        session.setAttribute("user", user);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cashPayment.jsp");
        dispatcher.forward(request, response);
        //response.sendRedirect("cashPayment.jsp");

        //response.sendRedirect("cashPayment.jsp");
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
