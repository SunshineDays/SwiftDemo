package com.caidian310.activity.sport.basketball

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.support.design.widget.TabLayout
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.adapter.football.chose.FootballChoseAdapter
import kotlinx.android.synthetic.main.activity_foot_ball_chose.*


class BasketballChoseActivity : BaseActivity() {


    private val tabTitles = arrayOf("全部", "NBA")
    private var leagueList: ArrayList<String> = ArrayList()
    private var oldLeagueList: ArrayList<String> = ArrayList()
    private var leagueChoseList: ArrayList<String> = ArrayList()
    private var leagueChoseIndex: Int = 0

    private var adapter: FootballChoseAdapter? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_foot_ball_chose)

        initActionBar(centerTitle = "赛事选择")

        initEvent()
        initListener()
    }

    override fun initEvent() {
        super.initEvent()


        oldLeagueList.addAll(intent.getStringArrayListExtra("leagueList"))
        leagueList.addAll(intent.getStringArrayListExtra("leagueList"))
        leagueChoseList.addAll(intent.getStringArrayListExtra("leagueChoseList"))
        leagueChoseIndex = intent.getIntExtra("leagueChoseIndex", 0)

        //预防出界
        if (leagueChoseIndex < 0 || leagueChoseIndex >= tabTitles.size) leagueChoseIndex = 0

        setTabLayout()

        getLeagueData(leagueChoseIndex)                           //一打开就对数据进行一次归类处理

        adapter = FootballChoseAdapter(this, leagueList, leagueChoseList)
        foot_ball_chose_grid_view.adapter = adapter


    }

    override fun initListener() {
        super.initListener()

        //确定
        foot_ball_chose_sure.setOnClickListener {
            val intent = Intent()
            intent.putExtra("leagueChoseList", adapter?.leagueChoseList)
            intent.putExtra("leagueChoseIndex", leagueChoseIndex)
            setResult(Activity.RESULT_OK, intent)
            finish()
        }

        //取消
        foot_ball_chose_cancel.setOnClickListener { finish() }

        //全清
        foot_ball_chose_clear.setOnClickListener {
            leagueChoseList.clear()
            adapter?.notifyDataSetChanged()
        }
    }


    private val tabListener: TabLayout.OnTabSelectedListener = object : TabLayout.OnTabSelectedListener {
        override fun onTabReselected(tab: TabLayout.Tab?) {

        }

        override fun onTabUnselected(tab: TabLayout.Tab?) {
        }

        override fun onTabSelected(tab: TabLayout.Tab?) {
            if (tab == null) return
            leagueChoseIndex = tab.position
            leagueChoseList.clear()
            getLeagueData(tab.position)
            adapter?.notifyDataSetChanged()
        }
    }

    /**
     * 分类数据类型 全部||五大联赛||热门赛事
     * @param position  位置标记
     */

    fun getLeagueData(position: Int = leagueChoseIndex) {
        leagueList.clear()
        when (position) {
            0 -> leagueList.addAll(oldLeagueList)                                             //全部
            else -> leagueList.addAll(oldLeagueList.filter { it == "NBA" || it == "美职篮" })  //NBA

        }
    }


    // 初始化tabLayout
    private fun setTabLayout() {
        foot_ball_chose_tab.tabMode = TabLayout.MODE_FIXED
        tabTitles.forEachIndexed { index, it ->
            foot_ball_chose_tab.addTab(foot_ball_chose_tab.newTab())
            foot_ball_chose_tab.getTabAt(index)!!.text = it
        }
        foot_ball_chose_tab.getTabAt(leagueChoseIndex)!!.select()
        foot_ball_chose_tab.setOnTabSelectedListener(tabListener)
    }


}


