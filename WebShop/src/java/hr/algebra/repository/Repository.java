/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.repository;

import hr.algebra.models.Bill;
import hr.algebra.models.Category;
import hr.algebra.models.Item;
import hr.algebra.models.LoginHistory;
import hr.algebra.models.User;
import hr.algebra.models.UserShoppingHistoryItem;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Mladen
 */
public interface Repository {

    //User methods
    User createAppUser(User user) throws Exception;

    User authenticateUser(String username, String password) throws Exception;

    public List<Item> getItemsByCategory(int categoryId);

    public List<Category> getCategories();

    public List<Item> getAllItems();

    public List<LoginHistory> getLoginHistory();

    public int saveLoginData(User user, String ipAddress) throws SQLException;

    public Category getCategoryById(int categoryId) throws SQLException;

    public User getUserById(int userId) throws SQLException;

    public void deleteItem(int itemId) throws SQLException;

    public void deleteCategory(int idCategory) throws SQLException;

    public Item getItemsById(int itemId)throws SQLException;

    public Category createCategory(String category) throws SQLException;

    public int addItem(Item item)throws SQLException;

    public Bill createBill(Bill bill)throws SQLException;

    public void bindItemsWithBill(Item cartItem, Bill bill)throws SQLException;

    public List<UserShoppingHistoryItem> getCompleteShoppingHistory()throws SQLException;

    public UserShoppingHistoryItem getUserShoppingHistory(User user, Bill bill)throws SQLException;

    public List<UserShoppingHistoryItem> getAllBillsOfUser(User user)throws SQLException;

    public List<Bill> getAllBills()throws SQLException;

    public List<Item> getAllBillItems(int billId)throws SQLException;
    
}
