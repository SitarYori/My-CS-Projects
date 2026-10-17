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
import cn.itcast.petcare.adapter.BookingAdapter;
import cn.itcast.petcare.dao.ServiceOrderDao;
import cn.itcast.petcare.model.ServiceOrder;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import java.util.List;

public class MyBookingActivity extends AppCompatActivity {

    private ImageView ivBack;
    private RecyclerView rvBookings;
    private LinearLayout llEmpty;
    private ServiceOrderDao serviceOrderDao;
    private BookingAdapter adapter;
    private List<ServiceOrder> bookingList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_booking);

        serviceOrderDao = new ServiceOrderDao(this);

        initViews();
        setListeners();
        loadData();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        rvBookings = findViewById(R.id.rv_bookings);
        llEmpty = findViewById(R.id.ll_empty);

        rvBookings.setLayoutManager(new LinearLayoutManager(this));
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());
    }

    private void loadData() {
        int userId = SharedPreferencesUtils.getUserId(this);
        if (userId == -1) {
            showEmpty();
            return;
        }

        bookingList = serviceOrderDao.getServiceOrdersByUserId(userId);

        if (bookingList == null || bookingList.isEmpty()) {
            showEmpty();
        } else {
            showList();
        }
    }

    private void showList() {
        llEmpty.setVisibility(View.GONE);
        rvBookings.setVisibility(View.VISIBLE);

        adapter = new BookingAdapter(bookingList, order -> {
            // 点击预约跳转详情
        });
        rvBookings.setAdapter(adapter);
    }

    private void showEmpty() {
        llEmpty.setVisibility(View.VISIBLE);
        rvBookings.setVisibility(View.GONE);
    }

    @Override
    protected void onResume() {
        super.onResume();
        loadData();
    }
}