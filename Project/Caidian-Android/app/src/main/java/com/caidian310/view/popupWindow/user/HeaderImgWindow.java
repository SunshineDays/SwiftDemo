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

public class HeaderImgWindow extends PopupWindow implements View.OnClickListener {

    private View view;
    private TextView cameraTxt, albumTxt, canCelTxt;
    public CallBack callBack,callAlbumBack;

    public void setBack(CallBack callBack){
        this.callBack = callBack;
    }

    public void setAlbumBack(CallBack callBack){
        this.callAlbumBack = callBack;
    }

    /**
     * 拍照或者相册选择提示框
     *
     * @param context
     */
    public HeaderImgWindow(final Activity context) {
        super(context);

        LayoutInflater inflater = (LayoutInflater) MyApplication.getInstance().getSystemService(MyApplication.getInstance().LAYOUT_INFLATER_SERVICE);
        view = inflater.inflate(R.layout.layout_header_img, null);

        initView();

        this.setContentView(this.view);                              // 设置视图
        this.setFocusable(false);                                     // 设置弹出窗体可点击

        this.setHeight(LinearLayout.LayoutParams.WRAP_CONTENT);
        int widthDip = DensityUtil.getDisplayWidth(context) - DensityUtil.dip2px(context, 30);

        this.setWidth(widthDip);
        // 设置弹出窗体可点击
        this.setFocusable(true);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0x00000000);
        // 设置弹出窗体的背景
        this.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        this.setAnimationStyle(R.style.take_photo_anim);             // 设置弹出窗体显示时的动画，从底部向上弹出


        //背景变透明
        WindowManager.LayoutParams lp = context.getWindow().getAttributes();
        lp.alpha = 0.4f;
        context.getWindow().setAttributes(lp);

        this.setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss() {
                WindowManager.LayoutParams lp = (context).getWindow().getAttributes();
                lp.alpha = 1f;
                (context).getWindow().setAttributes(lp);
            }
        });

    }

    private void initView() {

        canCelTxt =  view.findViewById(R.id.header_img_cancel);
        cameraTxt =  view.findViewById(R.id.header_img_camera);
        albumTxt =  view.findViewById(R.id.header_img_album);

        canCelTxt.setOnClickListener(this);
        cameraTxt.setOnClickListener(this);
        albumTxt.setOnClickListener(this);
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
            case R.id.header_img_camera:
                this.dismiss();
                //调用系统相机
                callBack.onClickListener();
                this.dismiss();
                break;
            case R.id.header_img_album:
                //调用相册
                callAlbumBack.onClickListener();
                this.dismiss();
                break;
            case R.id.header_img_cancel:
                this.dismiss();
                break;
        }
    }


}
