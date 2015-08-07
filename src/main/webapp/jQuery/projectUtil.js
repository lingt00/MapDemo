/**
 * Created by IntelliJ IDEA
 * User: lingTao on 2015/6/19 9:36.
 * function:本项目常用方法
 */


function refreshDiv(par,child){
    child.appendTo(par).trigger('create');
}

function mScrollTo(id){
    $("html,body").stop(true);
    $("html,body").animate({scrollTop: $("#"+id).offset().top}, 1000);
}
