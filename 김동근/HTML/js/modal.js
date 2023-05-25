$(function(){
    let prevChkColor = -1;
    let prevChkSize = -1;
    let index;
    $('#optionTable td > div.color > input[name=chkColor]').click(function(){
        //클릭시 설정
        index = $(this).index('input[name=chkColor]');
        if(prevChkColor == index){
            $(this).prop('checked', false);
            prevChkColor = -1;
        }else{
            prevChkColor = index;
        }
        //선택 해제시 설정
        let isChecked = $('#optionTable td > div.color > input[name=chkColor]').is(':checked');
        if(isChecked){
            $('#optionTable td > div.size > input[name=chkSize]').prop('disabled', false);
        }else{
            $('#optionTable td > div.size > input[name=chkSize]').prop('disabled', 'disabled');
            $('#optionTable td > div.size > input[name=chkSize]').prop('checked', false);
            prevChkColor = -1;
            prevChkSize = -1;
        }
    });

    $('#optionTable td > div.size > input[name=chkSize]').click(function(){
        //클릭시 설정
        index = $(this).index('input[name=chkSize]');
        if(prevChkSize == index){
            $(this).prop('checked', false);
            prevChkSize = -1;
        }else{
            prevChkSize = index;
        }
    });

    $('div.com-footer > .btn-primary').click(function(){
        if($('#optionTable td > div.size > input[name=chkSize]').is(':checked')){
            let color = $('#optionTable td > div.color > input[name=chkColor]:checked').val();
            let size = $('#optionTable td > div.size > input[name=chkSize]:checked').val();
            console.log(color);
            console.log(size);
        }else{
            alert('옵션을 선택해주세요');
            return;
        }
        
    });
});