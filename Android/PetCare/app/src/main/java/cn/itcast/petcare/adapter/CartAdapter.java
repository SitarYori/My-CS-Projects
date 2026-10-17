package cn.itcast.petcare.adapter;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.model.CartItem;
import cn.itcast.petcare.utils.ToastUtils;

import java.text.DecimalFormat;
import java.util.List;

public class CartAdapter extends RecyclerView.Adapter<CartAdapter.ViewHolder> {

    private List<CartItem> cartList;
    private OnCartItemListener listener;
    private static final int MAX_QUANTITY = 10;//最大商品购买数量

    public interface OnCartItemListener {
        void onQuantityChange(CartItem item, int newQuantity);
        void onDelete(CartItem item);
    }

    public CartAdapter(List<CartItem> cartList, OnCartItemListener listener) {
        this.cartList = cartList;
        this.listener = listener;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_cart, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        CartItem item = cartList.get(position);
        DecimalFormat df = new DecimalFormat("0.00");

        holder.tvName.setText(item.getProductName());
        holder.tvDesc.setText(item.getProductDesc());
        holder.tvPrice.setText("¥" + df.format(item.getPrice()));
        holder.tvQuantity.setText(String.valueOf(item.getQuantity()));

        if (item.getOriginalPrice() > 0) {
            holder.tvOriginalPrice.setVisibility(View.VISIBLE);
            holder.tvOriginalPrice.setText("¥" + df.format(item.getOriginalPrice()));
        } else {
            holder.tvOriginalPrice.setVisibility(View.GONE);
        }

        // 图片
        if (item.getImageRes() != 0) {
            holder.ivImage.setImageResource(item.getImageRes());
        }

        // 减号“-”
        holder.btnDecrease.setOnClickListener(v -> {
            int qty = item.getQuantity();
            if (qty > 1) {
                qty--;
                item.setQuantity(qty);
                holder.tvQuantity.setText(String.valueOf(qty));
                if (listener != null) {
                    listener.onQuantityChange(item, qty);
                }
            }
        });

        // ⭐ 加号：增加数量，但不能超过上限
        holder.btnIncrease.setOnClickListener(v -> {
            int qty = item.getQuantity();
            if (qty < MAX_QUANTITY) {
                qty++;
                item.setQuantity(qty);
                holder.tvQuantity.setText(String.valueOf(qty));
                if (listener != null) {
                    listener.onQuantityChange(item, qty);
                }
            } else {
                ToastUtils.showShort(holder.itemView.getContext(),
                        "该商品限购 " + MAX_QUANTITY + " 件");
            }
        });

        // 删除
        holder.btnDelete.setOnClickListener(v -> {
            if (listener != null) {
                listener.onDelete(item);
            }
        });
    }

    @Override
    public int getItemCount() {
        return cartList == null ? 0 : cartList.size();
    }

    public void updateData(List<CartItem> newList) {
        this.cartList = newList;
        notifyDataSetChanged();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        ImageView ivImage;
        TextView tvName, tvDesc, tvPrice, tvOriginalPrice;
        TextView tvQuantity;
        TextView btnDecrease, btnIncrease, btnDelete;

        ViewHolder(@NonNull View itemView) {
            super(itemView);
            ivImage = itemView.findViewById(R.id.iv_product_image);
            tvName = itemView.findViewById(R.id.tv_product_name);
            tvDesc = itemView.findViewById(R.id.tv_product_desc);
            tvPrice = itemView.findViewById(R.id.tv_price);
            tvOriginalPrice = itemView.findViewById(R.id.tv_original_price);
            tvQuantity = itemView.findViewById(R.id.tv_quantity);
            btnDecrease = itemView.findViewById(R.id.btn_decrease);
            btnIncrease = itemView.findViewById(R.id.btn_increase);
            btnDelete = itemView.findViewById(R.id.btn_delete);
        }
    }
}