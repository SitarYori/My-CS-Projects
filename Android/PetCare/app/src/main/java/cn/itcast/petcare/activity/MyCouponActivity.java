package cn.itcast.petcare.activity;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.adapter.CouponAdapter;
import cn.itcast.petcare.dao.CouponDao;
import cn.itcast.petcare.model.Coupon;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;

import java.util.List;

public class MyCouponActivity extends AppCompatActivity {

    private ImageView ivBack;
    private RecyclerView rvCoupons;
    private LinearLayout llEmpty;

    private TextView tabUnused, tabUsed, tabExpired;
    private TextView tvUnusedCount, tvUsedCount, tvExpiredCount;

    private CouponDao couponDao;
    private CouponAdapter adapter;
    private List<Coupon> couponList;
    private int currentStatus = 1;  // 默认显示未使用 (STATUS_UNUSED = 1)

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_coupon);

        couponDao = new CouponDao(this);

        initViews();
        setListeners();
        loadData(1);
        updateStatistics();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        rvCoupons = findViewById(R.id.rv_coupons);
        llEmpty = findViewById(R.id.ll_empty);

        tabUnused = findViewById(R.id.tab_unused);
        tabUsed = findViewById(R.id.tab_used);
        tabExpired = findViewById(R.id.tab_expired);

        tvUnusedCount = findViewById(R.id.tv_unused_count);
        tvUsedCount = findViewById(R.id.tv_used_count);
        tvExpiredCount = findViewById(R.id.tv_expired_count);

        rvCoupons.setLayoutManager(new LinearLayoutManager(this));
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());

        tabUnused.setOnClickListener(v -> {
            selectTab(1);
            loadData(1);
        });

        tabUsed.setOnClickListener(v -> {
            selectTab(2);
            loadData(2);
        });

        tabExpired.setOnClickListener(v -> {
            selectTab(3);
            loadData(3);
        });
    }

    private void selectTab(int status) {
        resetTabs();
        TextView selectedTab;
        if (status == 1) {
            selectedTab = tabUnused;
        } else if (status == 2) {
            selectedTab = tabUsed;
        } else {
            selectedTab = tabExpired;
        }
        selectedTab.setTextColor(getResources().getColor(android.R.color.holo_blue_dark));
        selectedTab.setBackgroundResource(R.drawable.bg_tab_selected);
        currentStatus = status;
    }

    private void resetTabs() {
        TextView[] tabs = {tabUnused, tabUsed, tabExpired};
        for (TextView tab : tabs) {
            tab.setTextColor(getResources().getColor(android.R.color.darker_gray));
            tab.setBackgroundResource(R.drawable.bg_tab_normal);
        }
    }

    private void loadData(int status) {
        int userId = SharedPreferencesUtils.getUserId(this);
        if (userId == -1) {
            showEmpty();
            return;
        }

        couponList = couponDao.getCouponsByStatus(userId, status);

        if (couponList == null || couponList.isEmpty()) {
            showEmpty();
        } else {
            showList();
        }
    }

    private void showList() {
        llEmpty.setVisibility(View.GONE);
        rvCoupons.setVisibility(View.VISIBLE);

        adapter = new CouponAdapter(couponList, coupon -> {
            ToastUtils.showShort(this, coupon.getTitle());
        });
        rvCoupons.setAdapter(adapter);
    }

    private void showEmpty() {
        llEmpty.setVisibility(View.VISIBLE);
        rvCoupons.setVisibility(View.GONE);
    }

    private void updateStatistics() {
        int userId = SharedPreferencesUtils.getUserId(this);
        if (userId == -1) return;

        int unused = couponDao.getCouponsByStatus(userId, 1).size();
        int used = couponDao.getCouponsByStatus(userId, 2).size();
        int expired = couponDao.getCouponsByStatus(userId, 3).size();

        tvUnusedCount.setText(unused + "张可用");
        tvUsedCount.setText(used + "张已用");
        tvExpiredCount.setText(expired + "张过期");
    }

    @Override
    protected void onResume() {
        super.onResume();
        loadData(currentStatus);
        updateStatistics();
    }
}