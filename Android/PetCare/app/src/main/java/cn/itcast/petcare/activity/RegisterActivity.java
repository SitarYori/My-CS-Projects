package cn.itcast.petcare.activity;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import cn.itcast.petcare.R;
import cn.itcast.petcare.dao.CouponDao;
import cn.itcast.petcare.dao.UserDao;
import cn.itcast.petcare.model.Coupon;
import cn.itcast.petcare.model.User;
import cn.itcast.petcare.utils.ToastUtils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

public class RegisterActivity extends AppCompatActivity {

    private ImageView ivBack;
    private EditText etUsername, etPhone, etPassword, etConfirmPassword;
    private Button btnRegister;
    private TextView tvLogin;
    private UserDao userDao;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        initViews();
        initData();
        setListeners();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        etUsername = findViewById(R.id.et_username);
        etPhone = findViewById(R.id.et_phone);
        etPassword = findViewById(R.id.et_password);
        etConfirmPassword = findViewById(R.id.et_confirm_password);
        btnRegister = findViewById(R.id.btn_register);
        tvLogin = findViewById(R.id.tv_login);
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
        ivBack.setOnClickListener(v -> finish());

        btnRegister.setOnClickListener(v -> register());

        tvLogin.setOnClickListener(v -> finish());
    }

    private void register() {
        String username = etUsername.getText().toString().trim();
        String phone = etPhone.getText().toString().trim();
        String password = etPassword.getText().toString().trim();
        String confirmPassword = etConfirmPassword.getText().toString().trim();

        // 校验用户名
        if (TextUtils.isEmpty(username)) {
            ToastUtils.showShort(this, "请输入昵称");
            etUsername.requestFocus();
            return;
        }
        if (username.length() < 2) {
            ToastUtils.showShort(this, "昵称至少2个字符");
            etUsername.requestFocus();
            return;
        }

        // 校验手机号
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

        // 检查手机号是否已注册
        if (userDao.isPhoneExist(phone)) {
            ToastUtils.showShort(this, "该手机号已注册，请直接登录");
            etPhone.requestFocus();
            return;
        }

        // 校验密码
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

        // 校验确认密码
        if (TextUtils.isEmpty(confirmPassword)) {
            ToastUtils.showShort(this, "请再次输入密码");
            etConfirmPassword.requestFocus();
            return;
        }
        if (!password.equals(confirmPassword)) {
            ToastUtils.showShort(this, "两次输入的密码不一致");
            etConfirmPassword.requestFocus();
            return;
        }

        // 注册用户
        User user = new User(phone, password, username);
        long result = userDao.register(user);

        if (result > 0) {
            // ⭐ 注册成功，发放新人优惠券
            int userId = (int) result;
            CouponDao couponDao = new CouponDao(this);

            // 新人满50减5元券
            couponDao.addCoupon(
                    userId,
                    "新人专享·满50减5",
                    Coupon.TYPE_FULL_REDUCE,
                    5.0,
                    50.0,
                    0,
                    "新用户注册礼包",
                    getCouponExpireTime(30)
            );

            // 新人9折券
            couponDao.addCoupon(
                    userId,
                    "新人专享·9折券",
                    Coupon.TYPE_DISCOUNT,
                    0.9,
                    0,
                    20.0,
                    "新用户注册礼包",
                    getCouponExpireTime(30)
            );

            ToastUtils.showShort(this, "注册成功！已获得2张新人优惠券");
            Intent intent = new Intent(RegisterActivity.this, LoginActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent);
            finish();
        } else {
            ToastUtils.showShort(this, "注册失败，请稍后重试");
        }
    }

    /**
     * 获取优惠券过期时间
     * @param days 有效天数
     * @return 过期时间字符串
     */
    private String getCouponExpireTime(int days) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.CHINA);
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, days);
        return sdf.format(calendar.getTime());
    }
}