$(function(){
    let div = document.querySelector('div.wrap-left');
    let position = div.getBoundingClientRect();
    let bottom = position.bottom + window.pageYOffset;
    $(window).scroll(function(){
        let now = $(document).scrollTop();
        if(bottom <= (now+850)){
            $('div.wrap-right').css({'position':'absolute', 'top':'610px', 'right': position.left});
        }else if(now >= 130){
            $('div.wrap-right').css({'position':'fixed', 'top':'130px', 'right': position.left});
        }
        else{
            $('div.wrap-right').css({'position':'static'});
        }
    });
});