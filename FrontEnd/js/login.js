$(function(){
    $('.member').click(function(){
        $('.m1').css('display','block');
        $('.m2').css('display','none');
<<<<<<< HEAD
        $('.member').addClass('current');
        $('.nomember').removeClass('current');
=======
>>>>>>> e6f04367c1e0edc089d2422050edc72a6813ecae
    });
    $('.nomember').click(function(){
        $('.m2').css('display','block');
        $('.m1').css('display','none');
<<<<<<< HEAD
        $('.nomember').addClass('current');
        $('.member').removeClass('current');
    });
    $('.findId').click(function(){
        $('.m1').css('display','block');
        $('.m2').css('display','none');
        $('.findId').addClass('current');
        $('.findPw').removeClass('current');
    });
    $('.findPw').click(function(){
        $('.m2').css('display','block');
        $('.m1').css('display','none');
        $('.findPw').addClass('current');
        $('.findId').removeClass('current');
    });
    $('input[name=uid]').keydown(function(){
        if($(this).val().trim() != ""){
            $(this).next().css('display','block');
        }else{
            $(this).next().css('display','none');
        }
    });
    $('input[name=name]').keydown(function(){
        if($(this).val().trim() != ""){
            $(this).next().css('display','block');
        }else{
            $(this).next().css('display','none');
        }
    });
    $('.close').click(function(){
        $(this).prev().val("");
        $(this).css('display','none');
=======
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
>>>>>>> e6f04367c1e0edc089d2422050edc72a6813ecae
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