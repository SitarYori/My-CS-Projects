package cn.itcast.petcare.adapter;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.model.Order;
import java.text.DecimalFormat;
import java.util.List;

public class OrderAdapter extends RecyclerView.Adapter<OrderAdapter.ViewHolder> {

    private List<Order> orderList;
    private OnOrderClickListener listener;

    public interface OnOrderClickListener {
        void onOrderClick(Order order);
        void onDeleteClick(Order order);
    }

    public OrderAdapter(List<Order> orderList, OnOrderClickListener listener) {
        this.orderList = orderList;
        this.listener = listener;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_order, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        Order order = orderList.get(position);
        DecimalFormat df = new DecimalFormat("0.00");

        holder.tvOrderNo.setText("订单号：" + order.getOrderNo());
        holder.tvProductName.setText(order.getProductName());
        holder.tvPrice.setText("¥" + df.format(order.getPrice()));
        holder.tvQuantity.setText("×" + order.getQuantity());
        holder.tvTotal.setText("¥" + df.format(order.getTotalPrice()));
        holder.tvStatus.setText(order.getStatusText());
        holder.tvStatus.setTextColor(order.getStatusColor());
        holder.tvCreateTime.setText(order.getCreateTime());

        // ⭐ 显示/隐藏已评价标签
        if (order.isReviewed()) {
            holder.tvReviewStatus.setVisibility(View.VISIBLE);
            holder.tvReviewStatus.setText("已评价");
        } else {
            holder.tvReviewStatus.setVisibility(View.GONE);
        }

        // ⭐ 只有已完成或已取消的订单才显示删除按钮
        if (order.getStatus() == Order.STATUS_COMPLETED || order.getStatus() == Order.STATUS_CANCELLED) {
            holder.btnDelete.setVisibility(View.VISIBLE);
        } else {
            holder.btnDelete.setVisibility(View.GONE);
        }

        // 查看详情
        holder.btnViewDetail.setOnClickListener(v -> {
            if (listener != null) {
                listener.onOrderClick(order);
            }
        });

        // 删除按钮点击
        holder.btnDelete.setOnClickListener(v -> {
            if (listener != null) {
                listener.onDeleteClick(order);
            }
        });
    }

    @Override
    public int getItemCount() {
        return orderList == null ? 0 : orderList.size();
    }

    public void updateData(List<Order> newList) {
        this.orderList = newList;
        notifyDataSetChanged();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        TextView tvOrderNo, tvProductName, tvPrice, tvQuantity, tvTotal, tvStatus, tvCreateTime;
        TextView tvReviewStatus;  // ⭐ 新增已评价标签
        TextView btnDelete, btnViewDetail;

        ViewHolder(@NonNull View itemView) {
            super(itemView);
            tvOrderNo = itemView.findViewById(R.id.tv_order_no);
            tvProductName = itemView.findViewById(R.id.tv_order_product_name);
            tvPrice = itemView.findViewById(R.id.tv_order_price);
            tvQuantity = itemView.findViewById(R.id.tv_order_quantity);
            tvTotal = itemView.findViewById(R.id.tv_order_total);
            tvStatus = itemView.findViewById(R.id.tv_order_status);
            tvCreateTime = itemView.findViewById(R.id.tv_order_time);
            tvReviewStatus = itemView.findViewById(R.id.tv_review_status);  // ⭐ 新增
            btnDelete = itemView.findViewById(R.id.btn_delete_order);
            btnViewDetail = itemView.findViewById(R.id.btn_view_detail);
        }
    }
}