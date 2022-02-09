/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.servlets;

import hr.algebra.models.Category;
import hr.algebra.models.Item;
import hr.algebra.models.LoginHistory;
import hr.algebra.repository.Repository;
import hr.algebra.repository.SqlRepository;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mladen
 */
public class AdminSerlet extends HttpServlet {

    private static Repository repo = new SqlRepository();

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
            out.println("<title>Servlet AdminSerlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminSerlet at " + request.getContextPath() + "</h1>");
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
        //store items, login history and shopping history

        List<Item> items = repo.getAllItems();
        HttpSession session = request.getSession();
        session.setAttribute("items", items);
        
        List<Category> categories = repo.getCategories();
        session.setAttribute("categories", categories);

        List<LoginHistory> loginHistoryList = repo.getLoginHistory();
        session.setAttribute("loginHistory", loginHistoryList);

        response.sendRedirect("admin.jsp");
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

        HttpSession session = request.getSession();
        String idItem = request.getParameter("idItem");
        String idCategory = request.getParameter("idCategory");
        String itemName = request.getParameter("itemName");
        String itemDescription = request.getParameter("itemDescription");
        String itemPrice = request.getParameter("itemPrice");
        String itemStorageAmount = request.getParameter("itemStorageAmount");
        String itemCategory = request.getParameter("itemCategory");

        if (idItem != null) {
            deleteItem(Integer.parseInt(idItem));
        } else if (idCategory != null) {
            deleteCategory(Integer.parseInt(idCategory));
        }
        
        if (itemName != null) {
            addItem(itemName, itemDescription, itemPrice, itemStorageAmount, itemCategory);
        }
        
        //Category c = new Category();
        String categoryName = request.getParameter("categoryName");

        if (categoryName != null) {
            addNewCategory(categoryName);
        }

        List<Category> categories = repo.getCategories();
        session.setAttribute("categories", categories);
        List<Item> items = repo.getAllItems();
        session.setAttribute("items", items);

        response.sendRedirect("adminRedirect.jsp");
    }
    
     private void addItem(String itemName, String itemDescription, String itemPrice, String itemStorageAmount, String itemCategory) {
         System.out.println("addItem got boinked");
         Item item = new Item();
         item.setItemName(itemName);
         item.setItemDescription(itemDescription);
         item.setPrice(Double.parseDouble(itemPrice));
         item.setAvailableAmount(Integer.parseInt(itemStorageAmount));
         //itemImage?
         item.setCategory(Integer.parseInt(itemCategory));
        try {
            repo.addItem(item);
        } catch (SQLException ex) {
            System.out.println("addItem puca batoo");
            ex.printStackTrace();
            Logger.getLogger(AdminSerlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void addNewCategory(String categoryName) {
        try {
            repo.createCategory(categoryName);
            System.out.println("");
        } catch (SQLException ex) {
            Logger.getLogger(StoreItemsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void deleteCategory(int idCategory) {
        try {
            repo.deleteCategory(idCategory);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteItem(int itemId) {
        //System.out.println("made it to delete item in admin servlet with values: "+itemId);
        try {
            repo.deleteItem(itemId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
