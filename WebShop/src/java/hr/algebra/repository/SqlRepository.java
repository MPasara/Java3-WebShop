package hr.algebra.repository;

import hr.algebra.models.Bill;
import hr.algebra.models.Category;
import hr.algebra.models.Item;
import hr.algebra.models.LoginHistory;
import hr.algebra.models.User;
import hr.algebra.models.UserShoppingHistoryItem;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;

/**
 *
 * @author Mladen
 */
public class SqlRepository implements Repository {

    //user constants
    private static final String USER_ID = "IDAppUser";
    private static final String USERNAME = "Username";
    private static final String PASSWORD = "UserPassword";
    private static final String ADDRESS = "UserAddress";
    private static final String IS_ADMIN = "IsAdmin";

    //item constants
    private static final String ITEM_ID = "IDItem";
    private static final String ITEM_NAME = "ItemName";
    private static final String ITEM_DESCRIPTION = "ItemDescription";
    private static final String ITEM_PRICE = "Price";
    private static final String ITEM_AMOUNT = "AvailableAmount";
    private static final String ITEM_IMAGE = "ItemImage";
    private static final String ITEM_CATEGORY_ID = "CategoryID";

    //category constants
    private static final String CATEGORY_ID = "IDCategory";
    private static final String CATEGORY_TITLE = "Title";

    //login history constants
    private static final String LOGIN_HISTORY_ID = "IDLoginHistory";
    private static final String LOGIN_HISTORY_APP_USER_ID = "AppUserID";
    private static final String LOGIN_HISTORY_LOGIN_TIME = "LoginTime";
    private static final String LOGIN_HISTORY_USER_IP = "UserAddress";

    //bill constants
    private static final String BILL_ID = "IDBill";
    private static final String APP_USER_ID = "AppUserID";
    private static final String DATE_OF_PURCHASE = "DateOfPurchase";
    private static final String PAYMENT_METHOD = "PaymentMethod";
    private static final String TOTAL = "Total";
    private static final String ITEMID = "ItemID";

    //user procedures
    private static final String CREATE_USER = "{ call createAppUser(?, ?, ?, ?, ?) }";
    private static final String AUTHENTICATE = "{ call authenticateAppUser(?, ?) }";
    private static final String GET_USER_BY_ID = "{ call getUsersById(?) }";
    private static final String GET_ALL_BILLS_OF_USER = "{call getAllBillsOfUser(?)}";

    //item procedures
    private static final String GET_ITEM_BY_CATEGORY = "{ call getItemByCategory(?) }";
    private static final String GET_All_ITEMS = "{ call selectItems() }";
    private static final String DELETE_ITEM = "{call deleteItem(?)}";
    private static final String GET_ITEMS_BY_ID = "{call selectItem(?)}";
    private static final String CREATE_ITEM = "{call createItem(?, ?, ?, ?,?, ?, ?)}";

    //category procedures
    private static final String CREATE_CATEGORY = "{call createCategory(?,?)}";
    private static final String GET_CATEGORIES = "{ call selectCategories() }";
    private static final String GET_CATEGORY_BY_ID = "{ call getCategoriesById(?) }";
    private static final String DELETE_CATEGORY = "{ call deleteCategory(?) }";

    //login history procedures
    private static final String CREATE_LOGIN_HISTORY = "{call createLoginHistory(?,?,?,?)}";
    private static final String GET_LOGIN_HISTORIES = "{ call selectLoginHistories () }";

    //bill procedures
    private static final String CREATE_BILL = "{call createBill(?,?,?,?,?)}";
    private static final String GET_All_BILLS = "{call selectBills()}";

    //item_bill procedures
    private static final String BIND_ITEMS_WITH_BILL = "{call bindItemsWithBill(?,?)}";
    private static final String GET_COMPLETE_SHOPPING_HISTORY = "{call getCompleteShoppingHistory()}";
    private static final String GET_USER_SHOPPING_HISTORY = "{call getUserShoppingHistory(?)}";
    private static final String GET_All_BILL_ITEMS = "{call getAllBillItems(?)}";

    @Override
    public User createAppUser(User user) throws Exception {
        DataSource dataSource = DataSourceSingleton.getInstace();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmnt = con.prepareCall(CREATE_USER)) {
            stmnt.registerOutParameter(USER_ID, Types.INTEGER);
            stmnt.setString(USERNAME, user.getUsername());
            stmnt.setString(PASSWORD, user.getPassword());
            stmnt.setString(ADDRESS, user.getAddress());
            stmnt.setBoolean(IS_ADMIN, user.isAdmin());
            stmnt.executeUpdate();
            user.setId(stmnt.getInt(1));
            return user;
        } catch (SQLException ex) {
            Logger.getLogger(SqlRepository.class.getName())
                    .log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public User authenticateUser(String username, String password) throws Exception {
        DataSource dataSource = DataSourceSingleton.getInstace();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(AUTHENTICATE)) {
            stmt.setString(1, username);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt(USER_ID),
                            rs.getString(USERNAME),
                            rs.getString(PASSWORD),
                            rs.getString(ADDRESS),
                            rs.getBoolean(IS_ADMIN)
                    );
                }
            }
        }
        return null;
    }

    @Override
    public List<Item> getItemsByCategory(int categoryId) {
        DataSource dataSource = DataSourceSingleton.getInstace();
        List<Item> items = new ArrayList<>();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_ITEM_BY_CATEGORY)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    items.add(new Item(
                            rs.getInt(ITEM_ID),
                            rs.getString(ITEM_NAME),
                            rs.getString(ITEM_DESCRIPTION),
                            rs.getDouble(ITEM_PRICE),
                            rs.getInt(ITEM_AMOUNT),
                            rs.getBytes(ITEM_IMAGE),
                            rs.getInt(ITEM_CATEGORY_ID)
                    ));
                }
            }

        } catch (Exception e) {
            System.out.println("getItemsByCategory broke down");
            e.printStackTrace();
        }

        return items;
    }

    @Override
    public List<Category> getCategories() {
        DataSource dataSource = DataSourceSingleton.getInstace();
        List<Category> categories = new ArrayList<>();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_CATEGORIES)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    categories.add(new Category(
                            rs.getInt(CATEGORY_ID),
                            rs.getString(CATEGORY_TITLE)
                    ));
                }
            }
        } catch (Exception e) {
            System.out.println("getCategories broke down");
            e.printStackTrace();
        }
        return categories;

    }

    @Override
    public List<Item> getAllItems() {
        DataSource dataSource = DataSourceSingleton.getInstace();
        List<Item> items = new ArrayList<>();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_All_ITEMS)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    items.add(new Item(
                            rs.getInt(ITEM_ID),
                            rs.getString(ITEM_NAME),
                            rs.getString(ITEM_DESCRIPTION),
                            rs.getDouble(ITEM_PRICE),
                            rs.getInt(ITEM_AMOUNT),
                            rs.getBytes(ITEM_IMAGE),
                            rs.getInt(ITEM_CATEGORY_ID)
                    ));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SqlRepository.class.getName())
                    .log(Level.SEVERE, null, ex);
        }

        return items;
    }

    @Override
    public List<LoginHistory> getLoginHistory() {
        DataSource dataSource = DataSourceSingleton.getInstace();
        List<LoginHistory> loginHistoryList = new ArrayList<>();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_LOGIN_HISTORIES)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    loginHistoryList.add(new LoginHistory(
                            rs.getInt(LOGIN_HISTORY_ID),
                            rs.getInt(LOGIN_HISTORY_APP_USER_ID),
                            rs.getTimestamp(LOGIN_HISTORY_LOGIN_TIME)
                                    .toLocalDateTime(),
                            rs.getString(LOGIN_HISTORY_USER_IP)
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return loginHistoryList;
    }

    @Override
    public int saveLoginData(User user, String ipAddress) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(CREATE_LOGIN_HISTORY)) {
            stmt.registerOutParameter(1, Types.INTEGER);
            stmt.setInt(2, user.getId());
            stmt.setString(3, LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME));
            stmt.setString(4, ipAddress);

            stmt.executeUpdate();
            return stmt.getInt(1);
        }
    }

    @Override
    public Category getCategoryById(int categoryId) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_CATEGORY_BY_ID)) {
            stmt.setInt(1, categoryId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Category(
                            rs.getInt(CATEGORY_ID),
                            rs.getString(CATEGORY_TITLE));
                }
            }
        }
        return null;
    }

    @Override
    public User getUserById(int userId) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_USER_BY_ID)) {
            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt(USER_ID),
                            rs.getString(USERNAME),
                            rs.getString(PASSWORD),
                            rs.getString(ADDRESS),
                            rs.getBoolean(IS_ADMIN));
                }
            }
        }
        return null;
    }

    @Override
    public void deleteItem(int itemId) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(DELETE_ITEM)) {
            stmt.setInt(1, itemId);
            stmt.execute();
        }
    }

    @Override
    public void deleteCategory(int idCategory) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(DELETE_CATEGORY)) {
            stmt.setInt(1, idCategory);
            stmt.execute();
        }
    }

    @Override
    public Item getItemsById(int itemId) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_ITEMS_BY_ID)) {
            stmt.setInt(1, itemId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    return new Item(
                            rs.getInt(ITEM_ID),
                            rs.getString(ITEM_NAME),
                            rs.getString(ITEM_DESCRIPTION),
                            rs.getDouble(ITEM_PRICE),
                            rs.getInt(ITEM_AMOUNT),
                            rs.getBytes(ITEM_IMAGE),
                            rs.getInt(ITEM_CATEGORY_ID)
                    );
                }
            }
        }
        return null;
    }

    @Override
    public Category createCategory(String categoryName) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();

        Category c = new Category();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmnt = con.prepareCall(CREATE_CATEGORY)) {
            c.setTitle(categoryName);
            stmnt.registerOutParameter(CATEGORY_ID, Types.INTEGER);
            stmnt.setString(CATEGORY_TITLE, c.getTitle());
            stmnt.executeUpdate();
            c.setId(stmnt.getInt(1));
            return c;
        } catch (SQLException ex) {
            Logger.getLogger(SqlRepository.class.getName())
                    .log(Level.SEVERE, null, ex);
            ex.printStackTrace();
        }

        return null;
    }

    @Override
    public int addItem(Item item) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(CREATE_ITEM)) {
            stmt.registerOutParameter(1, Types.INTEGER);
            stmt.setString(2, item.getItemName());
            stmt.setString(3, item.getItemDescription());
            stmt.setDouble(4, item.getPrice());
            stmt.setInt(5, item.getAvailableAmount());
            stmt.setBytes(6, item.getItemImage());
            stmt.setInt(7, item.getCategory());

            stmt.executeUpdate();
            return stmt.getInt(1);
        }
    }

    @Override
    public Bill createBill(Bill bill) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmnt = con.prepareCall(CREATE_BILL)) {
            stmnt.registerOutParameter(BILL_ID, Types.INTEGER);
            stmnt.setInt(APP_USER_ID, bill.getUserId());
            //stmnt.setDouble(DATE_OF_PURCHASE, Double.parseDouble(bill.getDateOfPurchase().toString()));
            stmnt.setString(DATE_OF_PURCHASE, LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME));
            stmnt.setString(PAYMENT_METHOD, bill.getPaymentMethod());
            stmnt.setDouble(TOTAL, bill.getTotal());
            stmnt.executeUpdate();
            bill.setId(stmnt.getInt(1));
        } catch (SQLException ex) {
            System.out.println("create bill in repo not working");
            Logger.getLogger(SqlRepository.class.getName())
                    .log(Level.SEVERE, null, ex);
            ex.printStackTrace();
        }

        return bill;
    }

    @Override
    public void bindItemsWithBill(Item cartItem, Bill bill) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmnt = con.prepareCall(BIND_ITEMS_WITH_BILL)) {
            stmnt.setInt(1, cartItem.getId());
            stmnt.setInt(2, bill.getId());

            stmnt.executeUpdate();
        }
    }
    
    @Override
    public List<UserShoppingHistoryItem> getCompleteShoppingHistory() throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();
        List<UserShoppingHistoryItem> userBills = new ArrayList<>();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_COMPLETE_SHOPPING_HISTORY)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    userBills.add(new UserShoppingHistoryItem(
                            rs.getInt(BILL_ID),
                            rs.getTimestamp(DATE_OF_PURCHASE)
                                    .toLocalDateTime(),
                            rs.getString(PAYMENT_METHOD),
                            rs.getDouble(TOTAL),
                            rs.getInt(APP_USER_ID),
                            rs.getInt(ITEMID)
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userBills;
    }

    @Override
    public UserShoppingHistoryItem getUserShoppingHistory(User user, Bill bill) throws SQLException {
        int itemId = 0;
        int userId = user.getId();
        DataSource dataSource = DataSourceSingleton.getInstace();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmnt = con.prepareCall(GET_USER_SHOPPING_HISTORY)) {
            stmnt.setInt(1, userId);
            try (ResultSet rs = stmnt.executeQuery()) {
                while (rs.next()) {
                    return new UserShoppingHistoryItem(
                            bill.getId(),
                            bill.getDateOfPurchase(),
                            bill.getPaymentMethod(),
                            bill.getTotal(),
                            user.getId(),
                            itemId
                    );
                }
            }
        }
        return null;
    }

    @Override
    public List<UserShoppingHistoryItem> getAllBillsOfUser(User user) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();
        List<UserShoppingHistoryItem> userBills = new ArrayList<>();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_ALL_BILLS_OF_USER)) {
            stmt.setInt(1, user.getId());
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    userBills.add(new UserShoppingHistoryItem(
                            rs.getInt(BILL_ID),
                            rs.getTimestamp(DATE_OF_PURCHASE).toLocalDateTime(),
                            rs.getString(PAYMENT_METHOD),
                            rs.getDouble(TOTAL),
                            rs.getInt(APP_USER_ID),
                            rs.getInt(ITEMID)
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userBills;
    }

    @Override
    public List<Bill> getAllBills() throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();
        List<Bill> bills = new ArrayList<>();

        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_All_BILLS)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bills.add(new Bill(
                            rs.getInt(BILL_ID),
                            rs.getInt(APP_USER_ID),
                            rs.getTimestamp(DATE_OF_PURCHASE)
                                    .toLocalDateTime(),
                            rs.getString(PAYMENT_METHOD),
                            rs.getDouble(TOTAL)
                    ));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SqlRepository.class.getName())
                    .log(Level.SEVERE, null, ex);
        }

        return bills;
    }
    
    @Override
    public List<Item> getAllBillItems(int billId) throws SQLException {
        DataSource dataSource = DataSourceSingleton.getInstace();
        List<Item> billItems = new ArrayList<>();
        
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(GET_All_BILL_ITEMS)) {
            stmt.setInt(1, billId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    billItems.add(new Item(
                            rs.getInt(ITEM_ID),
                            rs.getString(ITEM_NAME),
                            rs.getString(ITEM_DESCRIPTION),
                            rs.getDouble(ITEM_PRICE),
                            rs.getInt(ITEM_AMOUNT),
                            rs.getBytes(ITEM_IMAGE),
                            rs.getInt(ITEM_CATEGORY_ID)
                    ));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SqlRepository.class.getName())
                    .log(Level.SEVERE, null, ex);
        }
        
        return billItems;
    }
}
/*try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    return new Item(
                            rs.getInt(ITEM_ID),
                            rs.getString(ITEM_NAME),
                            rs.getString(ITEM_DESCRIPTION),
                            rs.getDouble(ITEM_PRICE),
                            rs.getInt(ITEM_AMOUNT),
                            rs.getBytes(ITEM_IMAGE),
                            rs.getInt(ITEM_CATEGORY_ID)
                    );
                }
            }*/
