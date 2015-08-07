/**
 * Created by lingtao on 15-6-17.
 * upLoadFile
 */

function upLoadImgs( files ,upLoadUrl,fun){
    $.each(files,function(i){
        lrz(this,{
            before: function() {
                console.log('压缩开始');
                showLoader("图片上传中...",false,true);
            },
            fail: function(err) {
                console.error(err);
            },
            always: function() {
                console.log('压缩结束');
                hideLoader();
            },
            done: function (results) {
                // 你需要的数据都在这里，可以以字符串的形式传送base64给服务端转存为图片。
                console.log(results);
                    var retrytimes = 5;
                    var count = 0;
                    $.ajax({
                        async:false,//是否异步
                        cache:false,//是否使用缓存
                        type: "POST",
                        data:{fileData:results.base64,fileSize:results.base64.length,fileName:results.origin.name,fileType:results.origin.type},
                        dataType: "text",
                        timeout: 1000,
                        contentType : 'application/x-www-form-urlencoded; charset=utf-8',
                        url: upLoadUrl,
                        success: function(result){
                            console.log(result);
                            fun(result);
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
            }
        });
    });
}