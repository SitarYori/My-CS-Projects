package cn.itcast.petcare.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.activity.CheckoutActivity;
import cn.itcast.petcare.adapter.CartAdapter;
import cn.itcast.petcare.dao.CartDao;
import cn.itcast.petcare.model.CartItem;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;
import java.text.DecimalFormat;
import java.util.List;

public class CartFragment extends Fragment {

    private RecyclerView rvCart;
    private ImageView ivBack;  // ⭐ 新增
    private LinearLayout llEmptyCart, llCheckout;
    private TextView tvTotalPrice;
    private Button btnCheckout;

    private CartDao cartDao;
    private CartAdapter adapter;
    private List<CartItem> cartList;
    private DecimalFormat df = new DecimalFormat("0.00");

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_cart, container, false);

        initViews(view);
        setListeners();  // ⭐ 新增
        loadCartData();

        return view;
    }

    private void initViews(View view) {
        ivBack = view.findViewById(R.id.iv_back);  // ⭐ 返回键
        rvCart = view.findViewById(R.id.rv_cart);
        llEmptyCart = view.findViewById(R.id.ll_empty_cart);
        llCheckout = view.findViewById(R.id.ll_checkout);
        tvTotalPrice = view.findViewById(R.id.tv_total_price);
        btnCheckout = view.findViewById(R.id.btn_checkout);

        rvCart.setLayoutManager(new LinearLayoutManager(getContext()));

        cartDao = new CartDao(getContext());

        btnCheckout.setOnClickListener(v -> {
            Intent intent = new Intent(getContext(), CheckoutActivity.class);
            startActivity(intent);
        });
    }

    // ⭐：设置监听器
    private void setListeners() {
        // 返回箭头 → 关闭当前页面（返回上一页）
        ivBack.setOnClickListener(v -> {
            if (getActivity() != null) {
                getActivity().finish();
            }
        });
    }
    @Override
    public void onResume() {
        super.onResume();
        loadCartData();
    }

    //从数据库加载购物车商品
    private void loadCartData() {
        int userId = SharedPreferencesUtils.getUserId(getContext());
        if (userId == -1) {
            showEmptyCart();
            return;
        }

        cartList = cartDao.getCartItems(userId);

        if (cartList == null || cartList.isEmpty()) {
            showEmptyCart();
        } else {
            showCartList();
            updateTotalPrice();
        }
    }


    //显示空购物车状态
    private void showEmptyCart() {
        llEmptyCart.setVisibility(View.VISIBLE);
        rvCart.setVisibility(View.GONE);
        llCheckout.setVisibility(View.GONE);
    }

    //显示空购物车状态
    private void showCartList() {
        llEmptyCart.setVisibility(View.GONE);
        rvCart.setVisibility(View.VISIBLE);
        llCheckout.setVisibility(View.VISIBLE);

        adapter = new CartAdapter(cartList, new CartAdapter.OnCartItemListener() {
            @Override
            public void onQuantityChange(CartItem item, int newQuantity) {
                int userId = SharedPreferencesUtils.getUserId(getContext());
                cartDao.updateQuantity(item.getId(), newQuantity);
                updateTotalPrice();
            }

            @Override
            public void onDelete(CartItem item) {
                cartDao.deleteCartItem(item.getId());
                loadCartData();
                ToastUtils.showShort(getContext(), "已删除");
            }
        });
        rvCart.setAdapter(adapter);
    }

    //计算并更新合计金额
    private void updateTotalPrice() {
        int userId = SharedPreferencesUtils.getUserId(getContext());
        double total = cartDao.getCartTotal(userId);
        tvTotalPrice.setText("¥" + df.format(total));
    }
}