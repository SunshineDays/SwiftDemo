package com.caidian310.utils

import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import java.io.Serializable

/**
 * 序列化Map
 * Created by mac on 2017/12/5.
 */
data  class SerializableMap(var map: LinkedHashMap<Match, ArrayList<BetBean>>): Serializable