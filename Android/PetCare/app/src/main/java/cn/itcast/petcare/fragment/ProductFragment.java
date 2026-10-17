package cn.itcast.petcare.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.GridLayout;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.Fragment;
import cn.itcast.petcare.R;
import cn.itcast.petcare.activity.MainActivity;
import cn.itcast.petcare.activity.ProductDetailActivity;
import cn.itcast.petcare.dao.CartDao;
import cn.itcast.petcare.dialog.ProductSpecDialog;
import cn.itcast.petcare.utils.SharedPreferencesUtils;
import cn.itcast.petcare.utils.ToastUtils;

public class ProductFragment extends Fragment {

    private TextView tvCategoryTitle;
    private GridLayout glProducts;
    private TextView tvTabSignature, tvTabCatFood, tvTabDogFood, tvTabCatSnack, tvTabDogSnack, tvTabFeatured;

    private FrameLayout flCartFloat;
    private TextView tvFloatCartCount;
    private CartDao cartDao;

    private final String[] categoryNames = {"🏆 招牌", "😺 猫粮", "🐶 狗粮", "🐱 猫零食", "🐕 狗零食", "✨ 精选"};

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_product, container, false);

        cartDao = new CartDao(requireContext());

        initViews(view);
        setupCategoryTabs();
        selectCategory(0);
        setupCartFloat(view);
        updateCartBadge();

        return view;
    }

    private void initViews(View view) {
        tvCategoryTitle = view.findViewById(R.id.tv_category_title);
        glProducts = view.findViewById(R.id.gl_products);

        tvTabSignature = view.findViewById(R.id.tv_tab_signature);
        tvTabCatFood = view.findViewById(R.id.tv_tab_cat_food);
        tvTabDogFood = view.findViewById(R.id.tv_tab_dog_food);
        tvTabCatSnack = view.findViewById(R.id.tv_tab_cat_snack);
        tvTabDogSnack = view.findViewById(R.id.tv_tab_dog_snack);
        tvTabFeatured = view.findViewById(R.id.tv_tab_featured);

        flCartFloat = view.findViewById(R.id.fl_cart_float);
        tvFloatCartCount = view.findViewById(R.id.tv_float_cart_count);
    }

    private void setupCategoryTabs() {
        View.OnClickListener listener = v -> {
            int id = v.getId();
            if (id == R.id.tv_tab_signature) {
                selectCategory(0);
            } else if (id == R.id.tv_tab_cat_food) {
                selectCategory(1);
            } else if (id == R.id.tv_tab_dog_food) {
                selectCategory(2);
            } else if (id == R.id.tv_tab_cat_snack) {
                selectCategory(3);
            } else if (id == R.id.tv_tab_dog_snack) {
                selectCategory(4);
            } else if (id == R.id.tv_tab_featured) {
                selectCategory(5);
            }
        };

        tvTabSignature.setOnClickListener(listener);
        tvTabCatFood.setOnClickListener(listener);
        tvTabDogFood.setOnClickListener(listener);
        tvTabCatSnack.setOnClickListener(listener);
        tvTabDogSnack.setOnClickListener(listener);
        tvTabFeatured.setOnClickListener(listener);
    }

    private void selectCategory(int position) {
        resetAllTabs();

        TextView selectedTab = null;
        switch (position) {
            case 0:
                selectedTab = tvTabSignature;
                break;
            case 1:
                selectedTab = tvTabCatFood;
                break;
            case 2:
                selectedTab = tvTabDogFood;
                break;
            case 3:
                selectedTab = tvTabCatSnack;
                break;
            case 4:
                selectedTab = tvTabDogSnack;
                break;
            case 5:
                selectedTab = tvTabFeatured;
                break;
            default:
                break;
        }

        if (selectedTab != null) {
            selectedTab.setTextColor(ContextCompat.getColor(requireContext(), android.R.color.holo_blue_dark));
            selectedTab.setBackgroundResource(R.drawable.bg_category_selected);
        }

        tvCategoryTitle.setText(categoryNames[position]);
        updateProducts(position);
    }

    private void resetAllTabs() {
        TextView[] tabs = {tvTabSignature, tvTabCatFood, tvTabDogFood,
                tvTabCatSnack, tvTabDogSnack, tvTabFeatured};
        for (TextView tab : tabs) {
            if (tab != null) {
                tab.setTextColor(ContextCompat.getColor(requireContext(), android.R.color.darker_gray));
                tab.setBackgroundResource(R.drawable.bg_category_normal);
            }
        }
    }

    private void updateProducts(int position) {
        glProducts.removeAllViews();

        String[] names = getProductNames(position);
        String[] descs = getProductDescs(position);
        String[] prices = getProductPrices(position);
        String[] originalPrices = getOriginalPrices(position);
        int[] images = getProductImages(position);  // ⭐ 获取图片

        LayoutInflater inflater = LayoutInflater.from(getContext());

        for (int i = 0; i < names.length; i++) {
            final int index = i;

            View itemView = inflater.inflate(R.layout.item_product, glProducts, false);

            ImageView ivImage = itemView.findViewById(R.id.iv_product_image);
            TextView tvName = itemView.findViewById(R.id.tv_product_name);
            TextView tvDesc = itemView.findViewById(R.id.tv_product_desc);
            TextView tvPrice = itemView.findViewById(R.id.tv_price);
            TextView tvOriginalPrice = itemView.findViewById(R.id.tv_original_price);
            TextView tvSales = itemView.findViewById(R.id.tv_sales);
            TextView tvTags = itemView.findViewById(R.id.tv_product_tags);
            TextView tvSpec = itemView.findViewById(R.id.btn_spec);

            // ⭐ 设置商品图片
            if (images != null && i < images.length) {
                ivImage.setImageResource(images[i]);
            } else {
                ivImage.setImageResource(R.drawable.banner1);
            }

            tvName.setText(names[index]);
            tvDesc.setText(descs[index]);
            tvPrice.setText("¥" + prices[index]);

            if (originalPrices != null && index < originalPrices.length
                    && originalPrices[index] != null && !originalPrices[index].isEmpty()) {
                tvOriginalPrice.setVisibility(View.VISIBLE);
                tvOriginalPrice.setText("¥" + originalPrices[index]);
            } else {
                tvOriginalPrice.setVisibility(View.GONE);
            }

            tvSales.setText("销量" + (int)(Math.random() * 100));

            String[] tagList = {"免疫加持", "高效吸收", "科学营养", "温润清爽", "0胶质", "0诱食"};
            if (Math.random() > 0.5) {
                tvTags.setVisibility(View.VISIBLE);
                tvTags.setText(tagList[(int)(Math.random() * tagList.length)]);
            } else {
                tvTags.setVisibility(View.GONE);
            }

            final String productName = names[index];
            final String productDesc = descs[index];
            final String productPrice = prices[index];
            final int productImage = (images != null && i < images.length) ? images[i] : R.drawable.banner1;

            // 商品卡片点击 → 跳转详情页
            itemView.setOnClickListener(v -> {
                Intent intent = new Intent(getContext(), ProductDetailActivity.class);
                intent.putExtra("product_name", productName);
                intent.putExtra("product_desc", productDesc);
                intent.putExtra("product_price", productPrice);
                if (originalPrices != null && index < originalPrices.length
                        && originalPrices[index] != null && !originalPrices[index].isEmpty()) {
                    intent.putExtra("product_original_price", originalPrices[index]);
                }
                intent.putExtra("product_sales", String.valueOf((int)(Math.random() * 100)));
                intent.putExtra("product_image", productImage);  // ⭐ 传递图片
                startActivity(intent);
            });

            // 商品详情页选规格按钮点击
            tvSpec.setOnClickListener(v -> {
                try {
                    String name = names[index];
                    String desc = descs[index];
                    String price = prices[index];
                    int image = (images != null && index < images.length) ? images[index] : R.drawable.banner1;  // ⭐ 获取图片

                    ProductSpecDialog dialog = new ProductSpecDialog(
                            requireContext(),
                            name,
                            desc,
                            price,
                            image  // ⭐ 传入图片
                    );

                    dialog.setOnConfirmListener((flavor, weight, quantity) -> {
                        int userId = SharedPreferencesUtils.getUserId(requireContext());
                        if (userId == -1) {
                            ToastUtils.showShort(getContext(), "请先登录");
                            return;
                        }

                        String fullName = productName + "（" + flavor + " / " + weight + "）";
                        String fullDesc = productDesc + " | " + flavor + " | " + weight;

                        CartDao cartDaoLocal = new CartDao(requireContext());
                        double priceValue = Double.parseDouble(productPrice);

                        for (int j = 0; j < quantity; j++) {
                            cartDaoLocal.addToCart(
                                    userId,
                                    fullName,
                                    fullDesc,
                                    priceValue,
                                    0,
                                    R.drawable.banner1
                            );
                        }

                        ToastUtils.showShort(getContext(), "已加入购物车 " + quantity + " 件");
                        updateCartBadge();
                    });

                    dialog.show();
                } catch (Exception e) {
                    ToastUtils.showShort(getContext(), "打开规格选择失败");
                }
            });

            GridLayout.LayoutParams params = new GridLayout.LayoutParams();
            params.width = 0;
            params.height = GridLayout.LayoutParams.WRAP_CONTENT;
            params.columnSpec = GridLayout.spec(GridLayout.UNDEFINED, 1f);
            params.setMargins(0, 0, 0, 0);
            itemView.setLayoutParams(params);

            glProducts.addView(itemView);
        }
    }

    /**
     * ⭐ 获取商品图片
     */
    private int[] getProductImages(int position) {
        switch (position) {
            case 0: // 招牌
                return new int[]{
                        R.drawable.product_cat_food,
                        R.drawable.product_dog_food,
                        R.drawable.product_cat_food,
                        R.drawable.product_cat_food,
                        R.drawable.product_cat_snack
                };
            case 1: // 猫粮
                return new int[]{
                        R.drawable.product_cat_food,
                        R.drawable.product_cat_food,
                        R.drawable.product_cat_food,
                        R.drawable.product_cat_food
                };
            case 2: // 狗粮
                return new int[]{
                        R.drawable.product_dog_food,
                        R.drawable.product_dog_food,
                        R.drawable.product_dog_food
                };
            case 3: // 猫零食
                return new int[]{
                        R.drawable.product_cat_snack,
                        R.drawable.product_cat_snack,
                        R.drawable.product_cat_snack,
                        R.drawable.product_cat_snack
                };
            case 4: // 狗零食
                return new int[]{
                        R.drawable.product_dog_snack,
                        R.drawable.product_dog_snack,
                        R.drawable.product_dog_snack
                };
            default: // 精选
                return new int[]{
                        R.drawable.product_cat_food,
                        R.drawable.product_cat_food,
                        R.drawable.product_cat_snack,
                        R.drawable.banner1
                };
        }
    }

    // 悬浮购物车
    private void setupCartFloat(View view) {
        if (flCartFloat != null) {
            flCartFloat.setOnClickListener(v -> {
                if (getActivity() instanceof MainActivity) {
                    ((MainActivity) getActivity()).switchToCartTab();
                }
            });
        }
    }

    private void updateCartBadge() {
        int userId = SharedPreferencesUtils.getUserId(requireContext());
        if (userId != -1 && cartDao != null) {
            int count = cartDao.getCartCount(userId);
            if (count > 0 && tvFloatCartCount != null) {
                tvFloatCartCount.setVisibility(View.VISIBLE);
                tvFloatCartCount.setText(String.valueOf(count));
            } else if (tvFloatCartCount != null) {
                tvFloatCartCount.setVisibility(View.GONE);
            }
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        updateCartBadge();
    }

    // ========== 商品数据 ==========

    private String[] getProductNames(int position) {
        switch (position) {
            case 0:
                return new String[]{
                        "鲜朗烘焙全期全价猫粮2...",
                        "纯福全价全期小型犬犬...",
                        "纯福全价全期猫粮1.5kg...",
                        "纯福全价酶解幼猫粮1kg",
                        "萌宠出动液态猫饭50克"
                };
            case 1:
                return new String[]{
                        "鲜朗烘焙全期全价猫粮2...",
                        "纯福全价全期猫粮1.5kg...",
                        "纯福全价酶解幼猫粮1kg",
                        "渴望六种鱼全期猫粮1.8kg"
                };
            case 2:
                return new String[]{
                        "纯福全价全期小型犬犬...",
                        "伯纳天纯小型犬全价粮...",
                        "比乐全价全期狗粮1.5kg"
                };
            case 3:
                return new String[]{
                        "萌宠出动液态猫饭50克",
                        "猫条金枪鱼味 12g*10",
                        "冻干鸡胸肉 50g",
                        "猫罐头金枪鱼 85g"
                };
            case 4:
                return new String[]{
                        "狗狗磨牙棒 大号*5",
                        "冻干牛肉 50g",
                        "狗罐头鸡肉味 100g"
                };
            default:
                return new String[]{
                        "鲜朗烘焙全期全价猫粮2...",
                        "纯福全价全期猫粮1.5kg...",
                        "萌宠出动液态猫饭50克",
                        "优质猫砂 2.5kg"
                };
        }
    }

    private String[] getProductDescs(int position) {
        switch (position) {
            case 0:
                return new String[]{
                        "61%鲜鸡肉+20%鲜骨鸡肉",
                        "夏日的脚步走近和纯福一起...",
                        "自研鲜肉酶解工艺提高营养...",
                        "选纯福幼猫粮的理由[一R]重...",
                        "精致严选优质肉源mini..."
                };
            case 1:
                return new String[]{
                        "61%鲜鸡肉+20%鲜骨鸡肉",
                        "自研鲜肉酶解工艺提高营养...",
                        "免疫加持 高效吸收",
                        "六种深海鱼 营养全面"
                };
            case 2:
                return new String[]{
                        "夏日的脚步走近和纯福一起...",
                        "天然食材 营养均衡",
                        "高蛋白 低脂肪"
                };
            case 3:
                return new String[]{
                        "0胶质0诱食0防腐",
                        "新鲜金枪鱼 猫咪最爱",
                        "纯肉冻干 营养丰富",
                        "优质肉源 汤汁浓郁"
                };
            case 4:
                return new String[]{
                        "坚固牙齿 清洁口腔",
                        "纯牛肉制作 高蛋白",
                        "鸡肉味 狗狗爱吃"
                };
            default:
                return new String[]{
                        "61%鲜鸡肉+20%鲜骨鸡肉",
                        "自研鲜肉酶解工艺提高营养...",
                        "0胶质0诱食0防腐",
                        "高效吸水 结团牢固"
                };
        }
    }

    private String[] getProductPrices(int position) {
        switch (position) {
            case 0:
                return new String[]{"168", "72", "96", "70", "3"};
            case 1:
                return new String[]{"168", "96", "70", "89"};
            case 2:
                return new String[]{"72", "58", "65"};
            case 3:
                return new String[]{"3", "5", "8", "6"};
            case 4:
                return new String[]{"12", "8", "6"};
            default:
                return new String[]{"168", "96", "3", "15"};
        }
    }

    private String[] getOriginalPrices(int position) {
        switch (position) {
            case 0:
                return new String[]{"", "", "", "99", ""};
            default:
                return new String[]{"", "", "", ""};
        }
    }

}