package cn.itcast.petcare.activity;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import cn.itcast.petcare.R;
import cn.itcast.petcare.dao.AddressDao;
import cn.itcast.petcare.model.Address;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;
//地址编辑页：新增/编辑地址表单
public class AddressEditActivity extends AppCompatActivity {

    // ==================== 控件声明 ====================
    private ImageView ivBack;
    private TextView tvTitle;
    private EditText etReceiver, etPhone, etProvince, etCity, etDistrict, etDetail;
    private CheckBox cbDefault;
    private Button btnSave;

    private AddressDao addressDao;
    private Address editAddress;
    private int userId;

    // ==================== 生命周期方法 ====================
    /**
     * Activity 创建时调用
     * 初始化视图、数据，判断是新增还是编辑模式
     */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_address_edit);

        addressDao = new AddressDao(this);
        userId = SharedPreferencesUtils.getUserId(this);// 获取当前登录用户ID（用于关联地址）

        initViews();
        setListeners();

        // 判断是编辑还是新增模式
        // 从Intent中获取传递过来的地址对象
        editAddress = (Address) getIntent().getSerializableExtra("address");
        if (editAddress != null) {
            tvTitle.setText("编辑地址");
            fillData();
        } else {
            tvTitle.setText("新增地址");
        }
    }


    // ==================== 初始化方法 ====================
    /**
     * 初始化所有控件
     * 通过 findViewById 绑定布局中的控件
     */
    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        tvTitle = findViewById(R.id.tv_title);
        etReceiver = findViewById(R.id.et_receiver);
        etPhone = findViewById(R.id.et_phone);
        etProvince = findViewById(R.id.et_province);
        etCity = findViewById(R.id.et_city);
        etDistrict = findViewById(R.id.et_district);
        etDetail = findViewById(R.id.et_detail);
        cbDefault = findViewById(R.id.cb_default);
        btnSave = findViewById(R.id.btn_save);
    }

    /**
     * 设置所有控件的点击事件    事件监听
     */
    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());

        btnSave.setOnClickListener(v -> saveAddress());
    }


    /**
     * 编辑模式时，将已有地址数据填充到表单中       数据填充
     */
    private void fillData() {
        etReceiver.setText(editAddress.getReceiverName());
        etPhone.setText(editAddress.getPhone());
        etProvince.setText(editAddress.getProvince());
        etCity.setText(editAddress.getCity());
        etDistrict.setText(editAddress.getDistrict());
        etDetail.setText(editAddress.getDetail());
        cbDefault.setChecked(editAddress.isDefault());
    }


    //保存地址（新增或更新）
    private void saveAddress() {
        String receiver = etReceiver.getText().toString().trim();
        String phone = etPhone.getText().toString().trim();
        String province = etProvince.getText().toString().trim();
        String city = etCity.getText().toString().trim();
        String district = etDistrict.getText().toString().trim();
        String detail = etDetail.getText().toString().trim();
        boolean isDefault = cbDefault.isChecked();

        if (TextUtils.isEmpty(receiver)) {
            ToastUtils.showShort(this, "请输入收货人姓名");
            etReceiver.requestFocus();
            return;
        }

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

        if (TextUtils.isEmpty(province)) {
            ToastUtils.showShort(this, "请输入省份");
            etProvince.requestFocus();
            return;
        }

        if (TextUtils.isEmpty(city)) {
            ToastUtils.showShort(this, "请输入城市");
            etCity.requestFocus();
            return;
        }

        if (TextUtils.isEmpty(district)) {
            ToastUtils.showShort(this, "请输入区/县");
            etDistrict.requestFocus();
            return;
        }

        if (TextUtils.isEmpty(detail)) {
            ToastUtils.showShort(this, "请输入详细地址");
            etDetail.requestFocus();
            return;
        }

        Address address = new Address(receiver, phone, province, city, district, detail, isDefault);
        address.setUserId(userId);

        // ----------  保存到数据库 ----------
        if (editAddress != null) {
            address.setId(editAddress.getId());
            addressDao.updateAddress(address);
            ToastUtils.showShort(this, "修改成功");
        } else {
            // 如果设为默认，取消其他默认
            if (isDefault) {
                addressDao.setDefaultAddress(userId, 0);
            }
            addressDao.addAddress(address);
            ToastUtils.showShort(this, "添加成功");
        }

        setResult(RESULT_OK);
        finish();
    }
}