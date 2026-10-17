package cn.itcast.petcare.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;
import cn.itcast.petcare.R;
import cn.itcast.petcare.activity.AddressListActivity;
import cn.itcast.petcare.activity.EquityCardActivity;
import cn.itcast.petcare.activity.LoginActivity;
import cn.itcast.petcare.activity.MemberCenterActivity;
import cn.itcast.petcare.activity.MyBookingActivity;
import cn.itcast.petcare.activity.MyCouponActivity;
import cn.itcast.petcare.activity.OrderListActivity;
import cn.itcast.petcare.activity.RechargeActivity;
import cn.itcast.petcare.dao.CouponDao;
import cn.itcast.petcare.model.Coupon;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

public class ProfileFragment extends Fragment {

    private TextView tvUsername, tvVipLevel, tvPhone, tvBalance, tvPoints, tvCoupon, tvMemberLevel;
    private LinearLayout llMyOrders, llMyMembers, llMyBooking, llRecharge, llEquityCard, llAddress, llCustomerService;
    private Button btnLogout;
    private LinearLayout llMyCoupon, llCoupon;

    // ⭐ 声明 CouponDao（需要初始化）
    private CouponDao couponDao;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_profile, container, false);

        // ⭐ 初始化 CouponDao
        couponDao = new CouponDao(requireContext());

        initViews(view);
        setListeners();
        loadUserInfo();

        return view;
    }

    private void initViews(View view) {
        tvUsername = view.findViewById(R.id.tv_username);
        tvVipLevel = view.findViewById(R.id.tv_vip_level);
        tvPhone = view.findViewById(R.id.tv_phone);
        tvBalance = view.findViewById(R.id.tv_balance);
        tvPoints = view.findViewById(R.id.tv_points);
        tvCoupon = view.findViewById(R.id.tv_coupon);
        tvMemberLevel = view.findViewById(R.id.tv_member_level);

        llMyOrders = view.findViewById(R.id.ll_my_orders);
        llMyMembers = view.findViewById(R.id.ll_my_members);
        llMyBooking = view.findViewById(R.id.ll_my_booking);
        llRecharge = view.findViewById(R.id.ll_recharge);
        llEquityCard = view.findViewById(R.id.ll_equity_card);
        llAddress = view.findViewById(R.id.ll_address);
        llCustomerService = view.findViewById(R.id.ll_customer_service);
        btnLogout = view.findViewById(R.id.btn_logout);

        // 优惠券入口
        llMyCoupon = view.findViewById(R.id.ll_my_coupon);
        llCoupon = view.findViewById(R.id.ll_coupon);
    }

    private void setListeners() {
        // 我的订单
        llMyOrders.setOnClickListener(v -> {
            Intent intent = new Intent(getActivity(), OrderListActivity.class);
            startActivity(intent);
        });

        // 我的会员
        llMyMembers.setOnClickListener(v -> {
            Intent intent = new Intent(getActivity(), MemberCenterActivity.class);
            startActivity(intent);
        });

        // 我的预约
        llMyBooking.setOnClickListener(v -> {
            Intent intent = new Intent(getActivity(), MyBookingActivity.class);
            startActivity(intent);
        });

        // 充值中心
        llRecharge.setOnClickListener(v -> {
            Intent intent = new Intent(getActivity(), RechargeActivity.class);
            startActivity(intent);
        });

        // 收货地址
        llAddress.setOnClickListener(v -> {
            Intent intent = new Intent(getActivity(), AddressListActivity.class);
            startActivity(intent);
        });

        // 客服中心
        llCustomerService.setOnClickListener(v -> {
            ToastUtils.showShort(getActivity(), "客服中心功能开发中...");
        });

        // ⭐ 我的券包（点击跳转）
        llMyCoupon.setOnClickListener(v -> {
            Intent intent = new Intent(getActivity(), MyCouponActivity.class);
            startActivity(intent);
        });

        // ⭐ 优惠券（点击跳转）
        llCoupon.setOnClickListener(v -> {
            Intent intent = new Intent(getActivity(), MyCouponActivity.class);
            startActivity(intent);
        });

        // ⭐ 权益卡（点击跳转 + 发放优惠券）
        llEquityCard.setOnClickListener(v -> {
            int userId = SharedPreferencesUtils.getUserId(requireContext());
            if (userId != -1) {
                try {
                    CouponDao dao = new CouponDao(requireContext());
                    dao.addCoupon(
                            userId,
                            "会员专享·满100减15",
                            Coupon.TYPE_FULL_REDUCE,
                            15.0,
                            100.0,
                            0,
                            "中级会员福利",
                            getCouponExpireTime(15)
                    );
                    ToastUtils.showShort(getContext(), "已领取会员优惠券！");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            Intent intent = new Intent(getActivity(), EquityCardActivity.class);
            startActivity(intent);
        });

        // 退出登录
        btnLogout.setOnClickListener(v -> {
            new AlertDialog.Builder(getActivity())
                    .setTitle("提示")
                    .setMessage("确定要退出登录吗？")
                    .setPositiveButton("确定", (dialog, which) -> {
                        SharedPreferencesUtils.clearLoginInfo(getActivity());
                        ToastUtils.showShort(getActivity(), "已退出登录");
                        startActivity(new Intent(getActivity(), LoginActivity.class));
                        requireActivity().finish();
                    })
                    .setNegativeButton("取消", null)
                    .show();
        });
    }

    private String getCouponExpireTime(int days) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.CHINA);
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, days);
        return sdf.format(calendar.getTime());
    }

    /**
     * ⭐ 加载用户信息（含优惠券数量）
     */
    private void loadUserInfo() {
        String username = SharedPreferencesUtils.getUsername(requireContext());
        String phone = SharedPreferencesUtils.getUserPhone(requireContext());

        if (username != null && !username.isEmpty()) {
            tvUsername.setText(username);
        } else {
            tvUsername.setText("宠物主人");
        }

        if (phone != null && !phone.isEmpty()) {
            String maskedPhone = phone.substring(0, 3) + "****" + phone.substring(7);
            tvPhone.setText(maskedPhone);
        }

        double balance = SharedPreferencesUtils.getBalance(requireContext());
        tvBalance.setText(String.format(Locale.CHINA, "¥%.2f", balance));

        // ⭐ 加载优惠券数量
        loadCouponCount();

        tvVipLevel.setText("VIP·初级会员");
        tvMemberLevel.setText("初级会员");
        tvPoints.setText("0");
    }

    /**
     * ⭐ 加载优惠券数量（未使用的）
     */
    private void loadCouponCount() {
        int userId = SharedPreferencesUtils.getUserId(requireContext());
        if (userId != -1 && tvCoupon != null && couponDao != null) {
            try {
                List<Coupon> coupons = couponDao.getCouponsByStatus(userId, Coupon.STATUS_UNUSED);
                int count = coupons != null ? coupons.size() : 0;
                tvCoupon.setText(String.valueOf(count));
            } catch (Exception e) {
                e.printStackTrace();
                tvCoupon.setText("0");
            }
        } else {
            if (tvCoupon != null) {
                tvCoupon.setText("0");
            }
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        loadUserInfo();
    }
}