
function log(message, data) {
    var $log = $('#log');
    var uniqueId = $log.find('div').length + 1;
    var $ele = $('<div>' + uniqueId + '. ' + message + ':<br/>' + JSON.stringify(data) + '</div>')
    $log.append($ele);
}

window.onerror = function(err) {
    log('window.onerror: ' + err);
}

function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        callback(WebViewJavascriptBridge);
    } else {
        document.addEventListener('WebViewJavascriptBridgeReady', function() {
            callback(WebViewJavascriptBridge);
        }, false);
    }
}

connectWebViewJavascriptBridge(function(bridge) {

    // 初始化
    bridge.init(function(message, responseCallback) {
        responseCallback && responseCallback(data);
    });

    // 设置图片src
    bridge.registerHandler('setImage', function(data, responseCallback) {
        var data = JSON.parse(data);
        var id = data && data['id'];
        var src = data && data['src'];
        var $img = $('#' + id);
        $img.removeClass('placeholder')
        $img.attr('src',  src);
    });

    // 图片点击
    $('img.img-photo').on('click', function(){
        var index = $(this).data('index') || 0;
        bridge.callHandler('showPhotoBrowser', {index: index})
    });

    // 相关阅读
    bridge.registerHandler('setRelatives', function(data, responseCallback) {
            data = data || [];
            var data = JSON.parse(data);
            var $relatives = $('#relatives');
            if(data.length<=0) {
                $relatives.style.visibility="hidden";
                return;
            }
            var html = "";
            for (var i = 0; i < data.length; i++) {
                var relative = data[i];
                if (!relative['appurl']) {
                    continue;
                }
                html += "<li><a href='" + relative['appurl'] + "'>" + relative['title'] + "</a></li>";
            };
            $relatives.find('ul').html(html);
            $relatives.show();
        });

});
