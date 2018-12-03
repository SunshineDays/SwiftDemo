package com.caidian310.bean.new

import com.google.gson.annotations.SerializedName
import java.io.Serializable

/**
 * Created by mac on 2018/2/3.
 */

data class NewsDetailBean(
        @SerializedName("topic_list") var topicList : ArrayList<NewsItem>,
        @SerializedName("notice_list") var noticeList : ArrayList<NewsItem>,
        @SerializedName("lottery_sale") var lotterySale : LotteryBean,
        @SerializedName("new_bonus_list") var newBonusList: ArrayList<NewsBonusItem>
):Serializable

/**
 * 中奖通报
 */
data class NewsBonusItem(
        @SerializedName("user_id") var userId :Int,
        @SerializedName("nickname")  var nickName :String,
        var bonus :Double ,
        @SerializedName("lottery_name") var lotteryName :String
)

data class NewsItem(
        var id :Int,
        var title:String,
        var url :String,
        var sort :Int,
        var img :String,
        var timeString:String,
        var content :String,
        @SerializedName("is_show") var isShow:Int,
        @SerializedName("admin_name") var adminName:String,
        @SerializedName("create_time") var createTime:Long
):Serializable

data class LotteryBean(
        var home:ArrayList<LotteryDetailBean>,
        var sport:ArrayList<LotteryDetailBean>,
        var numeric:ArrayList<LotteryDetailBean>,
        var quick:ArrayList<LotteryDetailBean>
):Serializable

data class LotteryDetailBean(
        var id:Int,
        @SerializedName("lottery_id") var lotteryId:Int,           //彩种id
        @SerializedName("lottery_name") var lotteryName:String,    //彩种name
        @SerializedName("lottery_type") var lotteryType:String,    //彩种类型
        @SerializedName("is_sale") var isSale:Int,                 //是否开售  1:开售 0:停售
        var description:String,
        var  sort :Int,
        @SerializedName("update_time") var updateTime:Long,
        @SerializedName("create_time") var createTime:Long,                //创建时间
        @SerializedName("bet_match_count")  var betMatchCount :Int =0      //可投注场次


):Serializable