package com.caidian310.utils


import android.app.Activity
import android.webkit.WebChromeClient
import android.webkit.WebView
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.google.gson.Gson
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import java.util.ArrayList
import kotlin.collections.LinkedHashMap
import kotlin.collections.component1
import kotlin.collections.component2


/**
 * @param type 玩法
 * @param typeHighCount 该玩法支持的最高的单串数
 */
enum class BetType(val type: String, val typeHighCount: Int) {
    BQC(type = "半全场", typeHighCount = 4),
    JCS(type = "进球数", typeHighCount = 6),
    BF(type = "比分", typeHighCount = 4),
    SPF(type = "胜平负", typeHighCount = 8),
    RQSPF(type = "让球胜平负", typeHighCount = 8),

}


/**
 *
 * 计算投注中左右可能存在情况
 * 算法概述 合并
 * Created by mac on 2017/11/27.
 */
class BetUtil {

    /**
     * 半全场 key集合
     */
    val bqcTypeName = arrayListOf(
            "bqc_sp00",
            "bqc_sp01",
            "bqc_sp03",
            "bqc_sp10",
            "bqc_sp11",
            "bqc_sp13",
            "bqc_sp30",
            "bqc_sp31",
            "bqc_sp33")

    /**
     * 比分 key集合
     */
    val bfTypeName = arrayListOf(
            "bf_sp00",
            "bf_sp01",
            "bf_sp02",
            "bf_sp03",
            "bf_sp04",
            "bf_sp05",
            "bf_sp10",
            "bf_sp11",
            "bf_sp12",
            "bf_sp13",
            "bf_sp14",
            "bf_sp14",
            "bf_sp20",
            "bf_sp21",
            "bf_sp22",
            "bf_sp23",
            "bf_sp24",
            "bf_sp25",
            "bf_sp30",
            "bf_sp31",
            "bf_sp31",
            "bf_sp33",
            "bf_sp40",
            "bf_sp41",
            "bf_sp42",
            "bf_sp50",
            "bf_sp51",
            "bf_sp52",
            "bf_spA0",
            "bf_spA1",
            "bf_spA3")

    /**
     * 进球数 key集合
     */
    val jqsTypeName = arrayListOf(
            "jqs_sp0",
            "jqs_sp1",
            "jqs_sp2",
            "jqs_sp3",
            "jqs_sp4",
            "jqs_sp5",
            "jqs_sp6",
            "jqs_sp7")

    /**
     * 胜平负||让球胜平负 key集合
     */
    val spfTypeName = arrayListOf(
            "spf_sp3",
            "spf_sp1",
            "spf_sp0",
            "rqspf_sp3",
            "rqspf_sp1",
            "rqspf_sp0")

    /**
     * 胜平负 key集合
     */
    val spfType = arrayListOf(
            "spf_sp3",
            "spf_sp1",
            "spf_sp0")

    /**
     * 让球胜平负 key集合
     */
    val rqSpfType = arrayListOf(
            "rqspf_sp3",
            "rqspf_sp1",
            "rqspf_sp0")

    /**
     * icon_types_jclq | 胜负 key集合
     */
    var jclqSfTypeName = arrayListOf("sf_sp3", "sf_sp0")


    /**
     * icon_types_jclq | 让球胜负 key集合
     */
    var jclqRfsfTypeName = arrayListOf(
            "rfsf_sp3",
            "rfsf_sp0"
    )

    /**
     * icon_types_jclq | 胜平负  key集合
     */
    var jclqSfcTypeName = arrayListOf(
            "sfc_sp11",
            "sfc_sp12",
            "sfc_sp13",
            "sfc_sp14",
            "sfc_sp15",
            "sfc_sp16",
            "sfc_sp01",
            "sfc_sp02",
            "sfc_sp03",
            "sfc_sp04",
            "sfc_sp05",
            "sfc_sp06")


    /**
     * icon_types_jclq | 主队胜负差 key集合
     */
    var jclqHomeSfcTypeName = arrayListOf(
            "sfc_sp11",
            "sfc_sp12",
            "sfc_sp13",
            "sfc_sp14",
            "sfc_sp15",
            "sfc_sp16")


    /**
     * icon_types_jclq | 客队胜平负 key集合
     */
    var jclqAwaySfcTypeName = arrayListOf(
            "sfc_sp01",
            "sfc_sp02",
            "sfc_sp03",
            "sfc_sp04",
            "sfc_sp05",
            "sfc_sp06")


    /**
     * icon_types_jclq | 大小分 key集合
     */
    var jclqDxfTypeName = arrayListOf(
            "dxf_sp3",
            "dxf_sp0"
    )


    /**
     * 遍历所有的串的集合
     * @param typeList 串的集合
     * @param map 遍历组合的数据
     * @return 返回重新帅选的数据
     */
    fun getResult(typeList: ArrayList<Int>, map: LinkedHashMap<Match, ArrayList<BetBean>>): ArrayList<ArrayList<LinkedHashMap<Match, BetBean>>> {
        var betList: ArrayList<ArrayList<LinkedHashMap<Match, BetBean>>> = ArrayList()
        typeList.forEach {
            betList.addAll(getBetMapList(k = it, map = map))
        }
        return betList

    }

    /**
     * 从遍历好的数据中取出需要的串的集合
     * @param typeList 串的集合
     * @param list 已经遍历好的数据
     * @param choseWaveCount 已经选择的波胆数
     * @return 返回重新帅选的数据
     */

    fun getListFormResult(typeList: ArrayList<Int>, list: ArrayList<ArrayList<LinkedHashMap<Match, BetBean>>>, choseWaveCount: Int = 0)
            : ArrayList<ArrayList<LinkedHashMap<Match, BetBean>>> {

        var newList: ArrayList<ArrayList<LinkedHashMap<Match, BetBean>>> = ArrayList()

        typeList.forEach {
            var item = it

            list.forEach {
                if (it.size == item) {
                    //有波胆
                    if (choseWaveCount != 0) {
                        var choseCount = 0
                        var listIt = it
                        listIt.forEach {
                            //计算包含波胆的选项的个数  必须包含choseWaveCount个
                            for ((key, _) in it) {
                                if (key.clickWave) choseCount++
                            }
                            if (choseCount == choseWaveCount) {
                                newList.add(listIt)
                                choseCount = 0
                            }
                        }
                    } else {
                        newList.add(it)
                    }

                }
            }

        }

        return newList
    }


    /**
     * 以map形式进行遍历出n个数的全部组合
     * @param k 要取得个数
     * @param map 要遍历的集合
     * @return 符合条件的集合
     */

     fun getBetMapList(k: Int = 2, map: LinkedHashMap<Match, ArrayList<BetBean>>): ArrayList<ArrayList<LinkedHashMap<Match, BetBean>>> {

        var middleList: ArrayList<LinkedHashMap<Match, BetBean>> = ArrayList()           // 展开的遍历数组
        var lastList: ArrayList<ArrayList<LinkedHashMap<Match, BetBean>>> = ArrayList()  //遍历完的结果
        var combineList: ArrayList<LinkedHashMap<Match, BetBean>> = ArrayList()          // 递归遍历中的中间值

        for ((key, value) in map) {
            value.forEach {
                var newMap: LinkedHashMap<Match, BetBean> = LinkedHashMap()
                newMap.put(key, it)
                middleList.add(newMap)
            }
        }

        // 所有可能存在情况
        fun combine(index: Int, k: Int, dataList: ArrayList<LinkedHashMap<Match, BetBean>>) {
            when {
                k == 1 -> {

                    for (i in index until dataList.size) {

                        combineList.add(dataList[i])
                        val newList = arrayListOf<LinkedHashMap<Match, BetBean>>()

                        // 判断是否有重复数据 进行记录
                        val positionList: ArrayList<Int> = ArrayList()
                        var flag = false
                        combineList.forEach {
                            val key = ArrayList(it.keys)[0]
                            if (positionList.contains(key.id)) {
                                flag = true
                            }
                            positionList.add(key.id)
                            newList.add(it)
                        }

                        // 如果重复不添加
                        if (!flag) lastList.add(newList)
                        combineList.remove(dataList[i])
                    }

                }

                k > 1 -> {
                    for (i in index..dataList.size - k) {
                        combineList.add(dataList[i])
                        combine(index = i + 1, k = k - 1, dataList = dataList)
                        combineList.remove(dataList[i])
                    }

                }

                else -> {
                    return
                }
            }

        }
        combine(index = 0, k = k, dataList = middleList)

        return lastList

    }


    /**
     * 选中项中最终支持的串数
     * 场次数小于支持的最大的串数 最大串数以场次决定
     * @param map 选中的比赛
     * @return 支持的最大的串数
     *
     */
    fun getBetOnLastCount(map: LinkedHashMap<Match, ArrayList<BetBean>>): Int {
        var bigCount = 4                     // 保存最大的串数 比如最大4串1
        var countList: ArrayList<Int> = ArrayList()
        for ((_, value) in map) {
            value.forEach { countList.add(getBetOnBigCount(it.key)) }
        }
        bigCount = countList.min()!!
        if (map.size <= bigCount) bigCount = map.size
        return bigCount

    }


    /**
     * 计算所有玩法中支持的最大的串数
     * 半全 4串1  比分 4串1  进球数 6串1  胜平负 8串1 让球胜平负 8串1
     * icon_types_jclq 胜负/让分胜负 8 胜负差 4 大小分 4
     * @param name 所选的字段名
     * @return 最大的串数
     */
    private fun getBetOnBigCount(name: String): Int {
        jqsTypeName.forEach { if (it == name) return 6 }
        spfTypeName.forEach { if (it == name) return 8 }
        jclqDxfTypeName.forEach { if (it == name) return 8 }
        jclqRfsfTypeName.forEach { if (it == name) return 8 }
        jclqSfTypeName.forEach { if (it == name) return 8 }
        jclqSfcTypeName.forEach { if (it == name) return 4 }
        return 4
    }


    /**
     * 判断是否单关支持 多项全部为单关时 显示单关选择项 只要有一项选项为非单关 则全部为非单关
     * @param map 所选数据集合
     * @return true 所选的每场都支持单关
     *
     */

    fun judgeSingle(map: LinkedHashMap<Match, ArrayList<BetBean>>): Boolean {
        if (map.size == 0) return false
        var boolean = true
        for ((key, value) in map) {
            value.forEach {
                if (!judgeTypeSingle(match = key, jczq = it)) return false    //有一种选项不包含 则不支持单关
            }
        }

        return boolean
    }


    /**
     * 判断某种选择是否支持单关
     * @param match 相关比赛信息
     * @param jczq 本次玩法
     * @return 是否支持 默认不支持单关
     */
    private fun judgeTypeSingle(match: Match, jczq: BetBean): Boolean {

        var singleBoolean = false
        val betUtil = BetUtil()

        // 胜平负 且支持
        if (betUtil.spfType.contains(jczq.key) && match.spfSingle == 1) {
            singleBoolean = true
        }
        // 让球胜平负 且支持
        if (betUtil.rqSpfType.contains(jczq.key) && match.rqspfSingle == 1) {
            singleBoolean = true
        }
        // 半全场 且支持
        if (betUtil.bqcTypeName.contains(jczq.key) && match.bqcSingle == 1) {
            singleBoolean = true
        }
        // 进球数 且支持
        if (betUtil.jqsTypeName.contains(jczq.key) && match.jqsSingle == 1) {
            singleBoolean = true
        }
        // 比分 且支持
        if (betUtil.bfTypeName.contains(jczq.key) && match.bfSingle == 1) {
            singleBoolean = true
        }

        // icon_types_jclq 大小分
        if (betUtil.jclqDxfTypeName.contains(jczq.key) && match.dxfSingle == 1) {
            singleBoolean = true
        }
        // icon_types_jclq 胜负
        if (betUtil.jclqSfTypeName.contains(jczq.key) && match.sfSingle == 1) {
            singleBoolean = true
        }
        // icon_types_jclq 让分胜负
        if (betUtil.jclqRfsfTypeName.contains(jczq.key) && match.rfsfSingle == 1) {
            singleBoolean = true
        }
        // icon_types_jclq 胜负差
        if (betUtil.jclqSfcTypeName.contains(jczq.key) && match.sfcSingle == 1) {
            singleBoolean = true
        }

        return singleBoolean
    }

    /**
     * 深度复制jczq
     * @param bean 需要被复制的类
     * @return 复制好的类
     */
    fun copyJczq(bean: BetBean): BetBean {
        return BetBean(sp = bean.sp, status = bean.status, key = bean.key, jianChen = bean.jianChen, typeString = bean.typeString)
    }


    /**
     * 添加选中项
     * @param match 本场次标记
     * @param betBean 本场次的某项玩法选择
     * @param choseMap 已选择场次的集合
     *
     */
    fun addBetBean(match: Match, betBean: BetBean, choseMap: LinkedHashMap<Match, ArrayList<BetBean>>) {

        // 本场比赛已经添加过
        for ((key, value) in choseMap) {

            if (key.id == match.id) {

                // 查找该选项是否已经存在
                var position = -1
                value.forEachIndexed { index, jczqBean -> if (jczqBean.key == betBean.key) position = index }

                // 该选项已经存在  移除
                if (position != -1) {
                    value.removeAt(position)
                    if (value.size == 0) choseMap.remove(key)  //最后一场比赛
                    return
                }

                value.add(betBean)   // 该选项不存在  添加
                return

            }

        }

        //本场比赛从未添加过
        val inList: ArrayList<BetBean> = ArrayList()
        inList.add(betBean)
        choseMap.put(match, inList)

    }


    /**
     * 初始化JS参数
     */

    fun getWebView(context: Activity): WebView {
        val webView = WebView(context)
        webView.webChromeClient = WebChromeClient()
        val set = webView.settings
        set.javaScriptEnabled = true
        return webView
    }


    /**
     * 获取投注的预估金额
     * @param webView 调用JS
     * @param choseMap 已选择的集合
     * @param typeList 串集合  1串1 ,2串1 , 3串1 ...
     *
     */
    fun getBetMoney(webView: WebView, choseMap: LinkedHashMap<Match, ArrayList<BetBean>>, typeList: ArrayList<String>, mutil: Int = 1, lotteryId: Int = LotteryIdEnum.jczq.id) {

        /**
         * 初始化webView参数
         */


        val optsArray = Gson().toJson(getOpts(choseMap = choseMap))

        //转化为数组
        val array: Array<String> = Array(typeList.size, { "" })

        typeList.forEachIndexed { index, s ->
            array[index] = s
        }
        val arrayString = Gson().toJson(array)

        if (lotteryId == LotteryIdEnum.jczq.id) {
            webView.loadUrl("javascript:getJczqBetCount($optsArray,$arrayString,$mutil)")

        } else {
            webView.loadUrl("javascript:getJclqBetCount($optsArray,$arrayString,$mutil)")

        }
    }


    /**
     * 格式化预估奖金的参数
     * arrayOf ("spf-3@-1#3.95", "nspf-1#3.30|spf-1@-1#3.55", "nspf-3#1.57,nspf-0#4.80|spf-1@-1#3.35", "nspf-3#2.20|spf-1@-1#3.95")
     * @param choseMap 已选择的玩法集合
     * match: 比赛  arrayList 该赛下选择的玩法
     */
    fun getOpts(choseMap: LinkedHashMap<Match, ArrayList<BetBean>>): Array<String> {
        val keyList: ArrayList<String> = ArrayList()
        for ((key, value) in choseMap) {
            keyList.add(jczqBetMoneyKeyString(value, key)+"${if (key.clickWave) "D" else ""}")
        }
        //转化为数组
        val array: Array<String> = Array(keyList.size, { "" })
        keyList.forEachIndexed { index, s ->
            array[index] = s
        }
        return array


    }

    /**
     * 获取
     * 竞彩足球||篮球
     * 进球数 || 比分 || 半全场 ||非让球 (key#sp) 让球 (key@leaBall#sp)
     */
    private fun jczqBetMoneyKeyString(betList: ArrayList<BetBean>, match: Match): String {
        val list: ArrayList<ArrayList<String>> = ArrayList()

        val resultList: ArrayList<ArrayList<BetBean>> = ArrayList()
        /**
         * 所有的玩法的结合
         */
        val allTypeList: ArrayList<ArrayList<String>> = arrayListOf(rqSpfType, spfType, bfTypeName,
                bqcTypeName, jqsTypeName, jclqSfcTypeName, jclqRfsfTypeName, jclqDxfTypeName, jclqSfTypeName)

        allTypeList.forEach {
            val typeKey = it
            val type = betList.filter { typeKey.contains(it.key) } as ArrayList<BetBean>
            if (type.isNotEmpty()) resultList.add(type)

        }


        /**
         * 将比赛玩法分类
         */
        resultList.forEach {
            val newList: ArrayList<String> = ArrayList()
            it.forEach {

                if (rqSpfType.contains(it.key) || jclqRfsfTypeName.contains(it.key))
                    newList.add("${setKeyBetString(it.key)}@${match.letBall}#${it.sp}")
                else
                    newList.add("${setKeyBetString(it.key)}#${it.sp}")
            }
            list.add(newList)
        }


        /**
         * 同种玩法,隔开  不同的玩法|隔开
         */
        var content = ""
        list.forEachIndexed { index, arrayList ->
            arrayList.forEachIndexed { position, it ->
                content += it + if (position != it.lastIndex) "," else ""
            }
            content = content.substring(0, content.length - 1) + if (index != list.lastIndex) "|" else ""

        }
        return content

    }

    /**
     * icon_types_jclq||足球 key 替换规则
     *
     * rqspf_sp3 -> nspf-3
     */

    private fun setKeyBetString(key: String): String {

        var newKey = key

        //  大小分  3大=>1大, 0小=>2小
        if (key.contains("dxf")) {
            newKey = newKey.replace("3", "1").replace("0", "2")
        }

        //胜平负||让球胜平负  rqspf=>spf ,  spf=>nspf
        if (key.contains("spf")) {
            var boolean = true
            if (key.contains("rqspf")) {
                boolean = false
                newKey = newKey.replace("rqspf", "spf")
            }
            if (key.contains("spf") && boolean) newKey = newKey.replace("spf", "nspf")
        }

        //比分||让分胜负  0客=>2客, 3主=>1主
        if (key.contains("sf_")) {
            newKey = newKey.replace("3", "1").replace("0", "2")
        }

        return newKey
                .replace("_sp", "-")
                .replace("7+", "7")
                .replace("A0", "0A")
                .replace("A1", "1A")
                .replace("A2", "2A")
                .replace("A3", "3A")


    }


    /**
     * 大乐透注数计算
     * @param redBetChoseCount  红球投注项
     * @param blueBetCount      篮球已选项
     * @param redWaveCount      红球投注项波胆个数
     * @param blueWaveCount     篮球波胆个数
     * @param blueMinLimitCount 篮球最小的选择格式-> 双色球1||大乐透2
     *
     *
     *  单个 计算公式 C m,n
     *  m = redBetChoseCount - redWaveCount
     *  n = blueLimitCount-  blueWaveCount
     *
     *
     */

    fun dltBetCount(redBetChoseCount: Int, blueBetCount: Int, redWaveCount: Int, blueWaveCount: Int,lotteryId: Int): Int {



       val pair =  when(lotteryId){
            LotteryIdEnum.qlc.id -> Pair(7,0)
            LotteryIdEnum.ssq.id -> Pair(6,1)
            else -> Pair(5,2)
        }

        val redLimitCount = pair.first        // 最大支持的项数  红区:5  蓝区:2
        val blueMinLimitCount = pair.second

        // 红求
        val redCount = redBetChoseCount - redWaveCount
        val redCountTwo = redLimitCount - redWaveCount

        // 篮球
        val blueCount = blueBetCount - blueWaveCount
        val blueCountTwo = blueMinLimitCount - blueWaveCount

        if (redLimitCount == redCount && blueMinLimitCount == blueCount) return 1    // C 5 5


        //C m.n
        var a = 1
        for (i in redCount - redCountTwo + 1..redCount) {           //  i in 2..6
            a *= i
        }

        var b = 1
        for (i in 1..redCountTwo) {
            b *= i
        }

        var blueA = 1
        for (i in blueCount - blueCountTwo + 1..blueCount) {
            blueA *= i
        }

        var blueB = 1
        for (i in 1..blueCountTwo) {
            blueB *= i
        }

        // 七乐彩 没有蓝区时  蓝区最小选择项数为0
        val selectCount = if (blueMinLimitCount ==0) 1 else (blueA / blueB)
        return selectCount *(a / b)


    }






}


