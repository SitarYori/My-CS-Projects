package cn.itcast.petcare.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import cn.itcast.petcare.model.Address;
import java.util.ArrayList;
import java.util.List;

public class AddressDao {
    private final DatabaseHelper dbHelper;

    public AddressDao(Context context) {
        dbHelper = new DatabaseHelper(context);
    }

    /**
     * 添加地址
     */
    public long addAddress(Address address) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("user_id", address.getUserId());
        values.put("receiver_name", address.getReceiverName());
        values.put("phone", address.getPhone());
        values.put("province", address.getProvince());
        values.put("city", address.getCity());
        values.put("district", address.getDistrict());
        values.put("detail", address.getDetail());
        values.put("is_default", address.isDefault() ? 1 : 0);
        return db.insert("addresses", null, values);
    }

    /**
     * 获取用户所有地址
     */
    public List<Address> getAddressesByUserId(int userId) {
        List<Address> list = new ArrayList<>();
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT * FROM addresses WHERE user_id = ? ORDER BY is_default DESC, id DESC";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(userId)});

        while (cursor.moveToNext()) {
            Address address = new Address();
            int idIndex = cursor.getColumnIndex("id");
            int userIdIndex = cursor.getColumnIndex("user_id");
            int nameIndex = cursor.getColumnIndex("receiver_name");
            int phoneIndex = cursor.getColumnIndex("phone");
            int provinceIndex = cursor.getColumnIndex("province");
            int cityIndex = cursor.getColumnIndex("city");
            int districtIndex = cursor.getColumnIndex("district");
            int detailIndex = cursor.getColumnIndex("detail");
            int defaultIndex = cursor.getColumnIndex("is_default");

            if (idIndex >= 0) address.setId(cursor.getInt(idIndex));
            if (userIdIndex >= 0) address.setUserId(cursor.getInt(userIdIndex));
            if (nameIndex >= 0) address.setReceiverName(cursor.getString(nameIndex));
            if (phoneIndex >= 0) address.setPhone(cursor.getString(phoneIndex));
            if (provinceIndex >= 0) address.setProvince(cursor.getString(provinceIndex));
            if (cityIndex >= 0) address.setCity(cursor.getString(cityIndex));
            if (districtIndex >= 0) address.setDistrict(cursor.getString(districtIndex));
            if (detailIndex >= 0) address.setDetail(cursor.getString(detailIndex));
            if (defaultIndex >= 0) address.setDefault(cursor.getInt(defaultIndex) == 1);

            list.add(address);
        }
        cursor.close();
        return list;
    }

    /**
     * 获取默认地址
     */
    public Address getDefaultAddress(int userId) {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        String sql = "SELECT * FROM addresses WHERE user_id = ? AND is_default = 1";
        Cursor cursor = db.rawQuery(sql, new String[]{String.valueOf(userId)});

        if (cursor.moveToFirst()) {
            Address address = new Address();
            int idIndex = cursor.getColumnIndex("id");
            int nameIndex = cursor.getColumnIndex("receiver_name");
            int phoneIndex = cursor.getColumnIndex("phone");
            int provinceIndex = cursor.getColumnIndex("province");
            int cityIndex = cursor.getColumnIndex("city");
            int districtIndex = cursor.getColumnIndex("district");
            int detailIndex = cursor.getColumnIndex("detail");

            if (idIndex >= 0) address.setId(cursor.getInt(idIndex));
            if (nameIndex >= 0) address.setReceiverName(cursor.getString(nameIndex));
            if (phoneIndex >= 0) address.setPhone(cursor.getString(phoneIndex));
            if (provinceIndex >= 0) address.setProvince(cursor.getString(provinceIndex));
            if (cityIndex >= 0) address.setCity(cursor.getString(cityIndex));
            if (districtIndex >= 0) address.setDistrict(cursor.getString(districtIndex));
            if (detailIndex >= 0) address.setDetail(cursor.getString(detailIndex));
            address.setDefault(true);
            cursor.close();
            return address;
        }
        cursor.close();
        return null;
    }

    /**
     * 更新地址
     */
    public int updateAddress(Address address) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("receiver_name", address.getReceiverName());
        values.put("phone", address.getPhone());
        values.put("province", address.getProvince());
        values.put("city", address.getCity());
        values.put("district", address.getDistrict());
        values.put("detail", address.getDetail());
        values.put("is_default", address.isDefault() ? 1 : 0);
        return db.update("addresses", values, "id = ?", new String[]{String.valueOf(address.getId())});
    }

    /**
     * 删除地址
     */
    public int deleteAddress(int addressId) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        return db.delete("addresses", "id = ?", new String[]{String.valueOf(addressId)});
    }

    /**
     * 设为默认地址（取消其他默认）
     */
    public void setDefaultAddress(int userId, int addressId) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        // 取消所有默认
        ContentValues values = new ContentValues();
        values.put("is_default", 0);
        db.update("addresses", values, "user_id = ?", new String[]{String.valueOf(userId)});
        // 设置新的默认
        values.put("is_default", 1);
        db.update("addresses", values, "id = ?", new String[]{String.valueOf(addressId)});
    }
}