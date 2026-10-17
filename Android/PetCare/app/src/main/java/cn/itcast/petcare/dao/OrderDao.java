package cn.itcast.petcare.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import cn.itcast.petcare.model.Order;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class OrderDao {
    private final DatabaseHelper dbHelper;

    public OrderDao(Context context) {
        dbHelper = new DatabaseHelper(context);
    }

    // ⭐ 创建订单（初始状态为待付款）
    /**
     * 创建订单
     */
    public long createOrder(Order order) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("order_no", order.getOrderNo());
        values.put("user_id", order.getUserId());
        values.put("product_name", order.getProductName());
        values.put("product_desc", order.getProductDesc());
        values.put("price", order.getPrice());
        values.put("quantity", order.getQuantity());
        values.put("total_price", order.getTotalPrice());
        values.put("address_id", order.getAddressId());
        values.put("status", order.getStatus());  // ⭐ 确保这行存在
        values.put("create_time", order.getCreateTime());
        values.put("pay_time", order.getPayTime());
        values.put("ship_time", order.getShipTime());
        values.put("complete_time", order.getCompleteTime());

        // ⭐ 打印日志确认状态值
        android.util.Log.d("OrderDao", "创建订单，状态: " + order.getStatus());

        return db.insert("orders", null, values);
    }

    /**
     * ⭐ 更新订单状态（带时间记录）
     */
    public int updateOrderStatus(int orderId, int status) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("status", status);

        String currentTime = getCurrentTime();
        switch (status) {
            case Order.STATUS_PAID:
                values.put("pay_time", currentTime);
                break;
            case Order.STATUS_COMPLETED:
                values.put("complete_time", currentTime);
                break;
        }

        return db.update("orders", values, "id = ?", new String[]{String.valueOf(orderId)});
    }

    /**
     * ⭐ 模拟发货（已支付→已完成）
     */
    public int shipOrder(int orderId) {
        return updateOrderStatus(orderId, Order.STATUS_COMPLETED);
    }

    /**
     * ⭐ 取消订单（待付款→已取消）
     */
    public int cancelOrder(int orderId) {
        return updateOrderStatus(orderId, Order.STATUS_CANCELLED);
    }

    /**
     * 获取用户的所有订单
     */
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT o.*, a.detail as address_detail, a.receiver_name, a.phone as receiver_phone " +
                "FROM orders o " +
                "LEFT JOIN addresses a ON o.address_id = a.id " +
                "WHERE o.user_id = ? " +
                "ORDER BY o.id DESC";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(userId)});

        while (cursor.moveToNext()) {
            Order order = extractOrderFromCursor(cursor);
            list.add(order);
        }
        cursor.close();
        return list;
    }

    /**
     * ⭐ 根据状态获取订单
     */
    public List<Order> getOrdersByStatus(int userId, int status) {
        List<Order> list = new ArrayList<>();
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT o.*, a.detail as address_detail, a.receiver_name, a.phone as receiver_phone " +
                "FROM orders o " +
                "LEFT JOIN addresses a ON o.address_id = a.id " +
                "WHERE o.user_id = ? AND o.status = ? " +
                "ORDER BY o.id DESC";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(userId), String.valueOf(status)});

        while (cursor.moveToNext()) {
            Order order = extractOrderFromCursor(cursor);
            list.add(order);
        }
        cursor.close();
        return list;
    }

    /**
     * ⭐ 获取单个订单详情
     */
    public Order getOrderById(int orderId) {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT o.*, a.detail as address_detail, a.receiver_name, a.phone as receiver_phone " +
                "FROM orders o " +
                "LEFT JOIN addresses a ON o.address_id = a.id " +
                "WHERE o.id = ?";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(orderId)});

        if (cursor.moveToFirst()) {
            Order order = extractOrderFromCursor(cursor);
            cursor.close();
            return order;
        }
        cursor.close();
        return null;
    }

    private Order extractOrderFromCursor(Cursor cursor) {
        Order order = new Order();
        int idIndex = cursor.getColumnIndex("id");
        int orderNoIndex = cursor.getColumnIndex("order_no");
        int userIdIndex = cursor.getColumnIndex("user_id");
        int nameIndex = cursor.getColumnIndex("product_name");
        int descIndex = cursor.getColumnIndex("product_desc");
        int priceIndex = cursor.getColumnIndex("price");
        int qtyIndex = cursor.getColumnIndex("quantity");
        int totalIndex = cursor.getColumnIndex("total_price");
        int addressIdIndex = cursor.getColumnIndex("address_id");
        int statusIndex = cursor.getColumnIndex("status");
        int createTimeIndex = cursor.getColumnIndex("create_time");
        int payTimeIndex = cursor.getColumnIndex("pay_time");
        int shipTimeIndex = cursor.getColumnIndex("ship_time");
        int completeTimeIndex = cursor.getColumnIndex("complete_time");
        int addressDetailIndex = cursor.getColumnIndex("address_detail");
        int receiverNameIndex = cursor.getColumnIndex("receiver_name");
        int receiverPhoneIndex = cursor.getColumnIndex("receiver_phone");

        if (idIndex >= 0) order.setId(cursor.getInt(idIndex));
        if (orderNoIndex >= 0) order.setOrderNo(cursor.getString(orderNoIndex));
        if (userIdIndex >= 0) order.setUserId(cursor.getInt(userIdIndex));
        if (nameIndex >= 0) order.setProductName(cursor.getString(nameIndex));
        if (descIndex >= 0) order.setProductDesc(cursor.getString(descIndex));
        if (priceIndex >= 0) order.setPrice(cursor.getDouble(priceIndex));
        if (qtyIndex >= 0) order.setQuantity(cursor.getInt(qtyIndex));
        if (totalIndex >= 0) order.setTotalPrice(cursor.getDouble(totalIndex));
        if (addressIdIndex >= 0) order.setAddressId(cursor.getInt(addressIdIndex));
        if (statusIndex >= 0) order.setStatus(cursor.getInt(statusIndex));
        if (createTimeIndex >= 0) order.setCreateTime(cursor.getString(createTimeIndex));
        if (payTimeIndex >= 0) order.setPayTime(cursor.getString(payTimeIndex));
        if (shipTimeIndex >= 0) order.setShipTime(cursor.getString(shipTimeIndex));
        if (completeTimeIndex >= 0) order.setCompleteTime(cursor.getString(completeTimeIndex));
        if (addressDetailIndex >= 0) order.setAddressDetail(cursor.getString(addressDetailIndex));
        if (receiverNameIndex >= 0) order.setReceiverName(cursor.getString(receiverNameIndex));
        if (receiverPhoneIndex >= 0) order.setReceiverPhone(cursor.getString(receiverPhoneIndex));

        return order;
    }

    private String getCurrentTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.CHINA);
        return sdf.format(new Date());
    }

    /**
     * ⭐ 删除订单
     */
    public int deleteOrder(int orderId) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        return db.delete("orders", "id = ?", new String[]{String.valueOf(orderId)});
    }

    /**
     * ⭐ 批量删除已完成或已取消的订单
     */
    public int deleteOrdersByStatus(int userId, int status) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        return db.delete("orders", "user_id = ? AND status = ?",
                new String[]{String.valueOf(userId), String.valueOf(status)});
    }

    /**
     * ⭐ 更新订单评价
     */
    public int updateOrderComment(int orderId, float rating, String comment) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("rating", rating);
        values.put("comment", comment);
        return db.update("orders", values, "id = ?", new String[]{String.valueOf(orderId)});
    }
}