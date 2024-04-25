(function($) {

	"use strict";

	document.addEventListener('DOMContentLoaded', function(){
    var today = new Date(),
        year = today.getFullYear(),
        month = today.getMonth(),
        monthTag =["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
        day = today.getDate(),
        days = document.getElementsByTagName('td'),
        selectedDay,
        setDate,
        daysLen = days.length;
// options should like '2014-01-01'
    function Calendar(selector, options) {
        this.options = options;
        this.draw();
    }
    
    Calendar.prototype.draw  = function() {
        this.getCookie('selected_day');
        this.getOptions();
        this.drawDays();
        var that = this,
            reset = document.getElementById('reset'),
            pre = document.getElementsByClassName('pre-button'),
            next = document.getElementsByClassName('next-button');
            
            pre[0].addEventListener('click', function(){that.preMonth(); });
            next[0].addEventListener('click', function(){that.nextMonth(); });
            reset.addEventListener('click', function(){that.reset(); });
        while(daysLen--) {
            days[daysLen].addEventListener('click', function(){that.clickDay(this); });
        }
    };
    
    Calendar.prototype.drawHeader = function(e) {
        var headDay = document.getElementsByClassName('head-day'),
            headMonth = document.getElementsByClassName('head-month');

            e?headDay[0].innerHTML = e : headDay[0].innerHTML = day;
            headMonth[0].innerHTML = monthTag[month] +" - " + year;        
     };
    
    Calendar.prototype.drawDays = function() {
        var startDay = new Date(year, month, 1).getDay(),
            nDays = new Date(year, month + 1, 0).getDate(),
    
            n = startDay;
        for(var k = 0; k <42; k++) {
            days[k].innerHTML = '';
            days[k].id = '';
            days[k].className = '';
        }

        for(var i  = 1; i <= nDays ; i++) {
            days[n].innerHTML = i; 
            n++;
        }
        
        for(var j = 0; j < 42; j++) {
            if(days[j].innerHTML === ""){
                
                days[j].id = "disabled";
                
            }else if(j === day + startDay - 1){
                if((this.options && (month === setDate.getMonth()) && (year === setDate.getFullYear())) || (!this.options && (month === today.getMonth())&&(year===today.getFullYear()))){
                    this.drawHeader(day);
                    days[j].id = "today";
                }
            }
            if(selectedDay){
                if((j === selectedDay.getDate() + startDay - 1)&&(month === selectedDay.getMonth())&&(year === selectedDay.getFullYear())){
                days[j].className = "selected";
                this.drawHeader(selectedDay.getDate());
                }
            }

	        // +10일까지의 날짜를 선택 가능하도록 "selectable" 아이디를 부여합니다.
			var endDate = new Date(year, month, day + 9); 
			if ((j >= day + startDay) && (j <= day + startDay + 9) && (new Date(year, month, j - day - startDay + 1) <= endDate) && (month === today.getMonth()) && (year === today.getFullYear())) {
			    days[j].id = "selectable";
			}

        }
    };
    
	Calendar.prototype.clickDay = function(o) {
	    var selected = document.getElementsByClassName("selected"),
	        len = selected.length;
	    
	    // 현재 달의 시작일과 종료일 설정
	    var startDate = new Date(year, month, day); 
	    var endDate = new Date(year, month, day + 10); 
	    
	    // 클릭한 날짜 설정
	    var clickedDate = new Date(year, month, o.innerHTML);
	    
	    // 클릭한 날짜가 현재 달의 시작일과 종료일 사이에 있는지 확인
	    if (clickedDate >= startDate && clickedDate <= endDate && month === today.getMonth() && year === today.getFullYear()) {
	        if (len !== 0) {
	            selected[0].className = "";
	        }
	        o.className = "selected";
	        selectedDay = new Date(year, month, o.innerHTML);
	        this.drawHeader(o.innerHTML);
	        this.setCookie('selected_day', 1);
	    } else {
	        alert("예약은 당일로부터 10일간만 가능합니다!");
	    }
	};

    
    Calendar.prototype.preMonth = function() {
        if(month < 1){ 
            month = 11;
            year = year - 1; 
        }else{
            month = month - 1;
        }
//        this.drawHeader(1);
        this.drawDays();
    };
    
    Calendar.prototype.nextMonth = function() {
        if(month >= 11){
            month = 0;
            year =  year + 1; 
        }else{
            month = month + 1;
        }
//        this.drawHeader(1);
        this.drawDays();
    };
    
    Calendar.prototype.getOptions = function() {
        if(this.options){
            var sets = this.options.split('-');
                setDate = new Date(sets[0], sets[1]-1, sets[2]);
                day = setDate.getDate();
                year = setDate.getFullYear();
                month = setDate.getMonth();
        }
    };
    
     Calendar.prototype.reset = function() {
         month = today.getMonth();
         year = today.getFullYear();
         day = today.getDate();
         this.options = undefined;
         this.drawDays();
     };
    
//    Calendar.prototype.setCookie = function(name, expiredays){
//        if(expiredays) {
//            var date = new Date();
//            date.setTime(date.getTime() + (expiredays*24*60*60*1000));
//            var expires = "; expires=" +date.toGMTString();
//        }else{
//            var expires = "";
//        }
//        document.cookie = name + "=" + selectedDay + expires + "; path=/";
//    };
    
    Calendar.prototype.getCookie = function(name) {
        if(document.cookie.length){
            var arrCookie  = document.cookie.split(';'),
                nameEQ = name + "=";
            for(var i = 0, cLen = arrCookie.length; i < cLen; i++) {
                var c = arrCookie[i];
                while (c.charAt(0)==' ') {
                    c = c.substring(1,c.length);
                    
                }
                if (c.indexOf(nameEQ) === 0) {
                    selectedDay =  new Date(c.substring(nameEQ.length, c.length));
                }
            }
        }
    };
    var calendar = new Calendar();
    
        
}, false);

})(jQuery);
