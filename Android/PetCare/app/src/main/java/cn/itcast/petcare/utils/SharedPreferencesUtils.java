package cn.itcast.petcare.utils;

import android.content.Context;
import android.content.SharedPreferences;


public class SharedPreferencesUtils {
    private static final String SP_NAME = "petcare_prefs";
    private static final String KEY_USER_ID = "user_id";
    private static final String KEY_USER_PHONE = "user_phone";
    private static final String KEY_USERNAME = "username";
    private static final String KEY_IS_LOGIN = "is_login";

    private static final String KEY_BALANCE = "balance";

    private static final String KEY_MEMBER_POINTS = "member_points";


    /**
     * 保存登录信息
     */
    public static void saveLoginInfo(Context context, int userId, String phone, String username) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        editor.putInt(KEY_USER_ID, userId);
        editor.putString(KEY_USER_PHONE, phone);
        editor.putString(KEY_USERNAME, username);
        editor.putBoolean(KEY_IS_LOGIN, true);
        editor.apply();
    }

    /**
     * 清除登录信息
     */
    public static void clearLoginInfo(Context context) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        editor.clear();
        editor.apply();
    }

    /**
     * ⭐ 获取当前用户ID
     */
    public static int getUserId(Context context) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        return sp.getInt(KEY_USER_ID, -1);
    }

    /**
     * 获取当前用户手机号
     */
    public static String getUserPhone(Context context) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        return sp.getString(KEY_USER_PHONE, "");
    }

    /**
     * 获取当前用户名
     */
    public static String getUsername(Context context) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        return sp.getString(KEY_USERNAME, "");
    }

    /**
     * 判断是否已登录
     */
    public static boolean isLogin(Context context) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        return sp.getBoolean(KEY_IS_LOGIN, false);
    }

    /**
     * 获取余额
     */
    public static double getBalance(Context context) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        return sp.getFloat(KEY_BALANCE, 0f);
    }

    /**
     * 保存余额
     */
    public static void saveBalance(Context context, double balance) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        sp.edit().putFloat(KEY_BALANCE, (float) balance).apply();
    }

    // 添加方法
    public static int getMemberPoints(Context context) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        return sp.getInt(KEY_MEMBER_POINTS, 0);
    }

    public static void addMemberPoints(Context context, int points) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        int current = sp.getInt(KEY_MEMBER_POINTS, 0);
        sp.edit().putInt(KEY_MEMBER_POINTS, current + points).apply();
    }
}