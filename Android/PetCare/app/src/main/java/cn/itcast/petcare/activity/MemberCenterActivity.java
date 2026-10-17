package cn.itcast.petcare.activity;

import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import cn.itcast.petcare.R;
import cn.itcast.petcare.utils.SharedPreferencesUtils;

public class MemberCenterActivity extends AppCompatActivity {

    private ImageView ivBack;
    private TextView tvProgressText, tvNextLevel;
    private View vProgress;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_center);

        initViews();
        setListeners();
        loadMemberInfo();
    }

    private void initViews() {
        ivBack = findViewById(R.id.iv_back);
        tvProgressText = findViewById(R.id.tv_progress_text);
        tvNextLevel = findViewById(R.id.tv_next_level);
        vProgress = findViewById(R.id.v_progress);
    }

    private void setListeners() {
        ivBack.setOnClickListener(v -> finish());
    }

    private void loadMemberInfo() {
        int points = SharedPreferencesUtils.getMemberPoints(this);

        int progress;
        int maxProgress;
        String nextLevel;

        if (points < 100) {
            progress = points;
            maxProgress = 100;
            nextLevel = "中级会员";
        } else if (points < 500) {
            progress = points - 100;
            maxProgress = 400;
            nextLevel = "高级会员";
        } else {
            progress = 100;
            maxProgress = 100;
            nextLevel = "已满级";
        }

        // ⭐ 使用 final 变量
        final int progressPercent = (int) ((float) progress / maxProgress * 100);
        final int finalProgress = progress > maxProgress ? maxProgress : progress;

        // 更新进度条
        vProgress.post(new Runnable() {
            @Override
            public void run() {
                View parent = (View) vProgress.getParent();
                if (parent != null) {
                    int parentWidth = parent.getWidth();
                    int targetWidth = parentWidth * progressPercent / 100;
                    if (targetWidth > parentWidth) {
                        targetWidth = parentWidth;
                    }
                    ViewGroup.LayoutParams params = vProgress.getLayoutParams();
                    params.width = targetWidth;
                    vProgress.setLayoutParams(params);
                }
            }
        });

        tvProgressText.setText(finalProgress + "/" + maxProgress);

        if (points >= 500) {
            tvNextLevel.setText("🎉 恭喜您已满级，享受最高会员权益！");
        } else {
            tvNextLevel.setText("升级到 " + nextLevel + " 还需 " + (maxProgress - finalProgress) + " 成长值");
        }
    }
}