package cn.itcast.petcare.activity;

import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import cn.itcast.petcare.R;
import cn.itcast.petcare.dao.OrderDao;
import cn.itcast.petcare.model.Order;
import cn.itcast.petcare.utils.ToastUtils;

public class OrderCommentActivity extends AppCompatActivity {

    private ImageView ivBack;
    private TextView tvProductName;
    private LinearLayout llStars;
    private TextView tvRatingText;
    private EditText etComment;
    private TextView tvCharCount;
    private Button btnSubmit;

    private Order order;
    private OrderDao orderDao;
    private float selectedRating = 0;

    private final String[] ratingTexts = {"", "很差", "较差", "一般", "满意", "非常满意"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_order_comment);

        order = (Order) getIntent().getSerializableExtra("order");
        orderDao = new OrderDao(this);

        initViews();
        setListeners();
        setupStars();
        loadData();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        tvProductName = findViewById(R.id.tv_product_name);
        llStars = findViewById(R.id.ll_stars);
        tvRatingText = findViewById(R.id.tv_rating_text);
        etComment = findViewById(R.id.et_comment);
        tvCharCount = findViewById(R.id.tv_char_count);
        btnSubmit = findViewById(R.id.btn_submit);
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());

        // 字数统计
        etComment.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {}

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {}

            @Override
            public void afterTextChanged(Editable s) {
                int len = s.length();
                tvCharCount.setText(len + "/200");
                if (len > 200) {
                    // 截断到200字
                    etComment.setText(s.subSequence(0, 200));
                    etComment.setSelection(200);
                }
            }
        });

        btnSubmit.setOnClickListener(v -> submitComment());
    }

    private void loadData() {
        if (order != null) {
            tvProductName.setText(order.getProductName());
        }
    }

    /**
     * ⭐ 创建星星评分
     */
    private void setupStars() {
        llStars.removeAllViews();
        for (int i = 1; i <= 5; i++) {
            final int starIndex = i;
            TextView star = new TextView(this);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                    48, 48
            );
            params.setMargins(4, 0, 4, 0);
            star.setLayoutParams(params);
            star.setText("☆");
            star.setTextSize(36);
            star.setTextColor(getResources().getColor(android.R.color.darker_gray));
            star.setGravity(android.view.Gravity.CENTER);
            star.setClickable(true);
            star.setFocusable(true);

            star.setOnClickListener(v -> {
                selectedRating = starIndex;
                updateStars(starIndex);
                tvRatingText.setText(ratingTexts[starIndex]);
                tvRatingText.setTextColor(getResources().getColor(android.R.color.holo_blue_dark));
            });

            llStars.addView(star);
        }
    }

    /**
     * ⭐ 更新星星显示
     */
    private void updateStars(int rating) {
        for (int i = 0; i < llStars.getChildCount(); i++) {
            TextView star = (TextView) llStars.getChildAt(i);
            if (i < rating) {
                star.setText("★");
                star.setTextColor(getResources().getColor(android.R.color.holo_orange_light));
            } else {
                star.setText("☆");
                star.setTextColor(getResources().getColor(android.R.color.darker_gray));
            }
        }
    }

    /**
     * ⭐ 提交评价
     */
    private void submitComment() {
        if (selectedRating == 0) {
            ToastUtils.showShort(this, "请给商品评分");
            return;
        }

        String comment = etComment.getText().toString().trim();

        if (order != null) {
            // 更新订单的评价信息
            orderDao.updateOrderComment(order.getId(), selectedRating, comment);

            ToastUtils.showShort(this, "评价成功！感谢您的反馈");
            finish();
        }
    }
}