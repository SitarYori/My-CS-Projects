package cn.itcast.petcare.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.fragment.app.Fragment;
import androidx.viewpager2.widget.ViewPager2;
import cn.itcast.petcare.R;
import cn.itcast.petcare.activity.EquityCardActivity;
import cn.itcast.petcare.activity.MainActivity;
import cn.itcast.petcare.activity.MemberCenterActivity;
import cn.itcast.petcare.activity.ServiceBookingActivity;
import cn.itcast.petcare.adapter.BannerAdapter;
import cn.itcast.petcare.dao.CartDao;
import cn.itcast.petcare.utils.SharedPreferencesUtils;

public class HomeFragment extends Fragment {

    private ViewPager2 viewPagerBanner;
    private LinearLayout llIndicator;
    private LinearLayout llBoarding, llGrooming, llPetMall, llMembers, llEquity;
    private FrameLayout flCartFloat;
    private TextView tvFloatCartCount;
    private Handler handler = new Handler();
    private int currentPage = 0;
    private CartDao cartDao;

    private final int[] bannerImages = {
            R.drawable.banner1,
            R.drawable.banner2,
            R.drawable.banner3,
            R.drawable.banner4
    };

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_home, container, false);

        cartDao = new CartDao(requireContext());

        initViews(view);
        setupBanner();
        startAutoScroll();
        setListeners();
        updateCartBadge();

        return view;
    }

    private void initViews(View view) {
        viewPagerBanner = view.findViewById(R.id.viewPagerBanner);
        llIndicator = view.findViewById(R.id.ll_indicator);

        llBoarding = view.findViewById(R.id.ll_boarding);
        llGrooming = view.findViewById(R.id.ll_grooming);
        llPetMall = view.findViewById(R.id.ll_pet_mall);
        llMembers = view.findViewById(R.id.ll_members);
        llEquity = view.findViewById(R.id.ll_equity);

        // ⭐ 添加 null 检查，防止找不到 ID 时崩溃
        try {
            flCartFloat = view.findViewById(R.id.fl_cart_float);
            tvFloatCartCount = view.findViewById(R.id.tv_float_cart_count);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //轮播图
    private void setupBanner() {
        BannerAdapter adapter = new BannerAdapter(bannerImages);
        viewPagerBanner.setAdapter(adapter);

        addIndicators(bannerImages.length);

        viewPagerBanner.registerOnPageChangeCallback(new ViewPager2.OnPageChangeCallback() {
            @Override
            public void onPageSelected(int position) {
                super.onPageSelected(position);
                updateIndicator(position);
                currentPage = position;
            }
        });
    }

    private void addIndicators(int count) {
        llIndicator.removeAllViews();
        for (int i = 0; i < count; i++) {
            View dot = new View(requireContext());
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(20, 6);
            params.setMargins(4, 4, 4, 4);
            dot.setLayoutParams(params);
            dot.setBackgroundResource(i == 0 ? R.drawable.bg_dot_selected : R.drawable.bg_dot_normal);
            llIndicator.addView(dot);
        }
    }

    private void updateIndicator(int position) {
        for (int i = 0; i < llIndicator.getChildCount(); i++) {
            View dot = llIndicator.getChildAt(i);
            dot.setBackgroundResource(i == position ? R.drawable.bg_dot_selected : R.drawable.bg_dot_normal);
        }
    }

    private void startAutoScroll() {
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if (viewPagerBanner.getAdapter() != null) {
                    int total = viewPagerBanner.getAdapter().getItemCount();
                    if (total > 0) {
                        currentPage = (currentPage + 1) % total;
                        viewPagerBanner.setCurrentItem(currentPage, true);
                    }
                }
                handler.postDelayed(this, 3000);
            }
        }, 3000);
    }

    private void setListeners() {
        // 宠物寄养
        llBoarding.setOnClickListener(v -> {
            Intent intent = new Intent(getContext(), ServiceBookingActivity.class);
            intent.putExtra("service_type", "boarding");
            intent.putExtra("service_title", "宠物寄养");
            startActivity(intent);
        });

       // 美容洗护
        llGrooming.setOnClickListener(v -> {
            Intent intent = new Intent(getContext(), ServiceBookingActivity.class);
            intent.putExtra("service_type", "grooming");
            intent.putExtra("service_title", "美容洗护");
            startActivity(intent);
        });

        llPetMall.setOnClickListener(v -> {
            if (getActivity() instanceof MainActivity) {
                ((MainActivity) getActivity()).switchToProductTab();
            }
        });

        // 我的会员 → 跳转到会员中心
        llMembers.setOnClickListener(v -> {
            Intent intent = new Intent(getContext(), MemberCenterActivity.class);
            startActivity(intent);
        });

        // 权益卡
        llEquity.setOnClickListener(v -> {
            Intent intent = new Intent(getActivity(), EquityCardActivity.class);
            startActivity(intent);
        });

        // ⭐ 添加 null 检查，防止崩溃
        // ⭐ 悬浮购物车点击
        if (flCartFloat != null) {
            flCartFloat.setOnClickListener(v -> {
                // 添加 Toast 测试是否触发
                android.widget.Toast.makeText(getContext(), "点击了悬浮购物车", android.widget.Toast.LENGTH_SHORT).show();

                if (getActivity() instanceof MainActivity) {
                    ((MainActivity) getActivity()).switchToCartTab();
                } else {
                    android.widget.Toast.makeText(getContext(), "跳转失败", android.widget.Toast.LENGTH_SHORT).show();
                }
            });
        }
    }

    private void updateCartBadge() {
        int userId = SharedPreferencesUtils.getUserId(requireContext());
        if (userId != -1 && cartDao != null && tvFloatCartCount != null) {
            int count = cartDao.getCartCount(userId);
            if (count > 0) {
                tvFloatCartCount.setVisibility(View.VISIBLE);
                tvFloatCartCount.setText(String.valueOf(count));
            } else {
                tvFloatCartCount.setVisibility(View.GONE);
            }
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        updateCartBadge();
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        handler.removeCallbacksAndMessages(null);
    }
}