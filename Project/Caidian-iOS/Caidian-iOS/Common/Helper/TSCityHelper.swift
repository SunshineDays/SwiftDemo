//
//  TSCityHelper.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 com.caidian310. All rights reserved.

//城市选择工具

import Foundation
import SwiftyJSON

class TSCityHelper :NSObject{

    /// 省集合
    var provinceList = [TSProvinceModel]()
    var jsonData: JSON!

    /**
     * 读取本地文件   转化为model
     * fileNameStr  文件名
     * type         文件类型
     **/
    func readLocalData(fileNameStr: String, type: String, directory: String) -> Any? {
        
        let jsonPath = Bundle.main.path(forResource: fileNameStr, ofType: type,inDirectory: directory)
        let url = URL(fileURLWithPath: jsonPath!)
        do {
            let data =  try Data(contentsOf: url)
            let dicrArr = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            return dicrArr

        } catch _ {
            return nil
        }
    }


    /**
     * 初始换参数
     **/
    func initCityHelp() {
        let data =  self.readLocalData(fileNameStr: "city", type: "json",directory :"Resource.bundle")
        let json = JSON(data ?? Data())
        provinceList = json.arrayValue.map{return TSProvinceModel(json: $0)}
    }
        

    /**
     *通过省id 获取 省name
     **/
    func getProvinceNameFromId(provinceId :Int) -> String {
      return  provinceList.first {
            it in
            it.id == provinceId
        }?.name ?? ""
    }

    /**
     *通过市id 获取 省name
     **/
    func getCityNameFromId(cityId :Int) -> String {
        var cityName = ""
         provinceList.forEach {
            $0.children.forEach({
                item in
                if item.id == cityId {
                    cityName = item.name
                }
            })
        }
        return cityName
    }


}

