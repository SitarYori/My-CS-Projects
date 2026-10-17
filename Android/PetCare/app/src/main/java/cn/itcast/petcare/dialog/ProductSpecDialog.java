package cn.itcast.petcare.dialog;
//购物车规格弹窗

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.annotation.NonNull;
import cn.itcast.petcare.R;
import cn.itcast.petcare.utils.ToastUtils;

public class ProductSpecDialog extends Dialog {

    private ImageView ivProductImage;
    private TextView tvProductName, tvProductPrice, tvStock, tvQuantity;
    private LinearLayout llFlavors, llWeights;

    // ⭐ 全部改为 TextView
    private TextView btnDecrease, btnIncrease, btnCancel, btnConfirm;

    private String productName, productDesc, price;
    private int productImageRes;
    private int quantity = 1;
    private int stock = 100;
    private String selectedFlavor = "";
    private String selectedWeight = "";
    private OnConfirmListener listener;

    private String[] flavors = {"原味", "鸡肉味", "鱼肉味", "牛肉味"};
    private String[] weights = {"1kg", "1.5kg", "2kg", "5kg"};
    private static final int MAX_QUANTITY = 10;  // 最大购买数量

    public interface OnConfirmListener {
        void onConfirm(String flavor, String weight, int quantity);
    }

    public ProductSpecDialog(@NonNull Context context, String productName,
                             String productDesc, String price, int productImageRes) {
        super(context);
        this.productName = productName;
        this.productDesc = productDesc;
        this.price = price;
        this.productImageRes = productImageRes;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.dialog_product_spec);

        Window window = getWindow();
        if (window != null) {
            WindowManager.LayoutParams params = window.getAttributes();
            params.width = WindowManager.LayoutParams.MATCH_PARENT;
            window.setAttributes(params);
        }

        initViews();
        setListeners();
        initData();
    }

    private void initViews() {
        ivProductImage = findViewById(R.id.iv_product_image);
        tvProductName = findViewById(R.id.tv_product_name);
        tvProductPrice = findViewById(R.id.tv_product_price);
        tvStock = findViewById(R.id.tv_stock);
        tvQuantity = findViewById(R.id.tv_quantity);
        llFlavors = findViewById(R.id.ll_flavors);
        llWeights = findViewById(R.id.ll_weights);
        btnDecrease = findViewById(R.id.btn_decrease);
        btnIncrease = findViewById(R.id.btn_increase);
        btnCancel = findViewById(R.id.btn_cancel);
        btnConfirm = findViewById(R.id.btn_confirm);
    }

    private void setListeners() {
        btnDecrease.setOnClickListener(v -> {
            if (quantity > 1) {
                quantity--;
                tvQuantity.setText(String.valueOf(quantity));
            }
        });

        btnIncrease.setOnClickListener(v -> {
            // ⭐ 增加上限判断
            if (quantity < MAX_QUANTITY) {
                quantity++;
                tvQuantity.setText(String.valueOf(quantity));
            } else {
                ToastUtils.showShort(getContext(), "该商品限购 " + MAX_QUANTITY + " 件");
            }
        });

        btnCancel.setOnClickListener(v -> dismiss());

        btnConfirm.setOnClickListener(v -> {
            if (selectedFlavor.isEmpty()) {
                ToastUtils.showShort(getContext(), "请选择口味");
                return;
            }
            if (selectedWeight.isEmpty()) {
                ToastUtils.showShort(getContext(), "请选择重量");
                return;
            }
            if (listener != null) {
                listener.onConfirm(selectedFlavor, selectedWeight, quantity);
            }
            dismiss();
        });
    }

    private void initData() {
        if (productImageRes != 0) {
            ivProductImage.setImageResource(productImageRes);
        }

        tvProductName.setText(productName);
        tvProductPrice.setText("¥" + price);
        tvStock.setText("库存 " + stock + "件");
        tvQuantity.setText(String.valueOf(quantity));

        llFlavors.removeAllViews();
        llWeights.removeAllViews();

        for (String flavor : flavors) {
            TextView tv = createSpecTextView(flavor);
            tv.setOnClickListener(v -> {
                clearSelection(llFlavors);
                tv.setBackgroundResource(R.drawable.bg_spec_selected);
                tv.setTextColor(getContext().getResources().getColor(android.R.color.white));
                selectedFlavor = flavor;
            });
            llFlavors.addView(tv);
        }

        for (String weight : weights) {
            TextView tv = createSpecTextView(weight);
            tv.setOnClickListener(v -> {
                clearSelection(llWeights);
                tv.setBackgroundResource(R.drawable.bg_spec_selected);
                tv.setTextColor(getContext().getResources().getColor(android.R.color.white));
                selectedWeight = weight;
            });
            llWeights.addView(tv);
        }
    }

    private TextView createSpecTextView(String text) {
        TextView tv = new TextView(getContext());
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
        );
        params.setMargins(0, 0, 12, 0);
        tv.setLayoutParams(params);
        tv.setText(text);
        tv.setTextSize(14);
        tv.setTextColor(getContext().getResources().getColor(android.R.color.black));
        tv.setPadding(20, 10, 20, 10);
        tv.setBackgroundResource(R.drawable.bg_spec_normal);
        tv.setClickable(true);
        tv.setFocusable(true);
        return tv;
    }

    private void clearSelection(LinearLayout layout) {
        for (int i = 0; i < layout.getChildCount(); i++) {
            View child = layout.getChildAt(i);
            if (child instanceof TextView) {
                TextView tv = (TextView) child;
                tv.setBackgroundResource(R.drawable.bg_spec_normal);
                tv.setTextColor(getContext().getResources().getColor(android.R.color.black));
            }
        }
    }

    public void setOnConfirmListener(OnConfirmListener listener) {
        this.listener = listener;
    }
}