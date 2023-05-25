$(function(){
    $('.cate').mouseenter(function(){
        $(this).children('ul').css('display','block');
        $(this).children('.cate1').css('color',"#c59e51");
    });
    $('.cate').mouseleave(function(){
        $(this).children('ul').css('display','none');
        $(this).children('.cate1').css('color',"#212121");
    });
    $(window).scroll(function(){
        let now = $(document).scrollTop();
        console.log(now);
        if(now >= 200){
            $('.moveNavi').css({'position':'fixed','top':'-70px','background':'rgba(255,255,255,0.8)'});
            $('.up').fadeIn(500);
        }else{
            $('.moveNavi').css({'position':'absolute','top':'-21px'});
            $('.up').fadeOut(500);
        }
    });
    $('.up').click(function(){
        $('html, body').animate({
            scrollTop: 0
        },300);
    });
    $('.bestItem').mouseenter(function(){
        $(this).children('.bestDescript').fadeIn(200);
    });
    $('.bestItem').mouseleave(function(){
        $(this).children('.bestDescript').fadeOut(100);
    });
});