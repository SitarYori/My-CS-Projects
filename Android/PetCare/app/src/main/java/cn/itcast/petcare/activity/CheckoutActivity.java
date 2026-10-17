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
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.adapter.CheckoutProductAdapter;
import cn.itcast.petcare.dao.AddressDao;
import cn.itcast.petcare.dao.CartDao;
import cn.itcast.petcare.dao.CouponDao;
import cn.itcast.petcare.model.Address;
import cn.itcast.petcare.model.CartItem;
import cn.itcast.petcare.model.Coupon;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;
import java.text.DecimalFormat;
import java.util.List;

/**
 * 确认订单页面
 *
 * 功能：收货地址选择、商品列表展示、优惠券选择、订单总价计算
 *
 * 来源：从购物车点击"去结算"进入
 * 跳转：点击"去支付"跳转到支付页面
 */
public class CheckoutActivity extends AppCompatActivity {

    // ==================== 控件声明 ====================

    private ImageView ivBack;
    private LinearLayout llAddress;
    private TextView tvAddress, tvAddressDetail, tvTotalPrice;
    private RecyclerView rvProducts;
    private Button btnPay;

    // 优惠券相关控件
    private TextView tvCoupon;
    private LinearLayout llCoupon;
    private TextView tvOriginalPrice;    // 商品合计
    private LinearLayout llDiscount;     // 优惠区域
    private TextView tvDiscount;         // 优惠金额

    // ==================== 数据变量 ====================

    private AddressDao addressDao;
    private CartDao cartDao;

    private Address selectedAddress;
    private List<CartItem> cartList;

    private double totalPrice = 0;        // 原始总价
    private double finalPrice = 0;        // 优惠后总价
    private double discountAmount = 0;    // 优惠金额
    private Coupon selectedCoupon = null; // 选中的优惠券

    private DecimalFormat df = new DecimalFormat("0.00");

    private static final int REQUEST_ADDRESS = 1001;

    // ==================== 生命周期方法 ====================

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_checkout);

        addressDao = new AddressDao(this);
        cartDao = new CartDao(this);

        initViews();
        setListeners();
        loadData();
    }

    // ==================== 初始化方法 ====================

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        llAddress = findViewById(R.id.ll_address);
        tvAddress = findViewById(R.id.tv_address);
        tvAddressDetail = findViewById(R.id.tv_address_detail);
        tvTotalPrice = findViewById(R.id.tv_total_price);
        rvProducts = findViewById(R.id.rv_checkout_products);
        btnPay = findViewById(R.id.btn_pay);

        // 优惠券控件
        tvCoupon = findViewById(R.id.tv_coupon);
        llCoupon = findViewById(R.id.ll_coupon);
        tvOriginalPrice = findViewById(R.id.tv_original_price);
        llDiscount = findViewById(R.id.ll_discount);
        tvDiscount = findViewById(R.id.tv_discount);

        rvProducts.setLayoutManager(new LinearLayoutManager(this));
    }

    // ==================== 事件监听 ====================

    private void setListeners() {
        // 返回按钮
        ivBack.setOnClickListener(v -> finish());

        // 选择地址
        llAddress.setOnClickListener(v -> {
            Intent intent = new Intent(CheckoutActivity.this, AddressListActivity.class);
            intent.putExtra("select_mode", true);
            startActivityForResult(intent, REQUEST_ADDRESS);
        });

        // ⭐ 选择优惠券
        llCoupon.setOnClickListener(v -> showSelectCouponDialog());

        // 去支付
        btnPay.setOnClickListener(v -> {
            if (selectedAddress == null) {
                ToastUtils.showShort(this, "请选择收货地址");
                return;
            }

            int couponId = 0;
            if (selectedCoupon != null) {
                couponId = selectedCoupon.getId();
            }

            Intent intent = new Intent(CheckoutActivity.this, PaymentActivity.class);
            intent.putExtra("total_price", finalPrice);  // ⭐ 优惠后的价格
            intent.putExtra("address_id", selectedAddress.getId());
            intent.putExtra("coupon_id", couponId);
            startActivity(intent);
        });
    }

    // ==================== 数据加载 ====================

    private void loadData() {
        int userId = SharedPreferencesUtils.getUserId(this);
        if (userId == -1) {
            ToastUtils.showShort(this, "请先登录");
            finish();
            return;
        }



        // 获取购物车数据
        cartList = cartDao.getCartItems(userId);
        if (cartList == null || cartList.isEmpty()) {
            ToastUtils.showShort(this, "购物车为空");
            finish();
            return;
        }

        // 显示商品列表
        CheckoutProductAdapter adapter = new CheckoutProductAdapter(cartList);
        rvProducts.setAdapter(adapter);

        // 计算原始总价
        totalPrice = 0;
        for (CartItem item : cartList) {
            totalPrice += item.getPrice() * item.getQuantity();
        }

        // 显示商品合计
        tvOriginalPrice.setText("¥" + df.format(totalPrice));

        // 获取默认地址
        selectedAddress = addressDao.getDefaultAddress(userId);
        if (selectedAddress != null) {
            updateAddressDisplay();
        } else {
            tvAddress.setText("暂无收货地址，请点击添加");
            tvAddress.setTextColor(getResources().getColor(android.R.color.holo_red_light));
            tvAddressDetail.setVisibility(View.GONE);
        }

        // ⭐ 计算优惠后价格
        calculateFinalPrice();
    }

    // ==================== 优惠券方法 ====================

    /**
     * 计算优惠后价格
     */
    private void calculateFinalPrice() {
        discountAmount = 0;

        if (selectedCoupon != null) {
            discountAmount = selectedCoupon.calculateDiscount(totalPrice);

            if (discountAmount > 0) {
                // 优惠有效
                tvCoupon.setText(selectedCoupon.getTitle() + " -¥" + df.format(discountAmount));
                tvCoupon.setTextColor(getResources().getColor(android.R.color.holo_blue_dark));

                // 显示优惠明细
                llDiscount.setVisibility(View.VISIBLE);
                tvDiscount.setText("-¥" + df.format(discountAmount));
            } else {
                // 不满足优惠条件
                selectedCoupon = null;
                tvCoupon.setText("未使用优惠券");
                tvCoupon.setTextColor(getResources().getColor(android.R.color.darker_gray));
                llDiscount.setVisibility(View.GONE);
            }
        } else {
            tvCoupon.setText("未使用优惠券");
            tvCoupon.setTextColor(getResources().getColor(android.R.color.darker_gray));
            llDiscount.setVisibility(View.GONE);
        }

        // ⭐ 更新实付款（优惠后的价格）
        finalPrice = totalPrice - discountAmount;
        tvTotalPrice.setText("¥" + df.format(finalPrice));
    }

    /**
     * 显示选择优惠券对话框
     */
    private void showSelectCouponDialog() {
        int userId = SharedPreferencesUtils.getUserId(this);
        CouponDao couponDao = new CouponDao(this);
        List<Coupon> coupons = couponDao.getUnusedCoupons(userId);

        if (coupons == null || coupons.isEmpty()) {
            ToastUtils.showShort(this, "暂无可用优惠券");
            return;
        }

        // 构建选项列表
        String[] items = new String[coupons.size() + 1];
        items[0] = "不使用优惠券";
        for (int i = 0; i < coupons.size(); i++) {
            Coupon c = coupons.get(i);
            items[i + 1] = c.getTitle() + " (" + c.getDescription() + ") 有效期至" + c.getEndTime();
        }

        new AlertDialog.Builder(this)
                .setTitle("选择优惠券")
                .setItems(items, (dialog, which) -> {
                    if (which == 0) {
                        selectedCoupon = null;
                    } else {
                        selectedCoupon = coupons.get(which - 1);
                    }
                    calculateFinalPrice();  // 重新计算价格
                })
                .show();
    }

    // ==================== 地址方法 ====================

    private void updateAddressDisplay() {
        if (selectedAddress != null) {
            tvAddress.setText(selectedAddress.getReceiverName() + "  " + selectedAddress.getPhone());
            tvAddress.setTextColor(getResources().getColor(android.R.color.black));
            tvAddressDetail.setText(selectedAddress.getFullAddress());
            tvAddressDetail.setVisibility(View.VISIBLE);
        }
    }

    // ==================== 返回结果处理 ====================

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_ADDRESS && resultCode == RESULT_OK && data != null) {
            selectedAddress = (Address) data.getSerializableExtra("selected_address");
            if (selectedAddress != null) {
                updateAddressDisplay();
            }
        } else if (requestCode == REQUEST_ADDRESS && resultCode == RESULT_OK) {
            int userId = SharedPreferencesUtils.getUserId(this);
            selectedAddress = addressDao.getDefaultAddress(userId);
            if (selectedAddress != null) {
                updateAddressDisplay();
            }
        }
    }
}