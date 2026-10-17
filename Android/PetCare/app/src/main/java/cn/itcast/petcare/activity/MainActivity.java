package cn.itcast.petcare.activity;

import android.os.Bundle;
import android.view.MenuItem;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTransaction;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import cn.itcast.petcare.R;
import cn.itcast.petcare.fragment.HomeFragment;
import cn.itcast.petcare.fragment.OrderFragment;
import cn.itcast.petcare.fragment.ProductFragment;
import cn.itcast.petcare.fragment.ProfileFragment;
import cn.itcast.petcare.fragment.CartFragment;

public class MainActivity extends AppCompatActivity {

    private BottomNavigationView bottomNav;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        try {
            setContentView(R.layout.activity_main);
        } catch (Exception e) {
            e.printStackTrace();
            // 如果布局加载失败，打印错误
            android.widget.Toast.makeText(this, "布局加载失败：" + e.getMessage(), android.widget.Toast.LENGTH_LONG).show();
            return;
        }

        initViews();
        setupBottomNav();

        // ⭐ 从商品详情页跳转过来时切换到购物车
        // ⭐ 检查是否从详情页跳转过来
        String targetTab = getIntent().getStringExtra("target_tab");

        // ⭐ 如果是从详情页跳转过来的，直接切换到购物车
        if ("cart".equals(targetTab)) {
            // 延迟切换，确保界面已加载
            bottomNav.postDelayed(() -> {
                // 加载购物车Fragment
                getSupportFragmentManager()
                        .beginTransaction()
                        .replace(R.id.fragment_container, new CartFragment())
                        .commit();
                // 取消所有底部导航的高亮
                clearBottomNavSelection();
            }, 100);
        }
    }

    private void initViews() {
        try {
            bottomNav = findViewById(R.id.bottom_nav);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void setupBottomNav() {
        try {
            // 默认加载首页
            getSupportFragmentManager()
                    .beginTransaction()
                    .replace(R.id.fragment_container, new HomeFragment())
                    .commit();
            bottomNav.setSelectedItemId(R.id.nav_home);

            bottomNav.setOnItemSelectedListener(new BottomNavigationView.OnItemSelectedListener() {
                @Override
                public boolean onNavigationItemSelected(@NonNull MenuItem item) {
                    Fragment fragment = null;

                    int id = item.getItemId();
                    if (id == R.id.nav_home) {
                        fragment = new HomeFragment();
                    } else if (id == R.id.nav_product) {
                        fragment = new ProductFragment();
                    } else if (id == R.id.nav_order) {
                        fragment = new OrderFragment();
                    } else if (id == R.id.nav_profile) {
                        fragment = new ProfileFragment();
                    }

                    if (fragment != null) {
                        try {
                            getSupportFragmentManager()
                                    .beginTransaction()
                                    .replace(R.id.fragment_container, fragment)
                                    .commit();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        return true;
                    }
                    return false;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 取消底部导航所有Tab的高亮
     */
    private void clearBottomNavSelection() {
        try {
            bottomNav.getMenu().setGroupCheckable(0, false, true);
            for (int i = 0; i < bottomNav.getMenu().size(); i++) {
                bottomNav.getMenu().getItem(i).setChecked(false);
            }
            bottomNav.getMenu().setGroupCheckable(0, true, true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 切换到商品Tab
     */

    public void switchToProductTab() {
        try {
            bottomNav.setSelectedItemId(R.id.nav_product);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * ⭐ 切换到购物车页面（独立页面，不选中底部导航）
     */
    public void switchToCartTab() {
        try {
            getSupportFragmentManager()
                    .beginTransaction()
                    .replace(R.id.fragment_container, new CartFragment())
                    .commit();
            clearBottomNavSelection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}