/**
 * Created by lingtao on 15-6-17.
 * commontools
 */
serializeObject = function(form) {
    var o = {};
    $.each(form.serializeArray(), function(index) {
        if (o[this['name']]) {
            o[this['name']] = o[this['name']] + "," + this['value'];
        } else {
            o[this['name']] = this['value'];
        }
    });
    return o;
};


function ajaxCallback(actionUrl,data,fun) {
    if(!actionUrl){
        alert("请先设置请求访问路径");
        return;
    }
    showLoader("请稍后...");
    data = data || {};
    var retrytimes = 5;
    var count = 0;
    var connectServer = function(){
        showLoader("请稍后...");
        $.ajax({
            type: "post",
            url: actionUrl,
            dataType: "jsonp",
            jsonp: "callback",
            contentType: "text/html; charset=utf-8",
            data: data,
            timeout:50000,
            async:true,
            success: function (data) {
                hideLoader();
                fun(data);
                console.log("success");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                hideLoader();
                console.log("error:"+XMLHttpRequest+" textStatus:"+textStatus+" errorThrown"+errorThrown);
            },
            complete:function(XMLHttpRequest, textStatus){
                console.log("complete:"+XMLHttpRequest+"textStatus:"+textStatus);
                if(textStatus == "timeout"){
                    if(count<retrytimes){
                        count++;
                        connectServer();
                        console.log(count);
                    }else{
                        showLoader("连接服务器超时！",true);
                    }

                }
            }
        });
    };
    connectServer();
}

function ajaxCall(actionUrl,data,msgTitle,type,dataType,contentType,cache,async,fun) {
    if(!actionUrl){
        alert("请先设置请求地址!");
        return;
    }
    async = async || true ;
    cache = cache || true ;
    if(contentType==null||contentType==undefined||contentType=="undefined") contentType = "text/html; charset=utf-8" ;
    showLoader(msgTitle);
    data = data || {};
    var retrytimes = 5;
    var count = 0;
    var connectServer = function(){
        showLoader(msgTitle);
        $.ajax({
            type: type,
            url: actionUrl,
            dataType: dataType,
            contentType: contentType,
            data: data,
            timeout:50000,
            async:async,
            cache:cache,//是否使用缓存
            success: function (data) {
                hideLoader();
                fun(data);
                console.log("success");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                hideLoader();
                console.log("error:"+XMLHttpRequest+" textStatus:"+textStatus+" errorThrown"+errorThrown);
            },
            complete:function(XMLHttpRequest, textStatus){
                console.log("complete:"+XMLHttpRequest+"textStatus:"+textStatus);
                if(textStatus == "timeout"){
                    if(count<retrytimes){
                        count++;
                        connectServer();
                        console.log(count);
                    }else{
                        showLoader("连接服务器超时！",true);
                    }

                }
            }
        });
    };
    connectServer();
}