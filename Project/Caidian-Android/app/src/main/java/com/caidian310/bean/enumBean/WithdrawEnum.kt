package com.caidian310.bean.enumBean

enum class WithdrawEnum(var id:Int,var message:String){
    WithdrawIng(id = 0, message = "进行中"),
    WithdrawSuccess(id = 1, message = "提款成功"),
    WithdrawOnFailure(id = -1, message = "提款失败");

    fun getWithdrawEnumFromId(id:Int) = when(id){
        WithdrawIng.id -> WithdrawIng
        WithdrawSuccess.id -> WithdrawSuccess
       else  -> WithdrawOnFailure
    }
}