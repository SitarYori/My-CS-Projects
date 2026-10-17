package cn.itcast.petcare.dao;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import androidx.annotation.Nullable;

public class DatabaseHelper extends SQLiteOpenHelper {
    private static final String DB_NAME = "petcare.db";
    private static final int VERSION = 8;  // ⭐ 升级到版本8

    public DatabaseHelper(@Nullable Context context) {
        super(context, DB_NAME, null, VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // 用户表
        String createUser = "CREATE TABLE users (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "phone TEXT UNIQUE, " +
                "password TEXT, " +
                "username TEXT, " +
                "avatar TEXT)";
        db.execSQL(createUser);

        // 购物车表
        String createCart = "CREATE TABLE cart (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "user_id INTEGER, " +
                "product_name TEXT, " +
                "product_desc TEXT, " +
                "price REAL, " +
                "original_price REAL, " +
                "quantity INTEGER DEFAULT 1, " +
                "image_res INTEGER DEFAULT 0, " +
                "FOREIGN KEY(user_id) REFERENCES users(id))";
        db.execSQL(createCart);

        // 地址表
        String createAddress = "CREATE TABLE addresses (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "user_id INTEGER, " +
                "receiver_name TEXT, " +
                "phone TEXT, " +
                "province TEXT, " +
                "city TEXT, " +
                "district TEXT, " +
                "detail TEXT, " +
                "is_default INTEGER DEFAULT 0, " +
                "FOREIGN KEY(user_id) REFERENCES users(id))";
        db.execSQL(createAddress);

        // ⭐ 订单表（使用不同的变量名 createOrderTable）
        //评价
        String createOrderTable = "CREATE TABLE orders (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "order_no TEXT UNIQUE, " +
                "user_id INTEGER, " +
                "product_name TEXT, " +
                "product_desc TEXT, " +
                "price REAL, " +
                "quantity INTEGER, " +
                "total_price REAL, " +
                "address_id INTEGER, " +
                "status INTEGER DEFAULT 1, " +
                "create_time TEXT, " +
                "pay_time TEXT, " +
                "ship_time TEXT, " +
                "complete_time TEXT, " +
                "rating REAL DEFAULT 0, " +      // ⭐ 新增评分数
                "comment TEXT, " +               // ⭐ 新增评价内容
                "FOREIGN KEY(user_id) REFERENCES users(id))";
        db.execSQL(createOrderTable);

        // 服务预约表
        String createServiceOrder = "CREATE TABLE service_orders (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "user_id INTEGER, " +
                "service_type TEXT, " +
                "pet_name TEXT, " +
                "pet_type TEXT, " +
                "service_name TEXT, " +
                "service_date TEXT, " +
                "service_time TEXT, " +
                "address TEXT, " +
                "remark TEXT, " +
                "status INTEGER DEFAULT 1, " +
                "create_time TEXT, " +
                "FOREIGN KEY(user_id) REFERENCES users(id))";
        db.execSQL(createServiceOrder);

        //优惠卷
        String createCoupon = "CREATE TABLE coupons (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "user_id INTEGER, " +
                "coupon_no TEXT UNIQUE, " +
                "title TEXT, " +
                "type INTEGER, " +
                "discount_value REAL, " +
                "min_amount REAL, " +
                "max_discount REAL, " +
                "source TEXT, " +
                "start_time TEXT, " +
                "end_time TEXT, " +
                "status INTEGER DEFAULT 1, " +
                "create_time TEXT, " +
                "use_time TEXT, " +
                "order_id INTEGER, " +
                "FOREIGN KEY(user_id) REFERENCES users(id))";
        db.execSQL(createCoupon);


    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        if (oldVersion < 2) {
            db.execSQL("CREATE TABLE cart (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "user_id INTEGER, " +
                    "product_name TEXT, " +
                    "product_desc TEXT, " +
                    "price REAL, " +
                    "original_price REAL, " +
                    "quantity INTEGER DEFAULT 1, " +
                    "image_res INTEGER DEFAULT 0, " +
                    "FOREIGN KEY(user_id) REFERENCES users(id))");
        }
        if (oldVersion < 3) {
            db.execSQL("CREATE TABLE addresses (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "user_id INTEGER, " +
                    "receiver_name TEXT, " +
                    "phone TEXT, " +
                    "province TEXT, " +
                    "city TEXT, " +
                    "district TEXT, " +
                    "detail TEXT, " +
                    "is_default INTEGER DEFAULT 0, " +
                    "FOREIGN KEY(user_id) REFERENCES users(id))");
        }
        if (oldVersion < 4) {
            db.execSQL("CREATE TABLE orders (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "order_no TEXT UNIQUE, " +
                    "user_id INTEGER, " +
                    "product_name TEXT, " +
                    "product_desc TEXT, " +
                    "price REAL, " +
                    "quantity INTEGER, " +
                    "total_price REAL, " +
                    "address_id INTEGER, " +
                    "status INTEGER DEFAULT 1, " +
                    "create_time TEXT, " +
                    "pay_time TEXT, " +
                    "FOREIGN KEY(user_id) REFERENCES users(id))");
        }
        if (oldVersion < 5) {
            db.execSQL("CREATE TABLE service_orders (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "user_id INTEGER, " +
                    "service_type TEXT, " +
                    "pet_name TEXT, " +
                    "pet_type TEXT, " +
                    "service_name TEXT, " +
                    "service_date TEXT, " +
                    "service_time TEXT, " +
                    "address TEXT, " +
                    "remark TEXT, " +
                    "status INTEGER DEFAULT 1, " +
                    "create_time TEXT, " +
                    "FOREIGN KEY(user_id) REFERENCES users(id))");
        }
        if (oldVersion < 6) {
            // ⭐ 升级订单表，添加 ship_time 和 complete_time 字段
            db.execSQL("ALTER TABLE orders ADD COLUMN ship_time TEXT");
            db.execSQL("ALTER TABLE orders ADD COLUMN complete_time TEXT");
        }

        if (oldVersion < 7) {
            db.execSQL("CREATE TABLE coupons (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "user_id INTEGER, " +
                    "coupon_no TEXT UNIQUE, " +
                    "title TEXT, " +
                    "type INTEGER, " +
                    "discount_value REAL, " +
                    "min_amount REAL, " +
                    "max_discount REAL, " +
                    "source TEXT, " +
                    "start_time TEXT, " +
                    "end_time TEXT, " +
                    "status INTEGER DEFAULT 1, " +
                    "create_time TEXT, " +
                    "use_time TEXT, " +
                    "order_id INTEGER, " +
                    "FOREIGN KEY(user_id) REFERENCES users(id))");
        }

        if (oldVersion < 8) {
            db.execSQL("ALTER TABLE orders ADD COLUMN rating REAL DEFAULT 0");
            db.execSQL("ALTER TABLE orders ADD COLUMN comment TEXT");
        }

        // 添加评价字段
        try {
            db.execSQL("ALTER TABLE orders ADD COLUMN rating REAL DEFAULT 0");
            db.execSQL("ALTER TABLE orders ADD COLUMN comment TEXT");
        } catch (Exception e) {
            // 忽略错误
        }
    }

    // 在 DatabaseHelper 中添加这个方法
    public void addRatingAndCommentColumns(SQLiteDatabase db) {
        try {
            db.execSQL("ALTER TABLE orders ADD COLUMN rating REAL DEFAULT 0");
            db.execSQL("ALTER TABLE orders ADD COLUMN comment TEXT");
        } catch (Exception e) {
            // 如果字段已存在，忽略错误
            e.printStackTrace();
        }
    }
}