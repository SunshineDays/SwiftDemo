package com.caidian310.utils

/**
 * 手机摇一摇
 * Created by Wdb on 17/3/23.
 */

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import java.util.*

/**
 * 摇一摇工具类
 * 使用说明：
 * private ShakeUtils mShakeUtils = null;
 * 1、在需要使用摇一摇功能的Activity实例化该工具类并设置摇一摇监听：
 * mShakeUtils = new ShakeUtils( this );
 * mShakeUtils.setOnShakeListener(new OnShakeListener{
 * public void onShake(){
 * // 此处为摇一摇触发后的操作
 * }
 * });
 *

 */
class ShakeUtils(context: Context) : SensorEventListener {

    private var mSensorManager: SensorManager? = null
    private var mOnShakeListener: OnShakeListener? = null
    private var random: Random = Random()

    init {
        mSensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    }

    fun setOnShakeListener(onShakeListener: OnShakeListener) {
        mOnShakeListener = onShakeListener
    }

    fun onResume() {
        mSensorManager!!.registerListener(this, mSensorManager!!.getDefaultSensor(Sensor.TYPE_ACCELEROMETER), SensorManager.SENSOR_DELAY_NORMAL)
    }

    fun onPause() {
        mSensorManager!!.unregisterListener(this)
    }

    override fun onAccuracyChanged(sensor: Sensor, accuracy: Int) {

    }




    override fun onSensorChanged(event: SensorEvent) {
        val sensorType = event.sensor.type

        val values = event.values
        if (sensorType == Sensor.TYPE_ACCELEROMETER) {
            //这里可以调节摇一摇的灵敏度
            if (Math.abs(values[0]) > SENSOR_VALUE || Math.abs(values[1]) > SENSOR_VALUE || Math.abs(values[2]) > SENSOR_VALUE) {
                if (null != mOnShakeListener) {
                    mOnShakeListener!!.onShake()
                }
            }
        }

        if (sensorType == Sensor.TYPE_AMBIENT_TEMPERATURE) {
        }
    }

    interface OnShakeListener {
        fun onShake()
    }

    companion object {
        private val SENSOR_VALUE = 14
    }

//
//    /**
//     * 摇一摇随机号码
//     * @param count 产生的个数
//     * @param list 产生个数发生的集合
//     */
//
//    fun <T> getRandomList(count:Int, list: ArrayList<T>): ArrayList<String> {
//        val randomList: ArrayList<String> = ArrayList()
//
//        /**
//         * listRandom 中拿出 countRandom个随机数
//         */
//        fun getRandom(countRandom:Int,listRandom:ArrayList<String>) {
//            for (i in 0 until countRandom){
//                val num = random.nextInt(listRandom.lastIndex)
//                if (!randomList.contains(listRandom[num])) randomList.add(listRandom[num])
//            }
//
//            // 如果个数不够count  继续添加一次
//            if (randomList.size<count)  getRandom(count-randomList.size,list)
//        }
//
//        getRandom(count,list)
//
//
//        //排序
//        return ArrayList(randomList.sorted())
//
//    }


}
