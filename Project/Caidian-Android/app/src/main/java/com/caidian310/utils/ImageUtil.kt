package com.caidian310.utils

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import android.media.ExifInterface
import android.widget.ImageView
import java.io.File
import java.io.FileNotFoundException
import java.io.FileOutputStream
import java.io.IOException

/**
 * description :  图片工具
 * Created by wdb on 2017/5/5.
 */

object ImageUtil {


    /***
     * Url图片裁剪
     * @param uri     图片请求地址
     * @param height  裁剪后的高
     * @param width   裁剪后的宽
     * @param crop 球队球员联赛logo都用crop=3 其他的还用crop=2
     * @return
     */
    fun imageTailor(uri: String?, height: Int, width: Int,crop:Int=2): String {

        if (uri == null) return ""
        uri.trim()
        return if (uri.contains("?")) {
            "$uri&w=$width&h=$height&crop=$crop"
        } else {
            "$uri?w=$width&h=$height&crop=$crop"
        }
    }


    /**
     * 读取图片的旋转的角度
     * @param path 图片绝对路径
     * @return 图片的旋转角度
     */
    fun getBitmapDegree(path: String): Int {
        var degree = 0
        try {
            // 从指定路径下读取图片，并获取其EXIF信息
            val exifInterface = ExifInterface(path)
            // 获取图片的旋转信息
            val orientation = exifInterface.getAttributeInt(ExifInterface.TAG_ORIENTATION,
                    ExifInterface.ORIENTATION_NORMAL)
            when (orientation) {
                ExifInterface.ORIENTATION_ROTATE_90 -> degree = 90
                ExifInterface.ORIENTATION_ROTATE_180 -> degree = 180
                ExifInterface.ORIENTATION_ROTATE_270 -> degree = 270
            }
        } catch (e: IOException) {
            e.printStackTrace()
        }

        return degree
    }

    /**
     * 将图片按照某个角度进行旋转
     * @param bm 需要旋转的图片
     * @param degree  旋转角度
     * @return 旋转后的图片
     */
    fun rotateBitmapByDegree(bm: Bitmap, degree: Int): Bitmap {
        var returnBm: Bitmap? = null

        // 根据旋转角度，生成旋转矩阵
        val matrix = Matrix()
        matrix.postRotate(degree.toFloat())
        try {
            // 将原始图片按照旋转矩阵进行旋转，并得到新的图片
            returnBm = Bitmap.createBitmap(bm, 0, 0, bm.width, bm.height, matrix, true)
        } catch (e: OutOfMemoryError) {
        }

        if (returnBm == null) {
            returnBm = bm
        }
        if (bm != returnBm) {
            bm.recycle()
        }
        return returnBm
    }


    /**
     * 图片上传时 把bitmap起名并保存在一定的路径下
     * @param bitmap
     * @param 保存地址
     * @return
     */
    fun saveThePicture(bitmap: Bitmap, file: File): File {
        if (file != null) {
            try {
                val fos = FileOutputStream(file)
                if (bitmap.compress(Bitmap.CompressFormat.JPEG, 50, fos)) {
                    fos.flush()
                    fos.close()
                }
            } catch (e1: FileNotFoundException) {
                e1.printStackTrace()
            } catch (e2: IOException) {
                e2.printStackTrace()
            }

        }
        return file
    }


    /**
     * 相册修改头像时调用
     * @param imageView 需要显示的控件
     * @param photoPath 需要裁剪的图片地址
     */

    fun setImageBitmap(imageView: ImageView, photoPath: String) {
        //获取imageView的宽和高
        val targetWidth = imageView.width
        val targetHeight = imageView.height

        //根据图片路径，获取bitmap的宽和高
        val options = BitmapFactory.Options()
        options.inJustDecodeBounds = true
        BitmapFactory.decodeFile(photoPath, options)
        val photoWidth = options.outWidth
        val photoHeight = options.outHeight

        //获取缩放比例
        var inSampleSize = 1
        if (photoWidth > targetWidth || photoHeight > targetHeight) {
            val widthRatio = Math.round(photoWidth.toFloat() / targetWidth)
            val heightRatio = Math.round(photoHeight.toFloat() / targetHeight)
            inSampleSize = Math.min(widthRatio, heightRatio)
        }

        //使用现在的options获取Bitmap
        options.inSampleSize = inSampleSize
        options.inJustDecodeBounds = false
        val bitmap = BitmapFactory.decodeFile(photoPath, options)
        imageView.setImageBitmap(bitmap)
    }


}
