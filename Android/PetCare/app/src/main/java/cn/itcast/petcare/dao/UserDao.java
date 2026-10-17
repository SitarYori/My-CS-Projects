package cn.itcast.petcare.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import cn.itcast.petcare.model.User;

public class UserDao {
    private final DatabaseHelper dbHelper;   // ← 添加 final

    public UserDao(Context context) {
        dbHelper = new DatabaseHelper(context);
    }

    /**
     * 注册：插入新用户
     */
    public long register(User user) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("phone", user.getPhone());
        values.put("password", user.getPassword());
        values.put("username", user.getUsername());
        values.put("avatar", user.getAvatar());
        return db.insert("users", null, values);
    }

    /**
     * 登录：根据手机号和密码查询用户
     */
    public User login(String phone, String password) {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT * FROM users WHERE phone = ? AND password = ?";
        Cursor cursor = db.rawQuery(sql, new String[]{phone, password});

        if (cursor.moveToFirst()) {
            User user = new User();

            // 使用 getColumnIndex 并检查返回值
            int idIndex = cursor.getColumnIndex("id");
            int phoneIndex = cursor.getColumnIndex("phone");
            int passwordIndex = cursor.getColumnIndex("password");
            int usernameIndex = cursor.getColumnIndex("username");
            int avatarIndex = cursor.getColumnIndex("avatar");

            // 只有索引有效时才取值（> -1）
            if (idIndex >= 0) {
                user.setId(cursor.getInt(idIndex));
            }
            if (phoneIndex >= 0) {
                user.setPhone(cursor.getString(phoneIndex));
            }
            if (passwordIndex >= 0) {
                user.setPassword(cursor.getString(passwordIndex));
            }
            if (usernameIndex >= 0) {
                user.setUsername(cursor.getString(usernameIndex));
            }
            if (avatarIndex >= 0) {
                user.setAvatar(cursor.getString(avatarIndex));
            }

            cursor.close();
            return user;
        }
        cursor.close();
        return null;
    }

    /**
     * 检查手机号是否已注册
     */
    public boolean isPhoneExist(String phone) {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT * FROM users WHERE phone = ?";
        Cursor cursor = db.rawQuery(sql, new String[]{phone});
        boolean exists = cursor.moveToFirst();
        cursor.close();
        return exists;
    }

    /**
     * 根据手机号获取用户
     */
    public User getUserByPhone(String phone) {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT * FROM users WHERE phone = ?";
        Cursor cursor = db.rawQuery(sql, new String[]{phone});

        if (cursor.moveToFirst()) {
            User user = new User();

            int idIndex = cursor.getColumnIndex("id");
            int phoneIndex = cursor.getColumnIndex("phone");
            int passwordIndex = cursor.getColumnIndex("password");
            int usernameIndex = cursor.getColumnIndex("username");
            int avatarIndex = cursor.getColumnIndex("avatar");

            if (idIndex >= 0) {
                user.setId(cursor.getInt(idIndex));
            }
            if (phoneIndex >= 0) {
                user.setPhone(cursor.getString(phoneIndex));
            }
            if (passwordIndex >= 0) {
                user.setPassword(cursor.getString(passwordIndex));
            }
            if (usernameIndex >= 0) {
                user.setUsername(cursor.getString(usernameIndex));
            }
            if (avatarIndex >= 0) {
                user.setAvatar(cursor.getString(avatarIndex));
            }

            cursor.close();
            return user;
        }
        cursor.close();
        return null;
    }
}