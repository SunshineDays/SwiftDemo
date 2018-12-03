package com.caidian310.utils


import com.caidian310.bean.new.NewsItem

/**
 * description :
 * Created by wdb on 2017/4/21.
 */

object HtmlStringUtil {


    fun spliceImageHtml(newsItem:NewsItem): String {

        val body = StringBuffer()

        body.append("<!doctype html>")
        body.append("<html>")
        body.append("<head>")
        body.append("   <meta charset='utf-8'/>")
        body.append("   <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=no'/>")
        body.append("   <meta name='format-detection' content='telephone=no' />")
        body.append("   <link href='web/css/content.css' rel='stylesheet'/>")
        body.append("   <script src='web/js/jquery-2.1.4.min.js' type='text/javascript' charset='utf-8'></script>")
        body.append("   <script src='web/js/content.js' type='text/javascript' charset='utf-8'></script>")
        body.append("</head>")
        body.append("<body>")
        body.append("   <div id='log' style='display:none;'>log</div>")
        body.append("   <header id='header'>")
        body.append("       <h1 class='title'>" + newsItem.title + "</h1>")
        body.append("       <div class='subtitle'>")
        body.append("           <time>" + TimeUtil.getIntelligenceTime(newsItem.createTime, TimeUtil.timeFormat) + "</time>")
        body.append("       </div>")
        body.append("   </header>")
        body.append("<article id='content'>")
        body.append(newsItem.content)

        body.append("</article>")
        body.append("<section id='tags' class='clearfix'>")
        body.append("</section>")

        body.append("</body>")
        body.append("</html>")
        return body.toString()
    }




}
