package cn.itcast.petcare.activity;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import cn.itcast.petcare.R;
import cn.itcast.petcare.dao.AddressDao;
import cn.itcast.petcare.dao.ServiceOrderDao;
import cn.itcast.petcare.model.Address;
import cn.itcast.petcare.model.ServiceOrder;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;

import java.util.Calendar;
import java.util.List;

public class ServiceBookingActivity extends AppCompatActivity {

    private ImageView ivBack;
    private TextView tvTitle;
    private EditText etPetName, etPetType, etDate, etAddress, etRemark;
    private LinearLayout llServices;
    private TextView tvTimeAm, tvTimePm;
    private Button btnSubmit;

    private String serviceType;
    private String serviceTitle;
    private String selectedService = "";
    private String selectedTime = "";
    private ServiceOrderDao serviceOrderDao;
    private AddressDao addressDao;
    private List<Address> addressList;
    private Address selectedAddress;

    private String[] boardingServices = {"标准寄养", "豪华寄养", "日间托管"};
    private String[] groomingServices = {"基础洗护", "精致美容", "SPA护理"};

    private static final int REQUEST_ADDRESS = 1001;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_service_booking);

        serviceType = getIntent().getStringExtra("service_type");
        serviceTitle = getIntent().getStringExtra("service_title");

        serviceOrderDao = new ServiceOrderDao(this);
        addressDao = new AddressDao(this);

        initViews();
        setListeners();
        setupUI();
        loadDefaultAddress();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        tvTitle = findViewById(R.id.tv_title);
        etPetName = findViewById(R.id.et_pet_name);
        etPetType = findViewById(R.id.et_pet_type);
        etDate = findViewById(R.id.et_date);
        etAddress = findViewById(R.id.et_address);
        etRemark = findViewById(R.id.et_remark);
        llServices = findViewById(R.id.ll_services);
        tvTimeAm = findViewById(R.id.tv_time_am);
        tvTimePm = findViewById(R.id.tv_time_pm);
        btnSubmit = findViewById(R.id.btn_submit);
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());

        // 日期选择
        etDate.setOnClickListener(v -> {
            Calendar calendar = Calendar.getInstance();
            DatePickerDialog dialog = new DatePickerDialog(this,
                    (view, year, month, dayOfMonth) -> {
                        String date = year + "-" + (month + 1) + "-" + dayOfMonth;
                        etDate.setText(date);
                    },
                    calendar.get(Calendar.YEAR),
                    calendar.get(Calendar.MONTH),
                    calendar.get(Calendar.DAY_OF_MONTH));
            dialog.getDatePicker().setMinDate(System.currentTimeMillis());
            dialog.show();
        });

        // ⭐ 点击地址 → 跳转到地址列表选择
        etAddress.setOnClickListener(v -> {
            Intent intent = new Intent(ServiceBookingActivity.this, AddressListActivity.class);
            intent.putExtra("select_mode", true);
            startActivityForResult(intent, REQUEST_ADDRESS);
        });

        // 时间选择
        tvTimeAm.setOnClickListener(v -> selectTime("上午 09:00-12:00"));
        tvTimePm.setOnClickListener(v -> selectTime("下午 14:00-18:00"));

        // 提交预约
        btnSubmit.setOnClickListener(v -> submitBooking());
    }

    private void setupUI() {
        tvTitle.setText(serviceTitle);

        String[] services = serviceType.equals("boarding") ? boardingServices : groomingServices;

        for (String service : services) {
            TextView tv = createServiceTextView(service);
            tv.setOnClickListener(v -> {
                clearServiceSelection();
                tv.setBackgroundResource(R.drawable.bg_spec_selected);
                tv.setTextColor(getResources().getColor(android.R.color.white));
                selectedService = service;
            });
            llServices.addView(tv);
        }
    }

    private TextView createServiceTextView(String text) {
        TextView tv = new TextView(this);
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
        );
        params.setMargins(0, 0, 12, 0);
        tv.setLayoutParams(params);
        tv.setText(text);
        tv.setTextSize(14);
        tv.setTextColor(getResources().getColor(android.R.color.black));
        tv.setPadding(20, 10, 20, 10);
        tv.setBackgroundResource(R.drawable.bg_spec_normal);
        tv.setClickable(true);
        tv.setFocusable(true);
        return tv;
    }

    private void clearServiceSelection() {
        for (int i = 0; i < llServices.getChildCount(); i++) {
            View child = llServices.getChildAt(i);
            if (child instanceof TextView) {
                TextView tv = (TextView) child;
                tv.setBackgroundResource(R.drawable.bg_spec_normal);
                tv.setTextColor(getResources().getColor(android.R.color.black));
            }
        }
    }

    private void selectTime(String time) {
        selectedTime = time;
        if (time.equals("上午 09:00-12:00")) {
            tvTimeAm.setBackgroundResource(R.drawable.bg_spec_selected);
            tvTimeAm.setTextColor(getResources().getColor(android.R.color.white));
            tvTimePm.setBackgroundResource(R.drawable.bg_spec_normal);
            tvTimePm.setTextColor(getResources().getColor(android.R.color.black));
        } else {
            tvTimePm.setBackgroundResource(R.drawable.bg_spec_selected);
            tvTimePm.setTextColor(getResources().getColor(android.R.color.white));
            tvTimeAm.setBackgroundResource(R.drawable.bg_spec_normal);
            tvTimeAm.setTextColor(getResources().getColor(android.R.color.black));
        }
    }

    /**
     * ⭐ 加载默认收货地址
     */
    private void loadDefaultAddress() {
        int userId = SharedPreferencesUtils.getUserId(this);
        if (userId == -1) return;

        addressList = addressDao.getAddressesByUserId(userId);
        if (addressList != null && !addressList.isEmpty()) {
            // 优先使用默认地址
            for (Address addr : addressList) {
                if (addr.isDefault()) {
                    selectedAddress = addr;
                    break;
                }
            }
            // 如果没有默认地址，使用第一个
            if (selectedAddress == null) {
                selectedAddress = addressList.get(0);
            }
            etAddress.setText(selectedAddress.getFullAddress());
            etAddress.setTextColor(getResources().getColor(android.R.color.black));
        } else {
            etAddress.setText("请选择收货地址");
            etAddress.setTextColor(getResources().getColor(android.R.color.darker_gray));
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_ADDRESS && resultCode == RESULT_OK && data != null) {
            selectedAddress = (Address) data.getSerializableExtra("selected_address");
            if (selectedAddress != null) {
                etAddress.setText(selectedAddress.getFullAddress());
                etAddress.setTextColor(getResources().getColor(android.R.color.black));
            }
        }
    }

    private void submitBooking() {
        String petName = etPetName.getText().toString().trim();
        String petType = etPetType.getText().toString().trim();
        String date = etDate.getText().toString().trim();
        String address = etAddress.getText().toString().trim();
        String remark = etRemark.getText().toString().trim();

        // 校验
        if (petName.isEmpty()) {
            ToastUtils.showShort(this, "请输入宠物名称");
            return;
        }
        if (petType.isEmpty()) {
            ToastUtils.showShort(this, "请输入宠物类型");
            return;
        }
        if (selectedService.isEmpty()) {
            ToastUtils.showShort(this, "请选择服务项目");
            return;
        }
        if (date.isEmpty()) {
            ToastUtils.showShort(this, "请选择预约日期");
            return;
        }
        if (selectedTime.isEmpty()) {
            ToastUtils.showShort(this, "请选择预约时间");
            return;
        }
        if (address.isEmpty() || address.equals("请选择收货地址")) {
            ToastUtils.showShort(this, "请选择上门地址");
            return;
        }

        int userId = SharedPreferencesUtils.getUserId(this);
        if (userId == -1) {
            ToastUtils.showShort(this, "请先登录");
            return;
        }

        // 创建服务预约
        ServiceOrder order = new ServiceOrder();
        order.setUserId(userId);
        order.setServiceType(serviceType);
        order.setPetName(petName);
        order.setPetType(petType);
        order.setServiceName(selectedService);
        order.setServiceDate(date);
        order.setServiceTime(selectedTime);
        order.setAddress(address);
        order.setRemark(remark);
        order.setStatus(1); // 待确认

        long result = serviceOrderDao.createServiceOrder(order);
        if (result > 0) {
            ToastUtils.showShort(this, "预约成功！请等待商家确认");
            finish();
        } else {
            ToastUtils.showShort(this, "预约失败，请重试");
        }
    }
}