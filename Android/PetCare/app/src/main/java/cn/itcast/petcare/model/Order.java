package cn.itcast.petcare.model;

import java.io.Serializable;

public class Order implements Serializable {

    // 订单状态常量
    public static final int STATUS_PENDING = 1;   // 待付款
    public static final int STATUS_PAID = 2;      // 已支付
    public static final int STATUS_COMPLETED = 3; // 已完成
    public static final int STATUS_CANCELLED = 4; // 已取消

    private int id;
    private String orderNo;
    private int userId;
    private String productName;
    private String productDesc;
    private double price;
    private int quantity;
    private double totalPrice;
    private int addressId;
    private int status;
    private String createTime;
    private String payTime;
    private String shipTime;
    private String completeTime;

    // ⭐ 新增评价字段
    private float rating;        // 评分（1-5）
    private String comment;      // 评价内容

    // 关联字段
    private String addressDetail;
    private String receiverName;
    private String receiverPhone;

    public Order() {}

    // ========== Getter 和 Setter ==========
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String orderNo) { this.orderNo = orderNo; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductDesc() { return productDesc; }
    public void setProductDesc(String productDesc) { this.productDesc = productDesc; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public int getAddressId() { return addressId; }
    public void setAddressId(int addressId) { this.addressId = addressId; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }

    public String getPayTime() { return payTime; }
    public void setPayTime(String payTime) { this.payTime = payTime; }

    public String getShipTime() { return shipTime; }  // ⭐ 添加
    public void setShipTime(String shipTime) { this.shipTime = shipTime; }  // ⭐ 添加

    public String getCompleteTime() { return completeTime; }  // ⭐ 添加
    public void setCompleteTime(String completeTime) { this.completeTime = completeTime; }  // ⭐ 添加

    public String getAddressDetail() { return addressDetail; }
    public void setAddressDetail(String addressDetail) { this.addressDetail = addressDetail; }

    public String getReceiverName() { return receiverName; }
    public void setReceiverName(String receiverName) { this.receiverName = receiverName; }

    public String getReceiverPhone() { return receiverPhone; }
    public void setReceiverPhone(String receiverPhone) { this.receiverPhone = receiverPhone; }

    // ⭐ 评价的 Getter/Setter
    public float getRating() { return rating; }// 获取评分
    public void setRating(float rating) { this.rating = rating; }// 获取评价内容

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    // ⭐ 判断是否已评价
    public boolean isReviewed() {
        return rating > 0;
    }


    /**
     * 获取状态文字描述
     */
    public String getStatusText() {
        switch (status) {
            case STATUS_PENDING: return "待付款";
            case STATUS_PAID: return "已支付";
            case STATUS_COMPLETED: return "已完成";
            case STATUS_CANCELLED: return "已取消";
            default: return "未知";
        }
    }

    public int getStatusColor() {
        switch (status) {
            case STATUS_PENDING: return 0xFFFF9800;
            case STATUS_PAID: return 0xFF2196F3;
            case STATUS_COMPLETED: return 0xFF4CAF50;
            case STATUS_CANCELLED: return 0xFF9E9E9E;
            default: return 0xFF000000;
        }
    }
}