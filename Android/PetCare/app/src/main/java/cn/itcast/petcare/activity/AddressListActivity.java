package cn.itcast.petcare.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.adapter.AddressAdapter;
import cn.itcast.petcare.dao.AddressDao;
import cn.itcast.petcare.model.Address;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;
import java.util.List;
//地址列表页：管理收货地址，增删改查，设为默认
public class AddressListActivity extends AppCompatActivity {

    private ImageView ivBack;
    private TextView tvAdd;
    private RecyclerView rvAddress;
    private LinearLayout llEmpty;
    private AddressDao addressDao;
    private List<Address> addressList;
    private AddressAdapter adapter;
    private boolean isSelectMode = false;

    private static final int REQUEST_EDIT = 1001;


    //生命周期方法
    // 获取启动模式：是否为选择模式（从Intent中读取）
    // 选择模式：确认订单页面调用，点击地址后返回
    // 普通模式：从"我的"页面进入，管理地址
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_address_list);

        isSelectMode = getIntent().getBooleanExtra("select_mode", false);

        addressDao = new AddressDao(this);

        initViews();
        setListeners();
        loadData();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        tvAdd = findViewById(R.id.tv_add);
        rvAddress = findViewById(R.id.rv_address);
        llEmpty = findViewById(R.id.ll_empty);

        rvAddress.setLayoutManager(new LinearLayoutManager(this));
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());

        tvAdd.setOnClickListener(v -> {
            Intent intent = new Intent(AddressListActivity.this, AddressEditActivity.class);
            startActivityForResult(intent, REQUEST_EDIT);
        });
    }

    private void loadData() {
        int userId = SharedPreferencesUtils.getUserId(this);
        if (userId == -1) {
            ToastUtils.showShort(this, "请先登录");
            finish();
            return;
        }

        addressList = addressDao.getAddressesByUserId(userId);

        // ⭐ 判断是否为空
        if (addressList == null || addressList.isEmpty()) {
            llEmpty.setVisibility(View.VISIBLE);
            rvAddress.setVisibility(View.GONE);
            return;
        } else {
            llEmpty.setVisibility(View.GONE);
            rvAddress.setVisibility(View.VISIBLE);
        }

        if (adapter == null) {
            adapter = new AddressAdapter(addressList, isSelectMode, new AddressAdapter.OnAddressClickListener() {
                @Override
                public void onEdit(Address address) {
                    Intent intent = new Intent(AddressListActivity.this, AddressEditActivity.class);
                    intent.putExtra("address", address);
                    startActivityForResult(intent, REQUEST_EDIT);
                }

                @Override
                public void onDelete(Address address) {
                    addressDao.deleteAddress(address.getId());
                    loadData();
                    ToastUtils.showShort(AddressListActivity.this, "已删除");
                }

                @Override
                public void onSelect(Address address) {
                    Intent resultIntent = new Intent();
                    resultIntent.putExtra("selected_address", address);
                    setResult(RESULT_OK, resultIntent);
                    finish();
                }

                @Override
                public void onSetDefault(Address address) {
                    int userId1 = SharedPreferencesUtils.getUserId(AddressListActivity.this);
                    addressDao.setDefaultAddress(userId1, address.getId());
                    loadData();
                    ToastUtils.showShort(AddressListActivity.this, "已设为默认");
                }
            });
            rvAddress.setAdapter(adapter);
        } else {
            adapter.updateData(addressList);
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_EDIT && resultCode == RESULT_OK) {
            loadData();
        }
    }
}