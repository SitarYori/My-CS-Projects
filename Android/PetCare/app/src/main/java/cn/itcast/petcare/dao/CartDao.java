package cn.itcast.petcare.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import cn.itcast.petcare.model.CartItem;
import java.util.ArrayList;
import java.util.List;

public class CartDao {
    private final DatabaseHelper dbHelper;  // ← 添加 final

    public CartDao(Context context) {
        dbHelper = new DatabaseHelper(context);
    }

    /**
     * 添加商品到购物车（如果已存在则增加数量）
     */
    public long addToCart(int userId, String productName, String productDesc,
                          double price, double originalPrice, int imageRes) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();

        // 检查是否已存在
        String checkSql = "SELECT * FROM cart WHERE user_id = ? AND product_name = ?";
        Cursor cursor = db.rawQuery(checkSql, new String[]{String.valueOf(userId), productName});

        if (cursor.moveToFirst()) {
            // 已存在，增加数量
            int idIndex = cursor.getColumnIndex("id");
            int qtyIndex = cursor.getColumnIndex("quantity");

            if (idIndex >= 0 && qtyIndex >= 0) {
                int id = cursor.getInt(idIndex);
                int currentQty = cursor.getInt(qtyIndex);
                cursor.close();

                ContentValues values = new ContentValues();
                values.put("quantity", currentQty + 1);
                db.update("cart", values, "id = ?", new String[]{String.valueOf(id)});
                return id;
            } else {
                cursor.close();
                return -1;
            }
        } else {
            cursor.close();
            // 不存在，插入新记录
            ContentValues values = new ContentValues();
            values.put("user_id", userId);
            values.put("product_name", productName);
            values.put("product_desc", productDesc);
            values.put("price", price);
            values.put("original_price", originalPrice);
            values.put("quantity", 1);
            values.put("image_res", imageRes);
            return db.insert("cart", null, values);
        }
    }

    /**
     * 获取用户购物车列表
     */
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> list = new ArrayList<>();
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT * FROM cart WHERE user_id = ? ORDER BY id DESC";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(userId)});

        while (cursor.moveToNext()) {
            CartItem item = new CartItem();

            int idIndex = cursor.getColumnIndex("id");
            int userIdIndex = cursor.getColumnIndex("user_id");
            int nameIndex = cursor.getColumnIndex("product_name");
            int descIndex = cursor.getColumnIndex("product_desc");
            int priceIndex = cursor.getColumnIndex("price");
            int originalPriceIndex = cursor.getColumnIndex("original_price");
            int qtyIndex = cursor.getColumnIndex("quantity");
            int imageIndex = cursor.getColumnIndex("image_res");

            if (idIndex >= 0) item.setId(cursor.getInt(idIndex));
            if (userIdIndex >= 0) item.setUserId(cursor.getInt(userIdIndex));
            if (nameIndex >= 0) item.setProductName(cursor.getString(nameIndex));
            if (descIndex >= 0) item.setProductDesc(cursor.getString(descIndex));
            if (priceIndex >= 0) item.setPrice(cursor.getDouble(priceIndex));
            if (originalPriceIndex >= 0) item.setOriginalPrice(cursor.getDouble(originalPriceIndex));
            if (qtyIndex >= 0) item.setQuantity(cursor.getInt(qtyIndex));
            if (imageIndex >= 0) item.setImageRes(cursor.getInt(imageIndex));

            list.add(item);
        }
        cursor.close();
        return list;
    }

    /**
     * 更新商品数量
     */
    public int updateQuantity(int cartId, int quantity) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("quantity", quantity);
        return db.update("cart", values, "id = ?", new String[]{String.valueOf(cartId)});
    }

    /**
     * 删除购物车商品
     */
    public int deleteCartItem(int cartId) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        return db.delete("cart", "id = ?", new String[]{String.valueOf(cartId)});
    }

    /**
     * 清空购物车
     */
    public int clearCart(int userId) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        return db.delete("cart", "user_id = ?", new String[]{String.valueOf(userId)});
    }

    /**
     * 获取购物车商品总数
     */
    public int getCartCount(int userId) {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT SUM(quantity) as total FROM cart WHERE user_id = ?";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(userId)});
        int count = 0;
        if (cursor.moveToFirst()) {
            int totalIndex = cursor.getColumnIndex("total");
            if (totalIndex >= 0) {
                count = cursor.getInt(totalIndex);
            }
        }
        cursor.close();
        return count;
    }

    /**
     * 获取购物车总价
     */
    public double getCartTotal(int userId) {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT SUM(price * quantity) as total FROM cart WHERE user_id = ?";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(userId)});
        double total = 0;
        if (cursor.moveToFirst()) {
            int totalIndex = cursor.getColumnIndex("total");
            if (totalIndex >= 0) {
                total = cursor.getDouble(totalIndex);
            }
        }
        cursor.close();
        return total;
    }
}