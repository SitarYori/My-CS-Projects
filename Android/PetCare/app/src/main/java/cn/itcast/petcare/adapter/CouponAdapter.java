package cn.itcast.petcare.adapter;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.model.Coupon;
import java.text.DecimalFormat;
import java.util.List;

public class CouponAdapter extends RecyclerView.Adapter<CouponAdapter.ViewHolder> {

    private List<Coupon> couponList;
    private OnCouponClickListener listener;

    public interface OnCouponClickListener {
        void onCouponClick(Coupon coupon);
    }

    public CouponAdapter(List<Coupon> couponList, OnCouponClickListener listener) {
        this.couponList = couponList;
        this.listener = listener;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_coupon, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        Coupon coupon = couponList.get(position);
        DecimalFormat df = new DecimalFormat("0.00");

        // 优惠金额/折扣显示
        if (coupon.getType() == Coupon.TYPE_DISCOUNT) {
            // 折扣券：显示 8.5折
            holder.tvCouponValue.setText((int)(coupon.getDiscountValue() * 10) + "折");
        } else if (coupon.getType() == Coupon.TYPE_FREE_SHIPPING) {
            // 免运费券
            holder.tvCouponValue.setText("免");
            holder.tvCouponUnit.setText("运费");
        } else {
            // 满减券：显示 ¥15
            holder.tvCouponValue.setText("¥" + (int)coupon.getDiscountValue());
        }

        holder.tvCouponUnit.setText(coupon.getTypeText());

        // 优惠券标题
        holder.tvCouponTitle.setText(coupon.getTitle());

        // 优惠券描述
        String desc = "";
        if (coupon.getMinAmount() > 0) {
            desc = "满" + (int)coupon.getMinAmount() + "元可用";
        } else {
            desc = "无门槛使用";
        }
        holder.tvCouponDesc.setText(desc);

        // 来源
        holder.tvCouponSource.setText(coupon.getSource());

        // 有效期
        holder.tvCouponExpire.setText("有效期至" + coupon.getEndTime().substring(0, 10));

        // 点击事件
        holder.itemView.setOnClickListener(v -> {
            if (listener != null) {
                listener.onCouponClick(coupon);
            }
        });
    }

    @Override
    public int getItemCount() {
        return couponList == null ? 0 : couponList.size();
    }

    public void updateData(List<Coupon> newList) {
        this.couponList = newList;
        notifyDataSetChanged();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        TextView tvCouponValue, tvCouponUnit, tvCouponTitle, tvCouponDesc, tvCouponSource, tvCouponExpire;

        ViewHolder(@NonNull View itemView) {
            super(itemView);
            tvCouponValue = itemView.findViewById(R.id.tv_coupon_value);
            tvCouponUnit = itemView.findViewById(R.id.tv_coupon_unit);
            tvCouponTitle = itemView.findViewById(R.id.tv_coupon_title);
            tvCouponDesc = itemView.findViewById(R.id.tv_coupon_desc);
            tvCouponSource = itemView.findViewById(R.id.tv_coupon_source);
            tvCouponExpire = itemView.findViewById(R.id.tv_coupon_expire);
        }
    }
}