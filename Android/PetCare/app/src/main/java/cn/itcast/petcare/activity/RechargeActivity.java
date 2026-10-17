package cn.itcast.petcare.activity;

import android.os.Bundle;
import android.os.Handler;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import cn.itcast.petcare.R;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;

import java.util.Locale;

public class RechargeActivity extends AppCompatActivity {

    private ImageView ivBack;
    private TextView tvBalance;
    private TextView tvAmount10, tvAmount30, tvAmount50, tvAmount100, tvAmount200, tvAmount500;
    private EditText etCustomAmount;
    private Button btnRecharge;

    private double selectedAmount = 0;
    private double currentBalance = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recharge);

        initViews();
        setListeners();
        loadBalance();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        tvBalance = findViewById(R.id.tv_balance);
        tvAmount10 = findViewById(R.id.tv_amount_10);
        tvAmount30 = findViewById(R.id.tv_amount_30);
        tvAmount50 = findViewById(R.id.tv_amount_50);
        tvAmount100 = findViewById(R.id.tv_amount_100);
        tvAmount200 = findViewById(R.id.tv_amount_200);
        tvAmount500 = findViewById(R.id.tv_amount_500);
        etCustomAmount = findViewById(R.id.et_custom_amount);
        btnRecharge = findViewById(R.id.btn_recharge);
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());

        tvAmount10.setOnClickListener(v -> selectAmount(10, tvAmount10));
        tvAmount30.setOnClickListener(v -> selectAmount(30, tvAmount30));
        tvAmount50.setOnClickListener(v -> selectAmount(50, tvAmount50));
        tvAmount100.setOnClickListener(v -> selectAmount(100, tvAmount100));
        tvAmount200.setOnClickListener(v -> selectAmount(200, tvAmount200));
        tvAmount500.setOnClickListener(v -> selectAmount(500, tvAmount500));

        etCustomAmount.setOnFocusChangeListener((v, hasFocus) -> {
            if (hasFocus) {
                clearAllSelection();
                selectedAmount = 0;
            }
        });

        btnRecharge.setOnClickListener(v -> recharge());
    }

    private void loadBalance() {
        currentBalance = SharedPreferencesUtils.getBalance(this);
        tvBalance.setText(String.format(Locale.CHINA, "¥%.2f", currentBalance));
    }

    private void selectAmount(double amount, TextView selectedView) {
        clearAllSelection();
        selectedAmount = amount;
        selectedView.setBackgroundResource(R.drawable.bg_recharge_selected);
        selectedView.setTextColor(ContextCompat.getColor(this, android.R.color.holo_blue_dark));
        etCustomAmount.setText("");
    }

    private void clearAllSelection() {
        TextView[] views = {tvAmount10, tvAmount30, tvAmount50, tvAmount100, tvAmount200, tvAmount500};
        for (TextView tv : views) {
            tv.setBackgroundResource(R.drawable.bg_recharge_item);
            tv.setTextColor(ContextCompat.getColor(this, android.R.color.black));
        }
    }

    private void recharge() {
        final double amount = getRechargeAmount();

        if (amount <= 0) {
            ToastUtils.showShort(this, "请选择或输入充值金额");
            return;
        }

        if (amount > 999999) {
            ToastUtils.showShort(this, "充值金额过大");
            return;
        }

        btnRecharge.setEnabled(false);
        btnRecharge.setText("充值中...");

        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                // ⭐ 充值成功，更新余额
                currentBalance += amount;
                SharedPreferencesUtils.saveBalance(RechargeActivity.this, currentBalance);

                // ⭐ 验证是否保存成功
                double savedBalance = SharedPreferencesUtils.getBalance(RechargeActivity.this);
                ToastUtils.showShort(RechargeActivity.this,
                        String.format(Locale.CHINA, "充值成功！+%.2f元 (当前余额: ¥%.2f)", amount, savedBalance));

                // 更新页面显示
                tvBalance.setText(String.format(Locale.CHINA, "¥%.2f", savedBalance));

                btnRecharge.setEnabled(true);
                btnRecharge.setText("确认充值");

                clearAllSelection();
                selectedAmount = 0;
                etCustomAmount.setText("");
            }
        }, 1500);
    }

    private double getRechargeAmount() {
        if (selectedAmount > 0) {
            return selectedAmount;
        }

        String customStr = etCustomAmount.getText().toString().trim();
        if (TextUtils.isEmpty(customStr)) {
            return 0;
        }

        try {
            return Double.parseDouble(customStr);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}