//自定义hashtable
function Hashtable() {
    this._hash = new Object();
    this.put = function(key, value) {
        if (typeof (key) != "undefined") {
            if (this.containsKey(key) == false) {
                this._hash[key] = typeof (value) == "undefined" ? null : value;
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    this.remove = function(key) { delete this._hash[key]; }
    this.size = function() { var i = 0; for (var k in this._hash) { i++; } return i; }
    this.get = function(key) { return this._hash[key]; }
    this.containsKey = function(key) { return typeof (this._hash[key]) != "undefined"; }
    this.clear = function() { for (var k in this._hash) { delete this._hash[k]; } }
}

var emotions = new Array();
var categorys = new Array();// 分组
var uSinaEmotionsHt = new Hashtable();

// 初始化缓存，页面仅仅加载一次就可以了
$(function() {
	var app_id = '1362404091';
	$.ajax( {
		dataType : 'jsonp',
		url : 'https://api.weibo.com/2/emotions.json?source=' + app_id,
		success : function(response) {
			var data = response.data;
			for ( var i in data) {
				if (data[i].category == '') {
					data[i].category = '默认';
				}
				if (emotions[data[i].category] == undefined) {
					emotions[data[i].category] = new Array();
					categorys.push(data[i].category);
				}
				emotions[data[i].category].push( {
					name : data[i].phrase,
					icon : data[i].icon
				});
				uSinaEmotionsHt.put(data[i].phrase, data[i].icon);
			}
		}
	});
});

//替换
function AnalyticEmotion(s) {
	if(typeof (s) != "undefined") {
		var sArr = s.match(/\[.*?\]/g);
		for(var i = 0; i < sArr.length; i++){
			if(uSinaEmotionsHt.containsKey(sArr[i])) {
				var reStr = "<img src=\"" + uSinaEmotionsHt.get(sArr[i]) + "\" height=\"20\" width=\"20\" />";
				s = s.replace(sArr[i], reStr);
			}
		}
	}
	return s;
}

(function($){
	$.fn.SinaEmotion = function(target,place){
		var cat_current;
		var cat_page;
        var minHeight = 62;
		$(this).click(function(event){
			event.stopPropagation();
			
			//var eTop = place.offset().top + place.height() + 20;
			//var eLeft = place.offset().left - 1;
			var eTop = 62;
			var eLeft = 0;
            var eWidth = place.width();

			if($('#emotions .categorys')[0]){
				$('#emotions').css({top: eTop, left: eLeft,width:eWidth});
				$('#emotions').toggle();
				return;
			}
			//$('body').append('<div id="emotions"></div>');
			$('#faceContent').append('<div id="emotions"></div>');
            $('#faceContent').css({height:302});
			$('#emotions').css({top: eTop, left: eLeft,width:eWidth});
			$('#emotions').html('<div>正在加载，请稍候...</div>');
			$('#emotions').click(function(event){
				event.stopPropagation();
			});
			
			$('#emotions').html('<div style="float:right"><a href="javascript:void(0);" id="prev">&laquo;</a><a href="javascript:void(0);" id="next">&raquo;</a></div><div class="categorys"></div><div class="containerFace"></div><div class="page"></div>');
			$('#emotions #prev').click(function(){
				showCategorys(cat_page - 1);
			});
			$('#emotions #next').click(function(){
				showCategorys(cat_page + 1);
			});
			showCategorys();
			showEmotions();
			
		});
		$('body').click(function(){
            $('#faceContent').css({height:minHeight});
			$('#emotions').remove();
		});
		$.fn.insertText = function(text){
			this.each(function() {
				if(this.tagName !== 'INPUT' && this.tagName !== 'TEXTAREA') {return;}
				if (document.selection) {
					this.focus();
					var cr = document.selection.createRange();
					cr.text = text;
					cr.collapse();
					cr.select();
				}else if (this.selectionStart || this.selectionStart == '0') {
					var 
					start = this.selectionStart,
					end = this.selectionEnd;
					this.value = this.value.substring(0, start)+ text+ this.value.substring(end, this.value.length);
					this.selectionStart = this.selectionEnd = start+text.length;
				}else {
					this.value += text;
				}
			});        
			return this;
		}
		function showCategorys(){
			var page = arguments[0]?arguments[0]:0;
			if(page < 0 || page >= categorys.length / 5){
				return;
			}
			$('#emotions .categorys').html('');
			cat_page = page;
			for(var i = page * 5; i < (page + 1) * 5 && i < categorys.length; ++i){
				$('#emotions .categorys').append($('<a href="javascript:void(0);">' + categorys[i] + '</a>'));
			}
			$('#emotions .categorys a').click(function(){
				showEmotions($(this).text());
			});
			$('#emotions .categorys a').each(function(){
				if($(this).text() == cat_current){
					$(this).addClass('current');
				}
			});
		}
		function showEmotions(){
			var category = arguments[0]?arguments[0]:'默认';
			var page = arguments[1]?arguments[1] - 1:0;
			$('#emotions .containerFace').html('');
			$('#emotions .page').html('');
			cat_current = category;
			for(var i = page * 72; i < (page + 1) * 72 && i < emotions[category].length; ++i){
				$('#emotions .containerFace').append($('<a href="javascript:void(0);" title="' + emotions[category][i].name + '"><img src="' + emotions[category][i].icon + '" alt="' + emotions[category][i].name + '" width="22" height="22" /></a>'));
			}
			$('#emotions .containerFace a').click(function(){
				//target.insertText($(this).attr('title'));

                target.append($(AnalyticEmotion($(this).attr('title'))));

                $('#faceContent').css({height:minHeight});
                $('#emotions').remove();
			});
			for(var i = 1; i < emotions[category].length / 72 + 1; ++i){
				$('#emotions .page').append($('<a href="javascript:void(0);"' + (i == page + 1?' class="current"':'') + '>' + i + '</a>'));
			}
			$('#emotions .page a').click(function(){
				showEmotions(category, $(this).text());
			});
			$('#emotions .categorys a.current').removeClass('current');
			$('#emotions .categorys a').each(function(){
				if($(this).text() == category){
					$(this).addClass('current');
				}
			});
		}
	}
})(jQuery);
