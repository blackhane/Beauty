$(function(){
    $('.member').click(function(){
        $('.m1').css('display','block');
        $('.m2').css('display','none');
    });
    $('.nomember').click(function(){
        $('.m2').css('display','block');
        $('.m1').css('display','none');
    });
    $('input[name=uid]').keydown(function(){
        if($(this).val().trim() != ""){
            $('.close').css('display','block');
        }else{
            $('.close').css('display','none');
        }
    });
    $('.close').click(function(){
        $('input[name=uid]').val("");
        $('.close').css('display','none');
    });
    $('.eye').click(function(){
        let t = $(this).text();
        if(t == "visibility_off"){
            $(this).text("visibility");
            $('input[name=password]').attr('type','text');
        }else{
            $(this).text("visibility_off");
            $('input[name=password]').attr('type','password');
        }
    });
});