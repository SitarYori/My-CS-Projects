package cn.itcast.petcare.adapter;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.model.Address;
import java.util.List;

public class AddressAdapter extends RecyclerView.Adapter<AddressAdapter.ViewHolder> {

    private List<Address> addressList;
    private boolean isSelectMode;
    private OnAddressClickListener listener;

    public interface OnAddressClickListener {
        void onEdit(Address address);
        void onDelete(Address address);
        void onSelect(Address address);
        void onSetDefault(Address address);
    }

    public AddressAdapter(List<Address> addressList, boolean isSelectMode, OnAddressClickListener listener) {
        this.addressList = addressList;
        this.isSelectMode = isSelectMode;
        this.listener = listener;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_address, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        Address address = addressList.get(position);

        holder.tvReceiver.setText(address.getReceiverName());
        holder.tvPhone.setText(address.getPhone());
        holder.tvAddress.setText(address.getFullAddress());

        if (address.isDefault()) {
            holder.tvDefault.setVisibility(View.VISIBLE);
        } else {
            holder.tvDefault.setVisibility(View.GONE);
        }

        if (isSelectMode) {
            holder.btnSelect.setVisibility(View.VISIBLE);
            holder.btnEdit.setVisibility(View.GONE);
            holder.btnDelete.setVisibility(View.GONE);
            holder.btnSetDefault.setVisibility(View.GONE);

            holder.btnSelect.setOnClickListener(v -> {
                if (listener != null) {
                    listener.onSelect(address);
                }
            });
        } else {
            holder.btnSelect.setVisibility(View.GONE);
            holder.btnEdit.setVisibility(View.VISIBLE);
            holder.btnDelete.setVisibility(View.VISIBLE);
            holder.btnSetDefault.setVisibility(View.VISIBLE);

            holder.btnEdit.setOnClickListener(v -> {
                if (listener != null) {
                    listener.onEdit(address);
                }
            });

            holder.btnDelete.setOnClickListener(v -> {
                if (listener != null) {
                    listener.onDelete(address);
                }
            });

            holder.btnSetDefault.setOnClickListener(v -> {
                if (listener != null) {
                    listener.onSetDefault(address);
                }
            });
        }
    }

    @Override
    public int getItemCount() {
        return addressList == null ? 0 : addressList.size();
    }

    public void updateData(List<Address> newList) {
        this.addressList = newList;
        notifyDataSetChanged();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        TextView tvReceiver, tvPhone, tvAddress, tvDefault;
        TextView btnEdit, btnDelete, btnSetDefault, btnSelect;

        ViewHolder(@NonNull View itemView) {
            super(itemView);
            tvReceiver = itemView.findViewById(R.id.tv_receiver);
            tvPhone = itemView.findViewById(R.id.tv_phone);
            tvAddress = itemView.findViewById(R.id.tv_address);
            tvDefault = itemView.findViewById(R.id.tv_default);
            btnEdit = itemView.findViewById(R.id.btn_edit);
            btnDelete = itemView.findViewById(R.id.btn_delete);
            btnSetDefault = itemView.findViewById(R.id.btn_set_default);
            btnSelect = itemView.findViewById(R.id.btn_select);
        }
    }
}