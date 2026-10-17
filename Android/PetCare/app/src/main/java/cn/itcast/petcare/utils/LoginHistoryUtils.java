package cn.itcast.petcare.utils;

import android.content.Context;
import android.content.SharedPreferences;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class LoginHistoryUtils {
    private static final String SP_NAME = "login_history";
    private static final String KEY_HISTORY = "history_list";
    private static final int MAX_HISTORY = 5;

    /**
     * 保存登录记录（去重，最新在前）
     */
    public static void saveLoginHistory(Context context, String phone) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        String historyStr = sp.getString(KEY_HISTORY, "");
        List<String> list = new ArrayList<>();

        // 解析已有历史
        if (!historyStr.isEmpty()) {
            list = new ArrayList<>(Arrays.asList(historyStr.split(",")));
        }

        // 移除重复的
        list.remove(phone);

        // 插入到最前面
        list.add(0, phone);

        // 只保留最多5条
        if (list.size() > MAX_HISTORY) {
            list = list.subList(0, MAX_HISTORY);
        }

        // 保存
        String newHistory = String.join(",", list);
        sp.edit().putString(KEY_HISTORY, newHistory).apply();
    }

    /**
     * 获取历史登录记录列表
     */
    public static List<String> getLoginHistory(Context context) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        String historyStr = sp.getString(KEY_HISTORY, "");
        if (historyStr.isEmpty()) {
            return new ArrayList<>();
        }
        return new ArrayList<>(Arrays.asList(historyStr.split(",")));
    }

    /**
     * 清空历史记录
     */
    public static void clearHistory(Context context) {
        SharedPreferences sp = context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        sp.edit().remove(KEY_HISTORY).apply();
    }
}