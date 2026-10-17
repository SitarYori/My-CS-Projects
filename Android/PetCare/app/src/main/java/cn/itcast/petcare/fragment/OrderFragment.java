package cn.itcast.petcare.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.activity.OrderDetailActivity;
import cn.itcast.petcare.adapter.OrderAdapter;
import cn.itcast.petcare.dao.OrderDao;
import cn.itcast.petcare.model.Order;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;

import java.util.ArrayList;
import java.util.List;

public class OrderFragment extends Fragment {

    private TextView tabAll, tabPending, tabPaid, tabCompleted, tabCancelled;
    private RecyclerView rvOrders;
    private LinearLayout llEmpty;
    private OrderDao orderDao;
    private OrderAdapter adapter;
    private List<Order> orderList = new ArrayList<>();
    private int currentStatus = 0;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_order, container, false);

        orderDao = new OrderDao(requireContext());

        initViews(view);
        setListeners();
        loadOrders(0);

        return view;
    }

    private void initViews(View view) {
        tabAll = view.findViewById(R.id.tab_all);
        tabPending = view.findViewById(R.id.tab_pending);
        tabPaid = view.findViewById(R.id.tab_paid);
        tabCompleted = view.findViewById(R.id.tab_completed);
        tabCancelled = view.findViewById(R.id.tab_cancelled);
        rvOrders = view.findViewById(R.id.rv_orders);
        llEmpty = view.findViewById(R.id.ll_empty);

        rvOrders.setLayoutManager(new LinearLayoutManager(getContext()));
    }

    private void setListeners() {
        tabAll.setOnClickListener(v -> { selectTab(0); loadOrders(0); });
        tabPending.setOnClickListener(v -> { selectTab(Order.STATUS_PENDING); loadOrders(Order.STATUS_PENDING); });
        tabPaid.setOnClickListener(v -> { selectTab(Order.STATUS_PAID); loadOrders(Order.STATUS_PAID); });
        tabCompleted.setOnClickListener(v -> { selectTab(Order.STATUS_COMPLETED); loadOrders(Order.STATUS_COMPLETED); });
        tabCancelled.setOnClickListener(v -> { selectTab(Order.STATUS_CANCELLED); loadOrders(Order.STATUS_CANCELLED); });
    }

    private void selectTab(int status) {
        resetTabs();

        TextView selectedTab;
        if (status == 0) {
            selectedTab = tabAll;
        } else if (status == Order.STATUS_PENDING) {
            selectedTab = tabPending;
        } else if (status == Order.STATUS_PAID) {
            selectedTab = tabPaid;
        } else if (status == Order.STATUS_COMPLETED) {
            selectedTab = tabCompleted;
        } else {
            selectedTab = tabCancelled;
        }

        selectedTab.setTextColor(getResources().getColor(android.R.color.holo_blue_dark));
        selectedTab.setBackgroundResource(R.drawable.bg_tab_selected);
        currentStatus = status;
    }

    private void resetTabs() {
        TextView[] tabs = {tabAll, tabPending, tabPaid, tabCompleted, tabCancelled};
        for (TextView tab : tabs) {
            tab.setTextColor(getResources().getColor(android.R.color.darker_gray));
            tab.setBackgroundResource(R.drawable.bg_tab_normal);
        }
    }

    private void loadOrders(int status) {
        int userId = SharedPreferencesUtils.getUserId(requireContext());
        if (userId == -1) {
            showEmpty();
            return;
        }

        if (status == 0) {
            orderList = orderDao.getOrdersByUserId(userId);
        } else {
            orderList = orderDao.getOrdersByStatus(userId, status);
        }

        // ⭐ 打印日志查看订单状态
        if (orderList != null) {
            for (Order order : orderList) {
                android.util.Log.d("OrderFragment", "订单ID: " + order.getId() +
                        ", 状态: " + order.getStatus() +
                        ", 状态文字: " + order.getStatusText());
            }
        }

        if (orderList == null || orderList.isEmpty()) {
            showEmpty();
        } else {
            showOrders();
        }
    }

    private void showOrders() {
        llEmpty.setVisibility(View.GONE);
        rvOrders.setVisibility(View.VISIBLE);

        if (adapter == null) {
            adapter = new OrderAdapter(orderList, new OrderAdapter.OnOrderClickListener() {
                @Override
                public void onOrderClick(Order order) {
                    Intent intent = new Intent(getContext(), OrderDetailActivity.class);
                    intent.putExtra("order", order);
                    startActivity(intent);
                }

                @Override
                public void onDeleteClick(Order order) {
                    // ⭐ 弹出确认对话框
                    new AlertDialog.Builder(getContext())
                            .setTitle("删除订单")
                            .setMessage("确定要删除该订单吗？")
                            .setPositiveButton("确定", (dialog, which) -> {
                                orderDao.deleteOrder(order.getId());
                                ToastUtils.showShort(getContext(), "订单已删除");
                                loadOrders(currentStatus);
                            })
                            .setNegativeButton("取消", null)
                            .show();
                }
            });
            rvOrders.setAdapter(adapter);
        } else {
            adapter.updateData(orderList);
        }
    }

    private void showEmpty() {
        llEmpty.setVisibility(View.VISIBLE);
        rvOrders.setVisibility(View.GONE);
    }

    @Override
    public void onResume() {
        super.onResume();
        loadOrders(currentStatus);
    }
}