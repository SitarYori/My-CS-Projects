package cn.itcast.petcare.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import cn.itcast.petcare.R;
import cn.itcast.petcare.dao.OrderDao;
import cn.itcast.petcare.model.Order;
import cn.itcast.petcare.utils.ToastUtils;

import java.text.DecimalFormat;

/**
 * 订单详情页面
 * 功能：订单信息展示、状态时间线、确认收货、评价
 */
public class OrderDetailActivity extends AppCompatActivity {

    // ==================== 控件声明 ====================

    private ImageView ivBack;
    private TextView tvStatus, tvOrderNo, tvProductName, tvPrice, tvQuantity, tvTotal;
    private TextView tvReceiver, tvAddress, tvCreateTime, tvPayTime, tvCompleteTime;
    private LinearLayout llTimeLine;
    private LinearLayout llBottomBtn;
    private Button btnCancelOrder, btnPayOrder, btnConfirmReceipt;

    // ⭐ 评价显示控件
    private LinearLayout llComment;
    private TextView tvRatingStars, tvCommentText;

    private Order order;
    private OrderDao orderDao;
    private final DecimalFormat df = new DecimalFormat("0.00");

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_order_detail);

        order = (Order) getIntent().getSerializableExtra("order");
        orderDao = new OrderDao(this);

        initViews();
        setListeners();
        displayData();
        updateTimeLine();
        updateBottomButtons();
        showComment();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        tvStatus = findViewById(R.id.tv_detail_status);
        tvOrderNo = findViewById(R.id.tv_detail_order_no);
        tvProductName = findViewById(R.id.tv_detail_product_name);
        tvPrice = findViewById(R.id.tv_detail_price);
        tvQuantity = findViewById(R.id.tv_detail_quantity);
        tvTotal = findViewById(R.id.tv_detail_total);
        tvReceiver = findViewById(R.id.tv_detail_receiver);
        tvAddress = findViewById(R.id.tv_detail_address);
        tvCreateTime = findViewById(R.id.tv_detail_create_time);
        tvPayTime = findViewById(R.id.tv_detail_pay_time);
        tvCompleteTime = findViewById(R.id.tv_detail_complete_time);
        llTimeLine = findViewById(R.id.ll_time_line);
        llBottomBtn = findViewById(R.id.ll_bottom_btn);
        btnCancelOrder = findViewById(R.id.btn_cancel_order);
        btnPayOrder = findViewById(R.id.btn_pay_order);
        btnConfirmReceipt = findViewById(R.id.btn_confirm_receipt);

        // ⭐ 评价显示控件
        llComment = findViewById(R.id.ll_comment);
        tvRatingStars = findViewById(R.id.tv_rating_stars);
        tvCommentText = findViewById(R.id.tv_comment_text);
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());

        // 取消订单
        btnCancelOrder.setOnClickListener(v -> {
            if (order != null) {
                orderDao.cancelOrder(order.getId());
                ToastUtils.showShort(this, "订单已取消");
                finish();
            }
        });

        // 去支付
        btnPayOrder.setOnClickListener(v -> {
            if (order != null) {
                orderDao.updateOrderStatus(order.getId(), Order.STATUS_PAID);
                ToastUtils.showShort(this, "支付成功！");
                finish();
            }
        });

        // ⭐ 确认收货 → 跳转评价页面
        btnConfirmReceipt.setOnClickListener(v -> {
            if (order != null) {
                orderDao.updateOrderStatus(order.getId(), Order.STATUS_COMPLETED);
                ToastUtils.showShort(this, "已确认收货！");

                // 跳转到评价页面
                Intent intent = new Intent(OrderDetailActivity.this, OrderCommentActivity.class);
                intent.putExtra("order", order);
                startActivity(intent);

                finish();
            }
        });
    }

    private void displayData() {
        if (order == null) return;

        tvStatus.setText(order.getStatusText());
        tvStatus.setTextColor(order.getStatusColor());
        tvOrderNo.setText(order.getOrderNo());
        tvProductName.setText(order.getProductName());
        tvPrice.setText("¥" + df.format(order.getPrice()));
        tvQuantity.setText("×" + order.getQuantity());
        tvTotal.setText("¥" + df.format(order.getTotalPrice()));
        tvReceiver.setText(order.getReceiverName() + "  " + order.getReceiverPhone());
        tvAddress.setText(order.getAddressDetail());

        tvCreateTime.setText("下单时间：" + order.getCreateTime());

        if (order.getPayTime() != null && !order.getPayTime().isEmpty()) {
            tvPayTime.setVisibility(View.VISIBLE);
            tvPayTime.setText("支付时间：" + order.getPayTime());
        } else {
            tvPayTime.setVisibility(View.GONE);
        }

        if (order.getCompleteTime() != null && !order.getCompleteTime().isEmpty()) {
            tvCompleteTime.setVisibility(View.VISIBLE);
            tvCompleteTime.setText("完成时间：" + order.getCompleteTime());
        } else {
            tvCompleteTime.setVisibility(View.GONE);
        }
    }

    private void updateTimeLine() {
        llTimeLine.removeAllViews();

        addTimeLineItem("下单", order.getCreateTime(), true);

        if (order.getStatus() >= Order.STATUS_PAID && order.getPayTime() != null && !order.getPayTime().isEmpty()) {
            addTimeLineItem("支付", order.getPayTime(), true);
        } else if (order.getStatus() == Order.STATUS_PENDING) {
            addTimeLineItem("支付", "等待支付...", false);
        }

        if (order.getStatus() >= Order.STATUS_COMPLETED && order.getCompleteTime() != null && !order.getCompleteTime().isEmpty()) {
            addTimeLineItem("完成", order.getCompleteTime(), true);
        } else if (order.getStatus() == Order.STATUS_PAID) {
            addTimeLineItem("完成", "等待确认收货...", false);
        }

        if (order.getStatus() == Order.STATUS_CANCELLED) {
            addTimeLineItem("已取消", order.getPayTime() != null ? order.getPayTime() : "用户取消", true);
        }
    }

    private void addTimeLineItem(String title, String time, boolean isDone) {
        View item = getLayoutInflater().inflate(R.layout.item_time_line, llTimeLine, false);
        TextView tvTitle = item.findViewById(R.id.tv_time_title);
        TextView tvTime = item.findViewById(R.id.tv_time_value);
        View vDot = item.findViewById(R.id.v_time_dot);

        tvTitle.setText(title);
        tvTime.setText(time != null && !time.isEmpty() && !time.equals("等待支付...") && !time.equals("等待确认收货...") && !time.equals("用户取消") ? time : "");

        if (isDone) {
            vDot.setBackgroundResource(R.drawable.bg_dot_selected);
        } else {
            vDot.setBackgroundResource(R.drawable.bg_dot_normal);
        }

        llTimeLine.addView(item);
    }

    /**
     * ⭐ 更新底部操作按钮
     */
    private void updateBottomButtons() {
        if (order == null) return;

        btnCancelOrder.setVisibility(View.GONE);
        btnPayOrder.setVisibility(View.GONE);
        btnConfirmReceipt.setVisibility(View.GONE);

        if (order.getStatus() == Order.STATUS_PENDING) {
            // 待付款：取消订单 + 去支付
            llBottomBtn.setVisibility(View.VISIBLE);
            btnCancelOrder.setVisibility(View.VISIBLE);
            btnPayOrder.setVisibility(View.VISIBLE);
        } else if (order.getStatus() == Order.STATUS_PAID) {
            // 已支付：确认收货
            llBottomBtn.setVisibility(View.VISIBLE);
            btnConfirmReceipt.setVisibility(View.VISIBLE);
            btnConfirmReceipt.setText("确认收货");
        } else if (order.getStatus() == Order.STATUS_COMPLETED && !order.isReviewed()) {
            // ⭐ 已完成但未评价 → 显示"去评价"按钮
            llBottomBtn.setVisibility(View.VISIBLE);
            btnConfirmReceipt.setVisibility(View.VISIBLE);
            btnConfirmReceipt.setText("去评价");
            btnConfirmReceipt.setOnClickListener(v -> {
                Intent intent = new Intent(OrderDetailActivity.this, OrderCommentActivity.class);
                intent.putExtra("order", order);
                startActivity(intent);
            });
        } else {
            llBottomBtn.setVisibility(View.GONE);
        }
    }

    /**
     * ⭐ 显示评价信息（已评价订单）
     */
    private void showComment() {
        if (order == null) return;

        if (order.isReviewed()) {
            llComment.setVisibility(View.VISIBLE);

            // 显示星星
            String stars = "";
            int rating = (int) order.getRating();
            for (int i = 0; i < 5; i++) {
                stars += (i < rating) ? "★" : "☆";
            }
            tvRatingStars.setText(stars);

            // 显示评价内容
            String comment = order.getComment();
            if (comment != null && !comment.isEmpty()) {
                tvCommentText.setText(comment);
            } else {
                tvCommentText.setText("（用户没有填写文字评价）");
            }
        } else {
            llComment.setVisibility(View.GONE);
        }
    }
}