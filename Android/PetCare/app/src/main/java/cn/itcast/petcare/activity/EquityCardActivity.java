package cn.itcast.petcare.activity;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import cn.itcast.petcare.R;
import cn.itcast.petcare.utils.SharedPreferencesUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class EquityCardActivity extends AppCompatActivity {

    private ImageView ivBack;
    private TextView tvCardNo, tvHolder, tvLevel, tvExpiry;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_equity_card);

        initViews();
        setListeners();
        loadData();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        tvCardNo = findViewById(R.id.tv_card_no);
        tvHolder = findViewById(R.id.tv_holder);
        tvLevel = findViewById(R.id.tv_level);
        tvExpiry = findViewById(R.id.tv_expiry);
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());
    }

    private void loadData() {
        String username = SharedPreferencesUtils.getUsername(this);
        int points = SharedPreferencesUtils.getMemberPoints(this);

        // 卡号
        tvCardNo.setText("PC" + System.currentTimeMillis());

        // 持卡人
        tvHolder.setText(username != null && !username.isEmpty() ? username : "宠物主人");

        // 会员等级
        String level;
        if (points < 100) {
            level = "初级会员";
        } else if (points < 500) {
            level = "中级会员";
        } else {
            level = "高级会员";
        }
        tvLevel.setText(level);

        // 有效期（一年后）
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.CHINA);
        String expiry = sdf.format(new Date(System.currentTimeMillis() + 365L * 24 * 60 * 60 * 1000));
        tvExpiry.setText(expiry);
    }
}