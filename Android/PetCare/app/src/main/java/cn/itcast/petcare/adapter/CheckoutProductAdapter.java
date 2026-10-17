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
import java.text.DecimalFormat;
import java.util.List;

public class CheckoutProductAdapter extends RecyclerView.Adapter<CheckoutProductAdapter.ViewHolder> {

    private List<CartItem> cartList;
    private DecimalFormat df = new DecimalFormat("0.00");

    public CheckoutProductAdapter(List<CartItem> cartList) {
        this.cartList = cartList;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_checkout_product, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        CartItem item = cartList.get(position);

        holder.tvName.setText(item.getProductName());
        holder.tvPrice.setText("¥" + df.format(item.getPrice()));
        holder.tvQuantity.setText("×" + item.getQuantity());
        holder.tvTotal.setText("¥" + df.format(item.getPrice() * item.getQuantity()));
    }

    @Override
    public int getItemCount() {
        return cartList == null ? 0 : cartList.size();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        TextView tvName, tvPrice, tvQuantity, tvTotal;

        ViewHolder(@NonNull View itemView) {
            super(itemView);
            tvName = itemView.findViewById(R.id.tv_checkout_product_name);
            tvPrice = itemView.findViewById(R.id.tv_checkout_product_price);
            tvQuantity = itemView.findViewById(R.id.tv_checkout_product_quantity);
            tvTotal = itemView.findViewById(R.id.tv_checkout_product_total);
        }
    }
}