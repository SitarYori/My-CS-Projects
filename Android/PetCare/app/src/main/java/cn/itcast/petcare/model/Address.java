package cn.itcast.petcare.model;

import java.io.Serializable;

public class Address implements Serializable {
    private int id;
    private int userId;
    private String receiverName;
    private String phone;
    private String province;
    private String city;
    private String district;
    private String detail;
    private boolean isDefault;

    public Address() {}

    public Address(String receiverName, String phone, String province,
                   String city, String district, String detail, boolean isDefault) {
        this.receiverName = receiverName;
        this.phone = phone;
        this.province = province;
        this.city = city;
        this.district = district;
        this.detail = detail;
        this.isDefault = isDefault;
    }

    // Getter 和 Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getReceiverName() { return receiverName; }
    public void setReceiverName(String receiverName) { this.receiverName = receiverName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getProvince() { return province; }
    public void setProvince(String province) { this.province = province; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getDetail() { return detail; }
    public void setDetail(String detail) { this.detail = detail; }

    public boolean isDefault() { return isDefault; }
    public void setDefault(boolean aDefault) { isDefault = aDefault; }

    public String getFullAddress() {
        return province + city + district + detail;
    }
}