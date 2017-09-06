
var num = 0;
var number;
var carousel = document.getElementById("carousel");
var cardivs = document.getElementById("carousel_btn");
var cardiv = cardivs.getElementsByTagName("div")
var carimg = carousel.getElementsByTagName("img");
show();
var interval = setInterval(show,2400);
function show(){
	carimg[num].style.opacity = "1";
	cardiv[num].style.backgroundColor = "#DB192A";
	for(var i = 0 ; i < carimg.length ; i++){
		if(i==num){
			continue;
		}else{
			cardiv[i].style.backgroundColor = "white";
			carimg[i].style.opacity = "0";
		}
	}
	num++;
	if(num>=8){
		num=0;
	}
	return num;
}

for(var i = 0 ; i < cardiv.length ; i++){
	(function(index){
		cardiv[index].onmouseover = function(){
			clearInterval(interval);
			cardiv[index].style.backgroundColor = "#DB192A";
			carimg[index].style.opacity = "1";
			for(var j = 0 ; j < cardiv.length ; j++){
				if(index==j){
					continue;
				}else{
					cardiv[j].style.backgroundColor = "white";
					carimg[j].style.opacity = "0";
				}
			}
			num = index;
			show();	
		}
		cardiv[index].onmouseout = function(){
			// this.style.backgroundColor = "white";
	
			interval = setInterval(show,2400);
		}
	})(i);
}

$('.scan .input .btn').click(function () {
    var value = $('.scan .input input').val();
    $('.scan .body .input .btn a').attr('href','/search.do?prdName='+value);
});

$(function () {
    $("#search1").keydown(function (e) {
        if (e.keyCode == 13) {
            var value = $('.scan .input input').val();
            window.location.href="/search.do?prdName="+value;
        }
    });
});
