package com.caidian310.presenter

import android.graphics.Color
import android.text.Editable
import android.text.Html
import android.text.Spanned
import android.text.TextWatcher
import android.widget.EditText
import com.caidian310.R
import com.caidian310.application.MyApplication
import com.caidian310.utils.ColorUtil

object TextPresenter {


    /**
     * 限制EditView的输入位数限制
     * @param number    限制的小数位数 默认2
     */
    fun setEditViewDecimalNumber(number: Int = 2, editText: EditText) = object : TextWatcher {
        override fun afterTextChanged(s: Editable?) {}

        override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

        override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {

            var content = s
            if (content.toString().contains(".")) {
                if (content!!.length - 1 - content.toString().indexOf(".") > number) {
                    content = content.toString().subSequence(0, s.toString().indexOf(".") + number + 1)
                    editText.setText(content)
                    editText.setSelection(content.length)
                }
            }
            if (content.toString().trim().substring(0) == ".") {
                content = "0$content"
                editText.setText(content)
                editText.setSelection(2)
            }
            if (content.toString().startsWith("0") && content.toString().trim().length > 1) {
                if (content.toString().substring(1, 2) != ".") {
                    editText.setText(content!!.subSequence(0, 1))
                    editText.setSelection(1)
                    return
                }
            }
        }

    }

    /**
     * 投注倍数限制
     */
    fun setEditCount(editText: EditText,bigCount:Int= MyApplication.maxMultiple,onChange:()->Unit)= object : TextWatcher {
        override fun afterTextChanged(s: Editable?) {}

        override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

        override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {

            if (s.isNullOrEmpty()) {
                onChange()
                return
            }

            if (s.toString().toDouble() == 0.0) {
                editText.setText("1")
                editText.setSelection("1".length)
                onChange()
                return
            }
            if (s.toString().toDouble() > bigCount) {
                editText.setText(bigCount.toString())
                editText.setSelection(bigCount.toString().length)
                onChange()
                return
            }

            onChange()
        }

    }


    /**
     * 对Color.parseColor(item.color)赋值前进行检测
     *
     */
    fun parseColor(color:String ?=null) =
            try {
                Color.parseColor(color)
            }catch (e:Exception){
                ColorUtil.getColor(R.color.colorPrimaryDark)
            }



    /**
     * 对网络渲染  统一入口
     */
    fun html(content:String) : Spanned {
        return if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            Html.fromHtml(content, Html.FROM_HTML_MODE_LEGACY)
        } else {
            Html.fromHtml(content)
        }
    }
}