/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.servlets;

import hr.algebra.models.Item;
import hr.algebra.repository.Repository;
import hr.algebra.repository.SqlRepository;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mladen
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String idItem = request.getParameter("idItem");

        List<Item> cartItems = (List<Item>) session.getAttribute("cartItems");

        //DELETE!!!!!!!!
        if (idItem != null) {
            removeItemFromCart(Integer.parseInt(idItem), session);
            //session.setAttribute("amount", itemAmount);
        }
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/shoppingCart.jsp");
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
    private final Repository repo = new SqlRepository();
    private String itemAmount;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        String idItem = request.getParameter("idItem");
        String amount = request.getParameter("amount");

        itemAmount = amount;

        if (idItem != null && amount != null) {
            List<Item> cartItems = addItemsToCart(Integer.parseInt(idItem), Integer.parseInt(amount), session);
            session.setAttribute("cartItems", cartItems);
            session.setAttribute("amount", itemAmount);
        }

    }

    public List<Item> addItemsToCart(int itemId, int amount, HttpSession session) {
        System.out.println("made it to cart servlet with values: " + itemId + " " + amount);

        List<Item> cartItems = (List<Item>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }
        try {
            Item repoItem = repo.getItemsById(itemId);
            if (repoItem != null) {
                cartItems.add(repoItem);
            }
            System.out.println("");
        } catch (SQLException ex) {
            Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        return cartItems;
    }

    private void removeItemFromCart(int idItem, HttpSession session) {
        List<Item> cartItems = (List<Item>) session.getAttribute("cartItems");
        List<Item> tempCartItemsList = new ArrayList<>();

        for (Item cartItem : cartItems) {
            tempCartItemsList.add(cartItem);
        }
        System.out.println(tempCartItemsList);

        try {
            Item repoItem = repo.getItemsById(idItem);
            tempCartItemsList.remove(repoItem);
            System.out.println(tempCartItemsList);
        } catch (SQLException ex) {
            Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        cartItems = tempCartItemsList;
        session.setAttribute("cartItems", cartItems);
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
