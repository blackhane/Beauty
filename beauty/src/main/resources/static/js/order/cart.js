$(function(){
	
	//테이블이 비었으면
	if($('article.cartList > table > tbody').children().length == 0){
		emptyTable();
	}
	
    /* total Table에 쓰이는 변수 */
    let headCnt	= 0;
    let count 	= 0;
	let price 	= 0;
	let delivery= '2,500';
	let disPrice= 0;
	let total 	= 0;
    
	/* 체크박스 처리*/
	/* 전체선택시 */
	$('input[name=chkAll]').click(function(){
		let checkList = $('input[name=chkCart]');
		if($(this).is(":checked")){
		    checkList.prop("checked", true);
		}else{
		    checkList.prop("checked", false);
		}
		check();
	});
	/* 개별선택 -> 모두 체크한 경우 전체선택 자동체크 */
	$('input[name=chkCart]').click(function(){
		let isAll = true;
		$("input[name=chkCart]").each(function(){
	        isAll = isAll && $(this).is(":checked");
	    });
	    $('input[name=chkAll]').prop("checked", isAll);
	    check();
	});
	/* 전부 체크 해제인 경우*/
	function check() {
		if ($("input:checkbox[name='chkCart']").is(":checked")==false) {
			/* 전부 선택 합계 */
			sumAll();
		}else {
			/* 개별 선택 합계 */
			sumChecked();
		}
	}
	
	/* 수량증가 */
	$('#wrap table a.btnIncrease').click(function(e){
		e.preventDefault();
		let cartNo = $(this).parent().parent().parent().children('td:nth-child(1)').children('input[type=checkbox]').val();
		$.ajax({
			url:'/Beauty/order/cartIncrease',
			type:'POST',
			data:{'cartNo': cartNo},
			dataType:'json',
			success:function(data){
				if(data == 1){
					location.reload();				
				}else{
					alert('변경실패');
				}
			}
		});
	});
	
	/* 수량감소 */
	$('#wrap table a.btnDecrease').click(function(e){
		e.preventDefault();
		let amount = parseInt($('count').val());
		if(amount<=1){ 
			alert('1개보다 작게 설정할 수 없습니다.');
			return;
		}
		let cartNo = $(this).parent().parent().parent().children('td:nth-child(1)').children('input[type=checkbox]').val();
		$.ajax({
			url:'/Beauty/order/cartDecrease',
			type:'POST',
			data:{'cartNo': cartNo},
			dataType:'json',
			success:function(data){
				if(data == 1){
					location.reload();				
				}else{
					alert('1개보다 작게 설정할 수 없습니다.');
				}
			}
		});
	});
	
	
	/* tableBtns */
	/* 관심상품등록 */
	$('div.cartFrame > article.cartList > table > tbody td > a.btnTableAddWish').click(function(e){
		e.preventDefault();
		let prodNo = parseInt($(this).parent().children('input').val());
		$.ajax({
			url:'/Beauty/order/addWishFromCart',
			type:'POST',
			data:{'prodNo': prodNo},
			dataType:'json',
			success:function(data){
				if(data == 1){
					alert('등록되었습니다.');
				}else{
				}
			}
		});
	});
	/* 삭제 */
	$('div.cartFrame > article.cartList > table > tbody td > a.btnTableDelete').click(function(e){
		e.preventDefault();
		let tr = $(this).parent().parent();
		let cartNo = parseInt($(this).parent().parent().children('td:first-child').children('input').val());
		$.ajax({
			url:'/Beauty/order/deleteSelectedCart',
			type:'GET',
			data:{'cartNo': cartNo},
			dataType:'json',
			success:function(data){
				if(data == 1){
					tr.remove();
					//테이블이 비었으면
					if($('article.cartList > table > tbody').children().length == 0){
						emptyTable();
					}
				}else{
				}
			}
		});
	});
	
	/* cartBtns */
	/* 카트비우기 */
	$('#btnDeleteAllCart').click(function(e){
		e.preventDefault();
		if(confirm('장바구니를 비우시겠습니까?')){
			$.ajax({
				url:'/Beauty/order/deleteAllCart',
				type:'POST',
				data:{},
				dataType:'json',
				success:function(data){
					if(data == 1){
						emptyTable();
					}else{
					}
				}
			});
		}else{
			return;
		}
	});
	/* 카트 선택 삭제 */
	$('#btnDeleteSelectedCart').click(function(e){
		e.preventDefault();
		let chkList = [];
		$('input[name=chkCart]').each(function(){
			if($(this).is(":checked")){
				chkList.push(parseInt($(this).val()));
			}
		});
		console.log(chkList);
		$.ajax({
			url:'/Beauty/order/deleteSelectedCart',
			type:'POST',
			data:{'chkList': chkList},
			dataType:'json',
			success:function(data){
				if(data == 1){
					for(let chk of chkList){
						//선택된 테이블 삭제
						$('input[name=chkCart]').each(function(){
							if(parseInt($(this).val()) == chk){
								$(this).parent().parent().remove();
							}
						});
					}
					//합계 넣기
					sumAll();
					//테이블이 비었으면
					if($('article.cartList > table > tbody').children().length == 0){
						emptyTable();
					}
				}else{
					alert('1개보다 작게 설정할 수 없습니다.');
				}
			}
		});
	});
	
	/* 빈 카트 */
	function emptyTable(){
		//카트 비었으면
		//테이블, 토탈테이블 삭제, div.emptyCart 삽입
		$('div.cartFrame table').remove();
		$('.cartBtns').remove();
		$('#headCount').text("0");
		$('div.cartFrame > article.cartList').append('<div class="emptyCart">장바구니가 비어 있습니다.</div>');
	}
	
	
	
	
	/* 선택 구분 함수 */	
	function sumChecked(){
		initVal();
		$('input[name=chkCart]').each(function(){
			if($(this).is(":checked")){
				sum($(this));
			}
		});
		checkDelivery();
		inputTotal();
	}
	function sumAll(){
		initVal();
		$('input[name=chkCart]').each(function(){
			sum($(this));
		});
		checkDelivery();
		inputTotal();
	}
	
	/* 실제 기능 구현 함수 */
	function makeNum(nanValue){
		return parseInt(nanValue.split(',').join(""));
	}
	function initVal(){
		headCnt = 0;
		count 	= 0;
		price 	= 0;
		delivery= '2,500';
		disPrice= 0;
		total 	= 0;
	}
	function sum(arg){
		let tds = arg.parent().parent().children();
		headCnt += 1;
		count 	= makeNum(tds[4].children[0].children[0].value);
		price 	+= (makeNum(tds[3].children[0].innerText) * count);
		if(tds[3].children[1] != null){
			disPrice += ( (makeNum(tds[3].children[0].innerText)-makeNum(tds[3].children[2].innerText) ) * count );
		}
		total 	+= makeNum(tds[6].children[0].innerText);
	}
	function checkDelivery(){
		if(total >= 50000){
			delivery = '무료';
		}else{
			delivery = '2,500원';
			total += 2500;
		}
	}
	function inputTotal(){
		$('#totalCount').text(headCnt);
		$('#totalPrice').text(price.toLocaleString()+'원');
		$('#totalDelivery').text(delivery);
		$('#totalDisPrice').text(disPrice.toLocaleString()+'원');
		$('#totalTotalPrice').text(total.toLocaleString()+'원');
	}

});