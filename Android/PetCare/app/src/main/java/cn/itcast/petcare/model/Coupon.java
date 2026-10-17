package cn.itcast.petcare.model;

import java.io.Serializable;

/**
 * 优惠券数据模型
 */
public class Coupon implements Serializable {

    // ==================== 优惠类型常量 ====================

    /** 满减券：满X元减Y元 */
    public static final int TYPE_FULL_REDUCE = 1;

    /** 折扣券：打X折（如0.9表示9折） */
    public static final int TYPE_DISCOUNT = 2;

    /** 免运费券：减免运费 */
    public static final int TYPE_FREE_SHIPPING = 3;

    // ==================== 优惠券状态常量 ====================

    /** 未使用 */
    public static final int STATUS_UNUSED = 1;

    /** 已使用 */
    public static final int STATUS_USED = 2;

    /** 已过期 */
    public static final int STATUS_EXPIRED = 3;

    // ==================== 字段 ====================

    private int id;
    private int userId;
    private String couponNo;
    private String title;
    private int type;
    private double discountValue;
    private double minAmount;
    private double maxDiscount;
    private String source;
    private String startTime;
    private String endTime;
    private int status;
    private String createTime;
    private String useTime;
    private int orderId;

    // ==================== Getter / Setter ====================

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCouponNo() { return couponNo; }
    public void setCouponNo(String couponNo) { this.couponNo = couponNo; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getType() { return type; }
    public void setType(int type) { this.type = type; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public double getMinAmount() { return minAmount; }
    public void setMinAmount(double minAmount) { this.minAmount = minAmount; }

    public double getMaxDiscount() { return maxDiscount; }
    public void setMaxDiscount(double maxDiscount) { this.maxDiscount = maxDiscount; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }

    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }

    public String getUseTime() { return useTime; }
    public void setUseTime(String useTime) { this.useTime = useTime; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    // ==================== 辅助方法 ====================

    /**
     * 获取优惠类型文字
     */
    public String getTypeText() {
        switch (type) {
            case TYPE_FULL_REDUCE: return "满减券";
            case TYPE_DISCOUNT: return "折扣券";
            case TYPE_FREE_SHIPPING: return "免运费券";
            default: return "优惠券";
        }
    }

    /**
     * 获取状态文字
     */
    public String getStatusText() {
        switch (status) {
            case STATUS_UNUSED: return "未使用";
            case STATUS_USED: return "已使用";
            case STATUS_EXPIRED: return "已过期";
            default: return "未知";
        }
    }

    /**
     * 获取优惠描述（满100减15 / 9折 / 免运费）
     */
    public String getDescription() {
        switch (type) {
            case TYPE_FULL_REDUCE:
                return "满" + (int)minAmount + "减" + (int)discountValue;
            case TYPE_DISCOUNT:
                return (int)(discountValue * 10) + "折";
            case TYPE_FREE_SHIPPING:
                return "免运费";
            default:
                return "";
        }
    }

    /**
     * 计算优惠金额
     *
     * @param orderAmount 订单金额
     * @return 优惠金额
     */
    public double calculateDiscount(double orderAmount) {
        if (status != STATUS_UNUSED) return 0;
        if (orderAmount < minAmount) return 0;

        switch (type) {
            case TYPE_FULL_REDUCE:
                return discountValue;
            case TYPE_DISCOUNT:
                double discount = orderAmount * (1 - discountValue);
                if (maxDiscount > 0 && discount > maxDiscount) {
                    discount = maxDiscount;
                }
                return discount;
            case TYPE_FREE_SHIPPING:
                return 5.0;  // 假设运费5元
            default:
                return 0;
        }
    }

    /**
     * 检查优惠券是否有效（未使用且未过期）
     */
    public boolean isValid() {
        return status == STATUS_UNUSED;
    }
}