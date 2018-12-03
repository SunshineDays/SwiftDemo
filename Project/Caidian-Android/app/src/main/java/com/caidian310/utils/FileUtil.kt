package com.caidian310.utils
import android.content.ContentUris
import android.content.ContentValues
import android.content.Context
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.DocumentsContract
import android.provider.MediaStore
import android.support.annotation.RequiresApi
import com.caidian310.application.MyApplication
import com.caidian310.http.Router
import org.jetbrains.annotations.NotNull
import java.io.File
import java.io.IOException

/**
 * Created by mac on 2017/11/9.
 * 文件管理类
 */
object FileUtil{


    /**
     * 网络请求的缓存地址
     * @param json 需要缓存的json
     * @param path 缓存接口
     */
    fun writeHttpLocal(@NotNull json:String="cache",path:String){

        var fileName  = path.replace(Router.baseUrl,"").replace("/","_")+".txt"
        val dir = MyApplication.instance!!.cacheDir
        var cache = File(dir, "cacheHttp")
        cache.delete()

        if (!cache.exists()) {
            cache.mkdir()
            cache = File(dir, "cacheHttp")
        }
        val cacheFile = File(cache,fileName)

        if (!cacheFile.exists()) cacheFile.createNewFile()
        cacheFile.writeText(json)

    }

    /**
     * 创建File对象，用于存储拍照后的图片
     * @param parent
     */
    fun getCacheFile(parent: File, child: String): File {
        val file = File(parent, child)
        if (file.exists()) {
            file.delete()
        }
        try {
            file.createNewFile()
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return file
    }

    /**
     * 获取软件中文件的缓存地址
     * @param context 事例
     */
    fun getDiskCacheDir(context: Context): String {
        return if (Environment.MEDIA_MOUNTED == Environment.getExternalStorageState() || !Environment.isExternalStorageRemovable()) {
            context.externalCacheDir!!.path
        } else {
            context.cacheDir.path
        }

    }



    /**
     * 获取网络请求的缓存地址
     * @param path 需要缓存的地址
     * @return null  缓存被清理掉 需要重新请求
     */
    fun readHttpLocal(path:String): Cache{
        // 获取文件名称 保存为 news_list样式
        var url = path.replace(Router.baseUrl,"").replace("/","_")
        val file  = File(MyApplication.instance!!.cacheDir,"cacheHttp")
        val cacheFile = File(file,url+".txt")
        return if (!cacheFile.exists()) Cache(cacheString = null,file = null)
        else Cache(cacheString = cacheFile.readText(),file =  cacheFile)
    }

    data class Cache(
            var cacheString :String ?=null,
            var file:File ?=null
    )



    /**
     *  4.4以下系统使用这个方法处理路劲
     *  通过Uri和selection来获取真实的路径
     *  @param uri uri
     */
    @RequiresApi(Build.VERSION_CODES.KITKAT)
     fun getUriToPathBeforeKitKat(context: Context,uri: Uri, selection: String?): String {
        var path: String = ""
        val cursor = context.contentResolver.query(uri, null, selection, null, null)
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                path = cursor.getString(cursor.getColumnIndex(MediaStore.Images.Media.DATA))
            }
            cursor.close()
        }
        return path
    }

    /**
     *  4.4上系统使用这个方法处理路劲
     *  通过Uri和selection来获取真实的路径
     *  @param uri uri
     */
    @RequiresApi(Build.VERSION_CODES.KITKAT)
    fun getUriToPathAfterKitKat(context: Context,uri: Uri): String {
            var path: String = ""
            if (DocumentsContract.isDocumentUri(context, uri)) {
                // 如果是document类型的Uri，则通过document id处理
                val docId = DocumentsContract.getDocumentId(uri)
                if ("com.android.providers.media.documents" == uri.authority) {
                    val id = docId.split(":".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()[1] // 解析出数字格式的id
                    val selection = MediaStore.Images.Media._ID + "=" + id
                    path = getUriToPathBeforeKitKat(context,MediaStore.Images.Media.EXTERNAL_CONTENT_URI, selection)
                } else if ("com.android.providers.downloads.documents" == uri.authority) {
                    val contentUri = ContentUris.withAppendedId(Uri.parse("content://downloads/public_downloads"), java.lang.Long.valueOf(docId)!!)
                    path = getUriToPathBeforeKitKat(context,contentUri, null)
                }
            } else if ("content".equals(uri.scheme, ignoreCase = true)) {
                // 如果是content类型的Uri，则使用普通方式处理
                path = getUriToPathBeforeKitKat(context,uri, null)
            } else if ("file".equals(uri.scheme, ignoreCase = true)) {
                // 如果是file类型的Uri，直接获取图片路径即可
                path = uri.path
            }
            return path
    }


    /**
     * 获取文件的的uri
     * @param context
     * @param file 文件地址
     */
    fun getFileContentUri(context: Context, file: File): Uri? {
        val filePath = file.absolutePath
        val cursor = context.contentResolver.query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                arrayOf(MediaStore.Images.Media._ID), MediaStore.Images.Media.DATA + "=? ",
                arrayOf(filePath), null)
        return if (cursor != null && cursor.moveToFirst()) {
            val id = cursor.getInt(cursor.getColumnIndex(MediaStore.MediaColumns._ID))
            val baseUri = Uri.parse("content://media/external/images/media")
            Uri.withAppendedPath(baseUri, "" + id)
        } else {
            if (file.exists()) {
                val values = ContentValues()
                values.put(MediaStore.Images.Media.DATA, filePath)
                context.contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)
            } else {
                null
            }
        }
    }



    /**
     * apk  存储的的路径
     *
     * @return
     */
     fun  apkFile() :File{
        var cache: File? = null
        val dir = MyApplication.getInstance().externalCacheDir
        cache = File(dir, "apk")
        if (!cache.exists()) {
            cache.mkdir()
            cache = File(dir, "apk")
        }
        return cache
    }





}