// JavaScript Document
// user-addresslist defaultAddr

var arrayBg = [];
var kds = [];
var methods=[];

window.onload = function() {
    arrayBg = document.querySelectorAll(".user-addresslist");
    kds = document.querySelectorAll(".OP_LOG_BTN");
    methods = document.querySelectorAll(".pay");
    for (var i=0;i<methods.length;i++) {
    	methods[i].onclick = chooseMT;
	}
    for (i=0 ;i < kds.length; i++) {
		kds[i].onclick = chooseKd;
	}
    for (i=0 ;i < arrayBg.length; i++) {
        arrayBg[i].index = i;
        arrayBg[i].onclick = chooseBg;
    }
}

function chooseMT() {
	resetMT();
	this.className = "pay selected";
}

function chooseKd() {
	resetKds();
	this.className = "OP_LOG_BTN selected";
}

function chooseBg() {
	resetBg();
	console.log(this);
	this.style.background = 'url("/resources/images/peraddressbg.png")';
}
function resetMT() {
	for (var i=0;i<methods.length;i++){
		methods[i].className="pay";
	}
}
function resetKds() {
	for (var i = 0; i < kds.length; i++) {
		kds[i].className = "OP_LOG_BTN";
	}
}
function resetBg() {
    for (var i=0 ;i < arrayBg.length; i++) {
        arrayBg[i].style.background = 'url("/resources/images/peraddbg.png")';
    }
}