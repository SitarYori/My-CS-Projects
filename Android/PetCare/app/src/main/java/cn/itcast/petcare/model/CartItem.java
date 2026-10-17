package cn.itcast.petcare.model;

import java.io.Serializable;

public class CartItem implements Serializable {
    private int id;
    private int userId;
    private String productName;
    private String productDesc;  //商品描述
    private double price;
    private double originalPrice;
    private int quantity;
    private int imageRes;

    public CartItem() {}

    public CartItem(String productName, String productDesc, double price, double originalPrice, int quantity) {
        this.productName = productName;
        this.productDesc = productDesc;
        this.price = price;
        this.originalPrice = originalPrice;
        this.quantity = quantity;
    }

    // Getter 和 Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductDesc() { return productDesc; }
    public void setProductDesc(String productDesc) { this.productDesc = productDesc; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public double getOriginalPrice() { return originalPrice; }
    public void setOriginalPrice(double originalPrice) { this.originalPrice = originalPrice; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getImageRes() { return imageRes; }
    public void setImageRes(int imageRes) { this.imageRes = imageRes; }

    public double getTotalPrice() {
        return price * quantity;
    }
}