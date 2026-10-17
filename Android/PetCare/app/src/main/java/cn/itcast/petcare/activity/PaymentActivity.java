package cn.itcast.petcare.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import cn.itcast.petcare.R;
import cn.itcast.petcare.dao.CartDao;
import cn.itcast.petcare.dao.CouponDao;
import cn.itcast.petcare.dao.OrderDao;
import cn.itcast.petcare.model.CartItem;
import cn.itcast.petcare.model.Order;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class PaymentActivity extends AppCompatActivity {

    private ImageView ivBack;
    private TextView tvPayAmount;
    private LinearLayout llWechat, llAlipay;
    private ImageView ivWechatCheck, ivAlipayCheck;
    private Button btnConfirmPay;

    private int selectedMethod = 1;
    private double totalPrice;      // ⭐ 优惠后的价格（实付款）
    private DecimalFormat df = new DecimalFormat("0.00");

    private int addressId;
    private int couponId;
    private List<CartItem> cartList;

    private CouponDao couponDao;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_payment);

        // ⭐ totalPrice 已经是优惠后的价格（来自 CheckoutActivity）
        totalPrice = getIntent().getDoubleExtra("total_price", 0);
        addressId = getIntent().getIntExtra("address_id", 0);
        couponId = getIntent().getIntExtra("coupon_id", 0);

        couponDao = new CouponDao(this);

        initViews();
        setListeners();
        updateUI();
        selectMethod(1);
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        tvPayAmount = findViewById(R.id.tv_pay_amount);
        llWechat = findViewById(R.id.ll_wechat);
        llAlipay = findViewById(R.id.ll_alipay);
        ivWechatCheck = findViewById(R.id.iv_wechat_check);
        ivAlipayCheck = findViewById(R.id.iv_alipay_check);
        btnConfirmPay = findViewById(R.id.btn_confirm_pay);

        tvPayAmount.setText("¥" + df.format(totalPrice));
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());

        llWechat.setOnClickListener(v -> selectMethod(1));
        llAlipay.setOnClickListener(v -> selectMethod(2));

        btnConfirmPay.setOnClickListener(v -> showPaymentConfirmDialog());
    }

    private void selectMethod(int method) {
        selectedMethod = method;
        updateUI();
    }

    private void updateUI() {
        if (selectedMethod == 1) {
            ivWechatCheck.setImageResource(R.drawable.ic_check_selected);
            ivAlipayCheck.setImageResource(R.drawable.ic_check_normal);
            llWechat.setBackgroundColor(getResources().getColor(android.R.color.white));
            llAlipay.setBackgroundColor(getResources().getColor(android.R.color.darker_gray));
        } else {
            ivWechatCheck.setImageResource(R.drawable.ic_check_normal);
            ivAlipayCheck.setImageResource(R.drawable.ic_check_selected);
            llWechat.setBackgroundColor(getResources().getColor(android.R.color.darker_gray));
            llAlipay.setBackgroundColor(getResources().getColor(android.R.color.white));
        }
    }

    private void showPaymentConfirmDialog() {
        String methodName = selectedMethod == 1 ? "微信支付" : "支付宝支付";

        new AlertDialog.Builder(this)
                .setTitle("确认支付")
                .setMessage("确认使用 " + methodName + " 支付 ¥" + df.format(totalPrice) + " 吗？")
                .setPositiveButton("确认支付", (dialog, which) -> {
                    doPayment(true);
                })
                .setNegativeButton("取消支付", (dialog, which) -> {
                    doPayment(false);
                })
                .setCancelable(true)
                .show();
    }

    private void doPayment(boolean isPaid) {
        int userId = SharedPreferencesUtils.getUserId(this);
        if (userId == -1) {
            ToastUtils.showShort(this, "请先登录");
            return;
        }

        CartDao cartDao = new CartDao(this);
        OrderDao orderDao = new OrderDao(this);

        cartList = cartDao.getCartItems(userId);
        if (cartList == null || cartList.isEmpty()) {
            ToastUtils.showShort(this, "购物车为空");
            return;
        }

        String currentTime = getCurrentTime();

        for (CartItem item : cartList) {
            Order order = new Order();
            order.setOrderNo(generateOrderNo());
            order.setUserId(userId);
            order.setProductName(item.getProductName());
            order.setProductDesc(item.getProductDesc());
            order.setPrice(item.getPrice());
            order.setQuantity(item.getQuantity());

            // ⭐ 关键修改：总价 = 单品价格 × 数量，但订单总价要按比例分摊优惠后的金额
            // 如果有多件商品，按比例分配优惠后的总价
            double itemTotal = item.getPrice() * item.getQuantity();
            // 计算每件商品在总价中的占比，然后乘以优惠后的总价
            double originalTotal = 0;
            for (CartItem ci : cartList) {
                originalTotal += ci.getPrice() * ci.getQuantity();
            }

            if (isPaid) {
                // ⭐ 已支付：订单总价 = 优惠后的分摊金额
                double discountRatio = originalTotal > 0 ? itemTotal / originalTotal : 0;
                double discountedItemTotal = totalPrice * discountRatio;
                order.setTotalPrice(discountedItemTotal);
                order.setStatus(Order.STATUS_PAID);
                order.setPayTime(currentTime);
                order.setCompleteTime(null);
            } else {
                // ⭐ 未支付：订单总价 = 原价（未使用优惠券）
                order.setTotalPrice(itemTotal);
                order.setStatus(Order.STATUS_PENDING);
                order.setPayTime(null);
                order.setCompleteTime(null);
            }

            order.setAddressId(addressId);
            order.setCreateTime(currentTime);

            orderDao.createOrder(order);
        }

        cartDao.clearCart(userId);

        // 如果支付成功且有使用优惠券，标记为已使用
        if (isPaid && couponId > 0) {
            try {
                List<Order> orders = orderDao.getOrdersByUserId(userId);
                int orderId = 0;
                if (orders != null && !orders.isEmpty()) {
                    orderId = orders.get(0).getId();
                }
                couponDao.useCoupon(couponId, orderId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (isPaid) {
            ToastUtils.showShort(this, "支付成功！共 " + cartList.size() + " 件商品");
        } else {
            ToastUtils.showShort(this, "已取消支付，订单状态为待付款");
        }

        Intent intent = new Intent(PaymentActivity.this, OrderListActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        finish();
    }

    private String generateOrderNo() {
        return "BK" + System.currentTimeMillis();
    }

    private String getCurrentTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.CHINA);
        return sdf.format(new Date());
    }
}