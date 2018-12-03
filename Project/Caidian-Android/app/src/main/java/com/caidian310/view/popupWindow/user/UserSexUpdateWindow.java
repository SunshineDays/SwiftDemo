package com.caidian310.view.popupWindow.user;

import android.app.Activity;
import android.graphics.drawable.ColorDrawable;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.caidian310.R;
import com.caidian310.application.MyApplication;
import com.caidian310.utils.DensityUtil;
import com.caidian310.view.callBack.CallBack;


/**
 * description :
 * Created by wdb on 2017/4/25.
 */

public class UserSexUpdateWindow extends PopupWindow implements View.OnClickListener {

    private View view;
    private TextView manTxt, womenTxt, canCelTxt, onTxt;
    public CallBack callOpenBack, callCloseBack;
    public Activity activity;

    public void setOpenPressCallBack(CallBack callBack) {
        this.callOpenBack = callBack;
    }
    public void setClosePressCallBack(CallBack callBack) {
        this.callCloseBack = callBack;
    }


    /**
     * 修改性别提示框
     *
     * @param context
     */
    public UserSexUpdateWindow(Activity context) {
        super(context);
        this.activity = context;

        LayoutInflater inflater = (LayoutInflater) MyApplication.getInstance().getSystemService(MyApplication.getInstance().LAYOUT_INFLATER_SERVICE);
        view = inflater.inflate(R.layout.layout_user_sex_update, null);

        initView();

        this.setContentView(this.view);                              // 设置视图
        this.setFocusable(true);                                     // 设置弹出窗体可点击
        this.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);


        this.setHeight(LinearLayout.LayoutParams.WRAP_CONTENT);
        int widthDip = DensityUtil.getDisplayWidth(context) - DensityUtil.dip2px(context, 30);

        this.setWidth(widthDip);
        // 设置弹出窗体可点击
        this.setFocusable(true);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0x00000000);
        // 设置弹出窗体的背景
        this.setBackgroundDrawable(dw);
        this.setOutsideTouchable(false);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        this.setAnimationStyle(R.style.take_photo_anim);             // 设置弹出窗体显示时的动画，从底部向上弹出

        //背景变透明
        WindowManager.LayoutParams lp = context.getWindow().getAttributes();
        lp.alpha = 0.4f;
        context.getWindow().setAttributes(lp);

        this.setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss() {
                WindowManager.LayoutParams lp = (activity).getWindow().getAttributes();
                lp.alpha = 1f;
                (activity).getWindow().setAttributes(lp);
            }
        });

    }

    private void initView() {

        canCelTxt =  view.findViewById(R.id.update_sex_cancel);
        manTxt =  view.findViewById(R.id.update_sex_nan);
        womenTxt =  view.findViewById(R.id.update_sex_women);
        onTxt =  view.findViewById(R.id.update_sex_no);

        canCelTxt.setOnClickListener(this);
        manTxt.setOnClickListener(this);
        womenTxt.setOnClickListener(this);
        onTxt.setOnClickListener(this);
    }

    /**
     * 显示popupWindow
     *
     * @param parent
     */
    public void showPopupWindow(View parent) {
        if (!this.isShowing()) {
            // 以下拉方式显示popupwindow
            this.showAtLocation(parent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        } else {
            this.dismiss();
        }
    }


    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.update_sex_nan:
                this.dismiss();
                //男
                requestUserNameUpdate("1", null);
                this.dismiss();
                break;
            case R.id.update_sex_no:
                //保密
                requestUserNameUpdate("0", null);
                this.dismiss();
                break;
            case R.id.update_sex_women:
                //女
                requestUserNameUpdate("2", null);
                this.dismiss();
                break;
            case R.id.update_sex_cancel:
                this.dismiss();
                break;
        }
    }


    // 修改用户名网络请求
    public void requestUserNameUpdate(String sex, String name) {
        callOpenBack.onClickListener();
//        new HttpUtil().requestUserInfoPassword(MyApplication.getInstance(),sex, name, new ResponseObject() {
//            @Override
//            public void onSuccess(Object object) {
//                // 修改数据库数据 进行回调
//                UserBean user = (UserBean) object;
//                UserBean userBean = new DbUtil().getUserBean();
//                userBean.setGender(user.getGender());
//                new DbUtil().setUserBean(userBean);
//                new BaseActivity().showToast("性别修改成功");
//                EventBus.getDefault().post(new MessageEvent("login"));
//
//                callCloseBack.onClickListener();
//            }
//
//            @Override
//            public void onFailure(HttpError httpError) {
//                new BaseActivity().showToast(httpError.getMessage());
//                callCloseBack.onClickListener();
//            }
//        });

    }


}
