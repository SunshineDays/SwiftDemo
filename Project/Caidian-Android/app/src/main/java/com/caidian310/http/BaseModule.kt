package com.caidian310.http

/**
 * Created by mac on 2017/11/26.
 */
 class BaseModule <T>(t:T) {
    var msg: String = ""
    var data: T = t
    var code :Int =0
}
