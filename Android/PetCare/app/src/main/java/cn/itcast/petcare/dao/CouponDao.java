package cn.itcast.petcare.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import cn.itcast.petcare.model.Coupon;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * 优惠券数据库操作类
 *
 * 功能：优惠券的增删改查操作
 * 包含：添加优惠券、查询优惠券、使用优惠券
 */
public class CouponDao {

    private final DatabaseHelper dbHelper;

    public CouponDao(Context context) {
        dbHelper = new DatabaseHelper(context);
    }

    /**
     * 为用户发放优惠券
     *
     * @param userId        用户ID
     * @param title         优惠券标题
     * @param type          优惠类型：1=满减，2=折扣，3=免运费
     * @param discountValue 优惠金额（满减券）或折扣比例（折扣券）
     * @param minAmount     最低消费门槛
     * @param maxDiscount   最大优惠金额（折扣券使用）
     * @param source        来源说明
     * @param endTime       有效期结束时间
     * @return 插入记录ID
     */
    public long addCoupon(int userId, String title, int type, double discountValue,
                          double minAmount, double maxDiscount, String source,
                          String endTime) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("user_id", userId);
        values.put("coupon_no", generateCouponNo());
        values.put("title", title);
        values.put("type", type);
        values.put("discount_value", discountValue);
        values.put("min_amount", minAmount);
        values.put("max_discount", maxDiscount);
        values.put("source", source);
        values.put("start_time", getCurrentTime());
        values.put("end_time", endTime);
        values.put("status", Coupon.STATUS_UNUSED);
        values.put("create_time", getCurrentTime());
        return db.insert("coupons", null, values);
    }

    /**
     * 获取用户指定状态的优惠券列表
     *
     * @param userId 用户ID
     * @param status 状态：1=未使用，2=已使用，3=已过期
     * @return 优惠券列表
     */
    public List<Coupon> getCouponsByStatus(int userId, int status) {
        List<Coupon> list = new ArrayList<>();
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT * FROM coupons WHERE user_id = ? AND status = ? ORDER BY end_time ASC";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(userId), String.valueOf(status)});

        while (cursor.moveToNext()) {
            Coupon coupon = extractCouponFromCursor(cursor);
            list.add(coupon);
        }
        cursor.close();
        return list;
    }

    /**
     * 获取用户所有未使用的优惠券（且未过期）
     */
    public List<Coupon> getUnusedCoupons(int userId) {
        List<Coupon> list = new ArrayList<>();
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT * FROM coupons WHERE user_id = ? AND status = ? " +
                "AND end_time > datetime('now', 'localtime') " +
                "ORDER BY end_time ASC";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(userId),
                String.valueOf(Coupon.STATUS_UNUSED)});

        while (cursor.moveToNext()) {
            Coupon coupon = extractCouponFromCursor(cursor);
            list.add(coupon);
        }
        cursor.close();
        return list;
    }

    /**
     * 使用优惠券（标记为已使用）
     *
     * @param couponId 优惠券ID
     * @param orderId  关联的订单ID
     * @return 影响行数
     */
    public int useCoupon(int couponId, int orderId) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("status", Coupon.STATUS_USED);
        values.put("use_time", getCurrentTime());
        values.put("order_id", orderId);
        return db.update("coupons", values, "id = ?", new String[]{String.valueOf(couponId)});
    }

    /**
     * 生成优惠券编号
     */
    private String generateCouponNo() {
        return "CP" + System.currentTimeMillis() + (int)(Math.random() * 1000);
    }

    /**
     * 获取当前时间
     */
    private String getCurrentTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.CHINA);
        return sdf.format(new Date());
    }

    /**
     * 从Cursor提取优惠券数据
     */
    private Coupon extractCouponFromCursor(Cursor cursor) {
        Coupon coupon = new Coupon();
        int idIndex = cursor.getColumnIndex("id");
        int userIdIndex = cursor.getColumnIndex("user_id");
        int noIndex = cursor.getColumnIndex("coupon_no");
        int titleIndex = cursor.getColumnIndex("title");
        int typeIndex = cursor.getColumnIndex("type");
        int valueIndex = cursor.getColumnIndex("discount_value");
        int minIndex = cursor.getColumnIndex("min_amount");
        int maxIndex = cursor.getColumnIndex("max_discount");
        int sourceIndex = cursor.getColumnIndex("source");
        int startIndex = cursor.getColumnIndex("start_time");
        int endIndex = cursor.getColumnIndex("end_time");
        int statusIndex = cursor.getColumnIndex("status");
        int createIndex = cursor.getColumnIndex("create_time");
        int useIndex = cursor.getColumnIndex("use_time");
        int orderIndex = cursor.getColumnIndex("order_id");

        if (idIndex >= 0) coupon.setId(cursor.getInt(idIndex));
        if (userIdIndex >= 0) coupon.setUserId(cursor.getInt(userIdIndex));
        if (noIndex >= 0) coupon.setCouponNo(cursor.getString(noIndex));
        if (titleIndex >= 0) coupon.setTitle(cursor.getString(titleIndex));
        if (typeIndex >= 0) coupon.setType(cursor.getInt(typeIndex));
        if (valueIndex >= 0) coupon.setDiscountValue(cursor.getDouble(valueIndex));
        if (minIndex >= 0) coupon.setMinAmount(cursor.getDouble(minIndex));
        if (maxIndex >= 0) coupon.setMaxDiscount(cursor.getDouble(maxIndex));
        if (sourceIndex >= 0) coupon.setSource(cursor.getString(sourceIndex));
        if (startIndex >= 0) coupon.setStartTime(cursor.getString(startIndex));
        if (endIndex >= 0) coupon.setEndTime(cursor.getString(endIndex));
        if (statusIndex >= 0) coupon.setStatus(cursor.getInt(statusIndex));
        if (createIndex >= 0) coupon.setCreateTime(cursor.getString(createIndex));
        if (useIndex >= 0) coupon.setUseTime(cursor.getString(useIndex));
        if (orderIndex >= 0) coupon.setOrderId(cursor.getInt(orderIndex));

        return coupon;
    }
}