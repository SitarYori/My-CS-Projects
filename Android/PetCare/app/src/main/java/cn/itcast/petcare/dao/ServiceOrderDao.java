package cn.itcast.petcare.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import cn.itcast.petcare.model.ServiceOrder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class ServiceOrderDao {
    private final DatabaseHelper dbHelper;

    public ServiceOrderDao(Context context) {
        dbHelper = new DatabaseHelper(context);
    }

    /**
     * 创建服务预约
     */
    public long createServiceOrder(ServiceOrder order) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("user_id", order.getUserId());
        values.put("service_type", order.getServiceType());
        values.put("pet_name", order.getPetName());
        values.put("pet_type", order.getPetType());
        values.put("service_name", order.getServiceName());
        values.put("service_date", order.getServiceDate());
        values.put("service_time", order.getServiceTime());
        values.put("address", order.getAddress());
        values.put("remark", order.getRemark());
        values.put("status", order.getStatus());
        values.put("create_time", getCurrentTime());
        return db.insert("service_orders", null, values);
    }

    /**
     * 获取用户的所有服务预约
     */
    public List<ServiceOrder> getServiceOrdersByUserId(int userId) {
        List<ServiceOrder> list = new ArrayList<>();
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT * FROM service_orders WHERE user_id = ? ORDER BY id DESC";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(userId)});

        while (cursor.moveToNext()) {
            ServiceOrder order = new ServiceOrder();
            int idIndex = cursor.getColumnIndex("id");
            int userIdIndex = cursor.getColumnIndex("user_id");
            int typeIndex = cursor.getColumnIndex("service_type");
            int petNameIndex = cursor.getColumnIndex("pet_name");
            int petTypeIndex = cursor.getColumnIndex("pet_type");
            int serviceNameIndex = cursor.getColumnIndex("service_name");
            int dateIndex = cursor.getColumnIndex("service_date");
            int timeIndex = cursor.getColumnIndex("service_time");
            int addressIndex = cursor.getColumnIndex("address");
            int remarkIndex = cursor.getColumnIndex("remark");
            int statusIndex = cursor.getColumnIndex("status");
            int createTimeIndex = cursor.getColumnIndex("create_time");

            if (idIndex >= 0) order.setId(cursor.getInt(idIndex));
            if (userIdIndex >= 0) order.setUserId(cursor.getInt(userIdIndex));
            if (typeIndex >= 0) order.setServiceType(cursor.getString(typeIndex));
            if (petNameIndex >= 0) order.setPetName(cursor.getString(petNameIndex));
            if (petTypeIndex >= 0) order.setPetType(cursor.getString(petTypeIndex));
            if (serviceNameIndex >= 0) order.setServiceName(cursor.getString(serviceNameIndex));
            if (dateIndex >= 0) order.setServiceDate(cursor.getString(dateIndex));
            if (timeIndex >= 0) order.setServiceTime(cursor.getString(timeIndex));
            if (addressIndex >= 0) order.setAddress(cursor.getString(addressIndex));
            if (remarkIndex >= 0) order.setRemark(cursor.getString(remarkIndex));
            if (statusIndex >= 0) order.setStatus(cursor.getInt(statusIndex));
            if (createTimeIndex >= 0) order.setCreateTime(cursor.getString(createTimeIndex));

            list.add(order);
        }
        cursor.close();
        return list;
    }

    /**
     * 更新预约状态
     */
    public int updateStatus(int orderId, int status) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("status", status);
        return db.update("service_orders", values, "id = ?", new String[]{String.valueOf(orderId)});
    }

    private String getCurrentTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.CHINA);
        return sdf.format(new Date());
    }
}