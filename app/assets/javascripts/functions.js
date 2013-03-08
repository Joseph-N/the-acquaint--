// My defined functions

jQuery.ajaxSetup({
	'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

// function to count remaining characters in a given text box
(function($){
    $.fn.countChars = function(){
    	var totalChars      = 255; //Total characters allowed in textarea
	    var countTextBox    = this; // Textarea input box
	    var charsCountEl    = $('#count'); // Remaining chars count will be displayed here
	    
	    charsCountEl.text(totalChars); //initial value of countchars element
	    countTextBox.keyup(function() { //user releases a key on the keyboard
	        var thisChars = this.value.replace(/{.*}/g, '').length; //get chars count in textarea
	        if(thisChars > totalChars) //if we have more chars than it should be
	        {
	            var CharsToDel = (thisChars-totalChars); // total extra chars to delete
	            this.value = this.value.substring(0,this.value.length-CharsToDel); //remove excess chars from textarea
	        }else{
	            charsCountEl.text( totalChars - thisChars ); //count remaining chars
	        }
	    });
    };
})(jQuery);

// function to load gif with ajax when submitting comment
(function($){
    $.fn.loadGif = function(image){
		$(this).click(function(){
			if(!$('#comment_content').val()){
				alert("Please leave a comment")
			}
			else{
				$('#count').ajaxStart(function() {
					$('#submit-comment').addClass('disabled');
					$(this).html(image);
		  		}).ajaxStop(function() {
		  			$('#submit-comment').removeClass('disabled');
		  			$(this).text('255');
		  		});
		  	}
		});
    };
})(jQuery);

// rate through ajax
(function($){
	$.fn.raty = function(url){
		$(this).click(function() {
	      	$('#rate-box').slideUp();  
	      	$('.text-success').show();
	      	$.get(url,
            function(data) {
            	$('.text-success').hide().show(1000);
              //update instance after 5 sec
              setTimeout(function() {  
                $('.text-success').slideUp();            	
              	$('.big-rating').text(data.percentage + "%");
                $('.chart').data('easyPieChart').update(data.percentage);
              }, 3000);
            }, "json");
    	});
	};
})(jQuery);

// vote through ajax
(function($){
	$.fn.vote = function(){
		$(this).click(function() {
			$.post($(this).attr('href'), null, null, "script");
          	return false;
    	});
	};
})(jQuery);

// comment through ajax
(function($){
	$.fn.comment = function(){
		$(this).submit(function() {
			$.post($(this).attr('action'), $(this).serialize(), null, "script");
          	return false;
    	});
	};
})(jQuery);

// disable button
(function($){
	$.fn.disable = function(bool){
		if(bool == "true"){
			$(this).addClass('disabled');
		}	
	};
})(jQuery);

// hide div if no comment
(function($){
	$.fn.hideDiv = function(){
		var y = $(this).text();
		if($.trim(y) == 0) {
	       $(this).hide();
	    }
	};
})(jQuery);