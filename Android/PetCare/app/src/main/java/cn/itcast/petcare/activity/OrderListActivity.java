package cn.itcast.petcare.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.adapter.OrderAdapter;
import cn.itcast.petcare.dao.OrderDao;
import cn.itcast.petcare.model.Order;
import cn.itcast.petcare.utils.SharedPreferencesUtils;

import java.util.List;
//订单列表页：查看所有订单，状态Tab切换，删除订单
public class OrderListActivity extends AppCompatActivity {

    private ImageView ivBack;
    private RecyclerView rvOrders;
    private LinearLayout llEmpty;
    private OrderDao orderDao;
    private OrderAdapter adapter;
    private List<Order> orderList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_order_list);

        orderDao = new OrderDao(this);

        initViews();
        setListeners();
        loadData();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        rvOrders = findViewById(R.id.rv_orders);
        llEmpty = findViewById(R.id.ll_empty);

        rvOrders.setLayoutManager(new LinearLayoutManager(this));
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

        orderList = orderDao.getOrdersByUserId(userId);

        if (orderList == null || orderList.isEmpty()) {
            showEmpty();
        } else {
            showList();
        }
    }

    private void showList() {
        llEmpty.setVisibility(View.GONE);
        rvOrders.setVisibility(View.VISIBLE);

        // ⭐ 使用匿名内部类替代 lambda
        OrderAdapter.OnOrderClickListener listener = new OrderAdapter.OnOrderClickListener() {
            @Override
            public void onOrderClick(Order order) {
                Intent intent = new Intent(OrderListActivity.this, OrderDetailActivity.class);
                intent.putExtra("order", order);
                startActivity(intent);
            }

            /**
             * 删除订单：弹出确认对话框后删除
             */
            @Override
            public void onDeleteClick(Order order) {
                // 在订单列表页面也可以支持删除
                new androidx.appcompat.app.AlertDialog.Builder(OrderListActivity.this)
                        .setTitle("删除订单")
                        .setMessage("确定要删除该订单吗？")
                        .setPositiveButton("确定", (dialog, which) -> {
                            orderDao.deleteOrder(order.getId());
                            loadData();
                            android.widget.Toast.makeText(OrderListActivity.this, "订单已删除", android.widget.Toast.LENGTH_SHORT).show();
                        })
                        .setNegativeButton("取消", null)
                        .show();
            }
        };

        adapter = new OrderAdapter(orderList, listener);
        rvOrders.setAdapter(adapter);
    }

    private void showEmpty() {
        llEmpty.setVisibility(View.VISIBLE);
        rvOrders.setVisibility(View.GONE);
    }
}