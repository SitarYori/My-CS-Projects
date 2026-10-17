package cn.itcast.petcare.activity;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import cn.itcast.petcare.R;
import cn.itcast.petcare.dao.UserDao;
import cn.itcast.petcare.model.User;
import cn.itcast.petcare.utils.LoginHistoryUtils;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;

import java.util.List;

public class LoginActivity extends AppCompatActivity {

    private EditText etPhone, etPassword;
    private Button btnLogin;
    private TextView tvRegister, tvForgetPassword;
    private LinearLayout llHistory, llHistoryList;
    private UserDao userDao;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        // 清除之前的登录状态，确保每次都要重新登录
        SharedPreferencesUtils.clearLoginInfo(this);

        initViews();
        initData();
        setListeners();
        loadLoginHistory();
    }

    private void initViews() {
        etPhone = findViewById(R.id.et_phone);
        etPassword = findViewById(R.id.et_password);
        btnLogin = findViewById(R.id.btn_login);
        tvRegister = findViewById(R.id.tv_register);
        tvForgetPassword = findViewById(R.id.tv_forget_password);
        llHistory = findViewById(R.id.ll_history);
        llHistoryList = findViewById(R.id.ll_history_list);
    }

    private void initData() {
        try {
            userDao = new UserDao(this);
        } catch (Exception e) {
            e.printStackTrace();
            ToastUtils.showShort(this, "数据库初始化失败");
        }
    }

    private void setListeners() {
        btnLogin.setOnClickListener(v -> login());

        tvRegister.setOnClickListener(v -> {
            startActivity(new Intent(LoginActivity.this, RegisterActivity.class));
        });

        tvForgetPassword.setOnClickListener(v -> {
            ToastUtils.showShort(this, "请联系管理员重置密码");
        });
    }

    /**
     * ⭐ 加载历史登录记录
     */
    private void loadLoginHistory() {
        List<String> historyList = LoginHistoryUtils.getLoginHistory(this);
        if (historyList.isEmpty()) {
            llHistory.setVisibility(View.GONE);
            return;
        }

        llHistory.setVisibility(View.VISIBLE);
        llHistoryList.removeAllViews();

        for (String phone : historyList) {
            TextView tv = createHistoryItem(phone);
            llHistoryList.addView(tv);
        }
    }

    /**
     * ⭐ 创建历史账号标签
     */
    /**
     * 创建历史账号标签
     */
    private TextView createHistoryItem(String phone) {
        TextView tv = new TextView(this);

        // 使用 LinearLayout.LayoutParams，宽度为 wrap_content
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
        );
        params.setMargins(0, 0, 12, 8);
        tv.setLayoutParams(params);
        tv.setText(phone);
        tv.setTextSize(13);
        tv.setTextColor(android.graphics.Color.parseColor("#4A90D9"));
        tv.setBackgroundResource(R.drawable.bg_history_item);
        tv.setPadding(16, 8, 16, 8);
        tv.setClickable(true);
        tv.setFocusable(true);

        tv.setOnClickListener(v -> {
            etPhone.setText(phone);
            etPassword.requestFocus();
            ToastUtils.showShort(this, "已填入 " + phone);
        });

        return tv;
    }

    private void login() {
        String phone = etPhone.getText().toString().trim();
        String password = etPassword.getText().toString().trim();

        if (TextUtils.isEmpty(phone)) {
            ToastUtils.showShort(this, "请输入手机号");
            etPhone.requestFocus();
            return;
        }

        if (phone.length() != 11) {
            ToastUtils.showShort(this, "请输入正确的手机号");
            etPhone.requestFocus();
            return;
        }

        if (TextUtils.isEmpty(password)) {
            ToastUtils.showShort(this, "请输入密码");
            etPassword.requestFocus();
            return;
        }

        if (password.length() < 6) {
            ToastUtils.showShort(this, "密码长度不能少于6位");
            etPassword.requestFocus();
            return;
        }

        try {
            User user = userDao.login(phone, password);
            if (user != null) {
                // ⭐ 保存登录历史
                LoginHistoryUtils.saveLoginHistory(this, phone);

                SharedPreferencesUtils.saveLoginInfo(
                        this,
                        user.getId(),
                        user.getPhone(),
                        user.getUsername()
                );
                ToastUtils.showShort(this, "登录成功！");
                startActivity(new Intent(LoginActivity.this, MainActivity.class));
                finish();
            } else {
                ToastUtils.showShort(this, "手机号或密码错误，请重试");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ToastUtils.showShort(this, "登录失败：" + e.getMessage());
        }
    }
}