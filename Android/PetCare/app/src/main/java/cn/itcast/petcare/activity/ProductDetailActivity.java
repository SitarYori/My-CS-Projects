package cn.itcast.petcare.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import cn.itcast.petcare.R;
import cn.itcast.petcare.dao.CartDao;
import cn.itcast.petcare.dialog.ProductSpecDialog;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;

public class ProductDetailActivity extends AppCompatActivity {

    private ImageView ivBack, ivCart;
    private ImageView ivProductImage;
    private RelativeLayout rlCartIcon;
    private TextView tvProductName, tvProductDesc, tvPrice, tvOriginalPrice, tvSales;
    private TextView tvCartCount;
    private Button btnAddCart, btnBuyNow;
    private CartDao cartDao;
    private int cartCount = 0;

    // 商品信息
    private String productName;
    private String productDesc;
    private double productPrice;
    private int productImage;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_product_detail);

        cartDao = new CartDao(this);

        initViews();
        setListeners();
        loadData();
        updateCartBadge();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        ivCart = findViewById(R.id.iv_cart);
        ivProductImage = findViewById(R.id.iv_product_image);
        rlCartIcon = findViewById(R.id.rl_cart_icon);
        tvProductName = findViewById(R.id.tv_product_name);
        tvProductDesc = findViewById(R.id.tv_product_desc);
        tvPrice = findViewById(R.id.tv_price);
        tvOriginalPrice = findViewById(R.id.tv_original_price);
        tvSales = findViewById(R.id.tv_sales);
        tvCartCount = findViewById(R.id.tv_cart_count);
        btnAddCart = findViewById(R.id.btn_add_cart);
        btnBuyNow = findViewById(R.id.btn_buy_now);
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());

        // ⭐ 右上角购物车 → 跳转购物车
        ivCart.setOnClickListener(v -> {
            ToastUtils.showShort(ProductDetailActivity.this, "跳转到购物车");
            goToCartPage();
        });

        // ⭐ 左下角购物车 → 跳转购物车（添加 Toast 测试是否触发）
        rlCartIcon.setOnClickListener(v -> {
            ToastUtils.showShort(ProductDetailActivity.this, "点击了左下角购物车");
            goToCartPage();
        });


        // ⭐ 加入购物车 → 弹出规格选择对话框
        btnAddCart.setOnClickListener(v -> showSpecDialog());

        btnBuyNow.setOnClickListener(v -> {
            ToastUtils.showShort(ProductDetailActivity.this, "跳转到结算页面");
        });
    }

    /**
     * ⭐ 显示规格选择对话框
     */
    private void showSpecDialog() {
        try {
            // ⭐ 传入 productImage
            ProductSpecDialog dialog = new ProductSpecDialog(
                    this,
                    productName,
                    productDesc,
                    String.valueOf((int) productPrice),
                    productImage  // ⭐ 传入商品图片
            );

            dialog.setOnConfirmListener((flavor, weight, quantity) -> {
                int userId = SharedPreferencesUtils.getUserId(this);
                if (userId == -1) {
                    ToastUtils.showShort(this, "请先登录");
                    return;
                }

                String fullName = productName + "（" + flavor + " / " + weight + "）";
                String fullDesc = productDesc + " | " + flavor + " | " + weight;

                for (int i = 0; i < quantity; i++) {
                    cartDao.addToCart(
                            userId,
                            fullName,
                            fullDesc,
                            productPrice,
                            0,
                            productImage  // ⭐ 购物车也使用商品图片
                    );
                }

                cartCount += quantity;
                updateCartBadge();
                ToastUtils.showShort(this, "已加入购物车 " + quantity + " 件");
            });

            dialog.show();
        } catch (Exception e) {
            ToastUtils.showShort(this, "打开规格选择失败");
        }
    }

    private void goToCartPage() {
        Intent intent = new Intent(ProductDetailActivity.this, MainActivity.class);
        intent.putExtra("target_tab", "cart");
        startActivity(intent);
        finish();
    }

    private void loadData() {
        productName = getIntent().getStringExtra("product_name");
        productDesc = getIntent().getStringExtra("product_desc");
        String priceStr = getIntent().getStringExtra("product_price");
        String originalPriceStr = getIntent().getStringExtra("product_original_price");
        String sales = getIntent().getStringExtra("product_sales");
        productImage = getIntent().getIntExtra("product_image", R.drawable.banner1);

        if (productName != null) {
            tvProductName.setText(productName);
        }
        if (productDesc != null) {
            tvProductDesc.setText(productDesc);
        }
        if (priceStr != null) {
            productPrice = Double.parseDouble(priceStr);
            tvPrice.setText("¥" + priceStr);
        }
        if (originalPriceStr != null && !originalPriceStr.isEmpty()) {
            tvOriginalPrice.setVisibility(View.VISIBLE);
            tvOriginalPrice.setText("¥" + originalPriceStr);
        }
        if (sales != null) {
            tvSales.setText("销量 " + sales);
        }

        ivProductImage.setImageResource(productImage);
    }

    private void updateCartBadge() {
        int userId = SharedPreferencesUtils.getUserId(this);
        if (userId != -1) {
            cartCount = cartDao.getCartCount(userId);
        }
        if (cartCount > 0) {
            tvCartCount.setVisibility(View.VISIBLE);
            tvCartCount.setText(String.valueOf(cartCount));
        } else {
            tvCartCount.setVisibility(View.GONE);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        updateCartBadge();
    }
}