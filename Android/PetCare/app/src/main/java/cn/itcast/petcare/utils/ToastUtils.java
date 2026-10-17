package cn.itcast.petcare.utils;   // ← 确认是 utils

import android.content.Context;
import android.widget.Toast;

public class ToastUtils {
    private static Toast toast;

    public static void showShort(Context context, String msg) {
        if (toast != null) {
            toast.cancel();
        }
        toast = Toast.makeText(context, msg, Toast.LENGTH_SHORT);
        toast.show();
    }

    public static void showLong(Context context, String msg) {
        if (toast != null) {
            toast.cancel();
        }
        toast = Toast.makeText(context, msg, Toast.LENGTH_LONG);
        toast.show();
    }
}