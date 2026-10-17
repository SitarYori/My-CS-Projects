package cn.itcast.petcare.adapter;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.model.ServiceOrder;
import java.util.List;

public class BookingAdapter extends RecyclerView.Adapter<BookingAdapter.ViewHolder> {

    private List<ServiceOrder> bookingList;
    private OnBookingClickListener listener;

    public interface OnBookingClickListener {
        void onBookingClick(ServiceOrder order);
    }

    public BookingAdapter(List<ServiceOrder> bookingList, OnBookingClickListener listener) {
        this.bookingList = bookingList;
        this.listener = listener;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_booking, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        ServiceOrder order = bookingList.get(position);

        String typeIcon = "boarding".equals(order.getServiceType()) ? "🐾" : "🛁";
        String typeName = "boarding".equals(order.getServiceType()) ? "宠物寄养" : "美容洗护";
        holder.tvServiceType.setText(typeIcon + " " + typeName);

        holder.tvStatus.setText(order.getStatusText());
        int statusColor;
        switch (order.getStatus()) {
            case 1: statusColor = 0xFFFF9800; break;
            case 2: statusColor = 0xFF2196F3; break;
            case 3: statusColor = 0xFF4CAF50; break;
            case 4: statusColor = 0xFF9E9E9E; break;
            default: statusColor = 0xFF999999;
        }
        holder.tvStatus.setBackgroundColor(statusColor);

        holder.tvPetName.setText(order.getPetName() + "（" + order.getPetType() + "）");
        holder.tvServiceName.setText(order.getServiceName());
        holder.tvDatetime.setText(order.getServiceDate() + " " + order.getServiceTime());
        holder.tvAddress.setText(order.getAddress());
        holder.tvCreateTime.setText("提交于：" + order.getCreateTime());

        holder.itemView.setOnClickListener(v -> {
            if (listener != null) {
                listener.onBookingClick(order);
            }
        });
    }

    @Override
    public int getItemCount() {
        return bookingList == null ? 0 : bookingList.size();
    }

    public void updateData(List<ServiceOrder> newList) {
        this.bookingList = newList;
        notifyDataSetChanged();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        TextView tvServiceType, tvStatus, tvPetName, tvServiceName, tvDatetime, tvAddress, tvCreateTime;

        ViewHolder(@NonNull View itemView) {
            super(itemView);
            tvServiceType = itemView.findViewById(R.id.tv_service_type);
            tvStatus = itemView.findViewById(R.id.tv_status);
            tvPetName = itemView.findViewById(R.id.tv_pet_name);
            tvServiceName = itemView.findViewById(R.id.tv_service_name);
            tvDatetime = itemView.findViewById(R.id.tv_datetime);
            tvAddress = itemView.findViewById(R.id.tv_address);
            tvCreateTime = itemView.findViewById(R.id.tv_create_time);
        }
    }
}