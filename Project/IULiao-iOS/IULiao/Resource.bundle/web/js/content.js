function log(message, data) {
    var $log = $('#log');
    var uniqueId = $log.find('div').length + 1;
    var $ele = $('<div>' + uniqueId + '. ' + message + ':<br/>' + JSON.stringify(data) + '</div>');
    $log.append($ele);
}

window.onerror = function(err) {
    log('window.onerror: ' + err);
};

function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
    if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
}

connectWebViewJavascriptBridge(function(bridge) {

    // 设置图片src
    bridge.registerHandler('setImage', function(data, responseCallback) {
        var id = data && data['id'];
        var src = data && data['src'];
        var $img = $('#' + id);
        $img.removeClass('placeholder');
        $img.attr('src',  src);
    });

    // 相关阅读
    bridge.registerHandler('setRelatives', function(data, responseCallback) {
        data = data || [];
        var $relatives = $('#relatives');
        if(!data.length) {
            $relatives.hide();
            return;
        }
        var html = "";
        for (var i = 0; i < data.length; i++) {
            var relative = data[i];
            if (!relative['appurl']) {
                continue;
            }
            html += "<li><a href='" + relative['appurl'] + "'>" + relative['title'] + "</a></li>";
        }
        $relatives.find('ul').html(html);
        $relatives.show();
    });
                    
    // 标签
    bridge.registerHandler('setTags', function(data, responseCallback) {
        data = data || [];
        var $tags = $('#tags');
        if(!data.length) {
            $tags.hide();
            return;
        }
        var html = "";
        for (var i = 0; i < data.length; i++) {
            var tag = data[i];
            if (!tag['appurl']) {
                continue;
            }
            html += "<a href='" + encodeURI(tag['appurl']) + "'>" + tag['title'] + "</a>";
        }
        $tags.html(html);
        $tags.show();
    });

    // 图片点击
    $('img.img-photo').on('click', function(){
        var index = $(this).data('index') || 0;
        bridge.callHandler('showPhotoBrowser', {index: index})
    });
                 
});

