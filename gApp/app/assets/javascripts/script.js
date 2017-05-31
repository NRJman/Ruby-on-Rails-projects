$(document).ready(function(){
	$('.navbar a.navbar-brand').mouseover(function () {
    	var $this = $(this);
    	if (!$this.is(":animated"))
        	$this.effect("bounce", { times:3 }, 350);
	});

	$('li').hover(function(){$(this).toggleClass('toggle-active');});

	$('li').mouseover(function () {
    	var $this = $(this);
    	if (!$this.is(":animated"))
        	$this.effect("slide", { times:1 }, 1000);
	});

});