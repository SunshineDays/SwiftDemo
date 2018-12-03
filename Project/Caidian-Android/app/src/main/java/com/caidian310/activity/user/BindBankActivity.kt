package com.caidian310.activity.user

import android.graphics.Color
import android.os.Bundle
import android.view.View
import com.bigkoo.pickerview.OptionsPickerView
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.bean.user.CityBean
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.CityUtil
import com.caidian310.utils.DbUtil
import com.caidian310.utils.ToastUtil
import kotlinx.android.synthetic.main.activity_user_bind_bank.*

class BindBankActivity : BaseActivity() {

    private var cityUtil: CityUtil? = null

    private var provinceIndex = 0       //省的打开位置
    private var cityIndex = 0           //市打开位置
    private var bankIndex = 0           //银行选择器的打开位置

    private var bankId = -1              //银行卡号Id
    private var provinceId = -1          //省对应的Id
    private var cityId = -1              //市对应的Id

    private var bankList: ArrayList<CityBean> = ArrayList()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_bind_bank)

        initActionBar(centerTitle = "绑定银行卡")

        initEvent()

        initListener()
    }


    override fun initEvent() {
        super.initEvent()
        cityUtil = CityUtil()


    }

    override fun initListener() {
        super.initListener()

        /**
         * 显示的银行列表
         */
        requestBankList()



        bind_city.setOnClickListener { showAddressPickerView() }
        bind_bank.setOnClickListener { showBankPickerView() }
        bind_sure.setOnClickListener { requestBindBank() }
    }

    /**
     * 已绑定银行卡的UI
     */
    private fun bindOverBankUI() {
        bind_sure.text = "已 绑 定"
        bind_name.isEnabled = false
        bind_sure.isEnabled = false
        bind_bank.isEnabled = false
        bind_city.isEnabled = false
        bind_bank_card.isEnabled = false
        bind_bank_branch.isEnabled = false
        bind_bank_card_two_linear.visibility = View.GONE

    }

    /**
     * 未绑定银行卡显示信息
     */

    private fun bindNotBankUI() {
        bind_sure.text = "绑   定"
        bind_name.isEnabled = true
        bind_sure.isEnabled = true
        bind_bank.isEnabled = true
        bind_city.isEnabled = true
        bind_bank_card.isEnabled = true
        bind_bank_branch.isEnabled = true
        bind_bank_card_two_linear.visibility = View.VISIBLE
    }


    /**
     * 已绑定银行卡的基本信息
     */
    private fun requestBindBankDetail() {
        UserPresenter.requestRealDetail(
                context = this,
                onSuccess = {

                    provinceId = it.bankProvince
                    cityId  = it.bankCity
                    bankId = it.bankId

                    bind_bank_card.setText(it.bankCode)
                    bind_bank_branch.setText(it.bankBranch)
                    val city = cityUtil!!.getProvinceNameFromId(it.bankProvince) + "    " + cityUtil!!.getCityNameFromId(it.bankCity)
                    bind_city.text = city
                    val item = it
                    bind_bank.text = if (bankList.any { it.id == item.bankId }) bankList.first { it.id == item.bankId }.name else ""
                    bind_name.setText(item.realName)


                    //更新用户信息
                    val bean = DbUtil().getUserBean()
                    bean.isBindBank = 1
                    DbUtil().setUserBean(bean)

                }
        )
    }

    /**
     * 银行列表网络请求
     */
    private fun requestBankList() {
        UserPresenter.requestBankList(
                context = this,
                onSuccess = {
                    bankList.addAll(it)

                    /**
                     * 是否已绑定
                     */
                    if (DbUtil().getUserBean().isBindBank == 1) {
                        requestBindBankDetail()
                        bindOverBankUI()
                    } else {
                        bindNotBankUI()
                    }

                },
                onFailure = {

                }
        )
    }


    /**
     * 绑定银行卡
     */

    private fun requestBindBank() {

        val card = bind_bank_card.text.toString()

        if (card.isNullOrEmpty()) {
            ToastUtil.showToast("请输入正确的银行卡号")
            return
        }
        if (card != bind_bank_card_two.text.toString()) {
            ToastUtil.showToast("两次输入不一样,请重新输入")
            return
        }
        UserPresenter.requestBindBank(
                context = this,
                backCode = bind_bank_card.text.toString(),
                bankBranch = bind_bank_branch.text.toString(),
                bankCityId = cityId,
                bankProvinceId = provinceId,
                bankId = bankId,
                onSuccess = {

                    val userBean = DbUtil().getUserBean()
                    userBean.isBindBank = 1
                    DbUtil().setUserBean(userBean)

                    bindOverBankUI()

                }

        )
    }


    /**
     * 地区选择器
     */

    private fun showAddressPickerView() {


        val pickerView = OptionsPickerView.Builder(this,
                OptionsPickerView.OnOptionsSelectListener { options1, options2, _, _ ->
                    provinceIndex = options1
                    cityIndex = options2
                    val str = cityUtil!!.provinceList[options1].pickerViewText + "   " + cityUtil!!.provinceOptionsItemsList[options1][options2]

                    bind_city.text = str

                    provinceId = cityUtil!!.provinceList[options1].id
                    cityId = cityUtil!!.provinceOptionsItemsBeanList[options1][options2].id
                })
                .setTitleText("城市选择")
                .setTextColorCenter(Color.BLACK)
                .setContentTextSize(20)
                .setDividerColor(Color.BLACK)
                .build()

        pickerView.setSelectOptions(provinceIndex, cityIndex)

        pickerView.setPicker(cityUtil!!.provinceList, cityUtil!!.provinceOptionsItemsList)
        pickerView.show()

    }

    /**
     * 银行选择器
     *
     */

    private fun showBankPickerView() {

        val bankPicker = OptionsPickerView.Builder(this,
                OptionsPickerView.OnOptionsSelectListener { options1, _, _, _ ->
                    bankIndex = options1
                    bankId = bankList[options1].id
                    bind_bank.text = bankList[options1].pickerViewText
                })
                .setTitleText("选择银行")
                .setTextColorCenter(Color.BLACK)
                .setContentTextSize(20)
                .setDividerColor(Color.BLACK)
                .build()

        bankPicker.setSelectOptions(bankIndex)

        bankPicker.setPicker(bankList)
        bankPicker.show()
    }
}
