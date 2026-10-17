package cn.itcast.petcare.adapter;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;

public class BannerAdapter extends RecyclerView.Adapter<BannerAdapter.BannerViewHolder> {

    private int[] imageResources;

    public BannerAdapter(int[] imageResources) {
        this.imageResources = imageResources;
    }

    @NonNull
    @Override
    public BannerViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_banner, parent, false);
        return new BannerViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull BannerViewHolder holder, int position) {
        holder.ivBanner.setImageResource(imageResources[position]);
    }

    @Override
    public int getItemCount() {
        return imageResources.length;
    }

    static class BannerViewHolder extends RecyclerView.ViewHolder {
        ImageView ivBanner;

        BannerViewHolder(@NonNull View itemView) {
            super(itemView);
            ivBanner = itemView.findViewById(R.id.iv_banner);
        }
    }
}