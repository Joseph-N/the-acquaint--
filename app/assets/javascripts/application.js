// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require fancybox
//= require jquery_ujs
//= require bootstrap
//= require_tree .
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
    $.fn.loadGif = function(){
		$(this).click(function(){
			if(!$('#comment_content').val()){
				alert("Please leave a comment")
			}
			else{
				$('#comment').ajaxStart(function() {
					$(this).hide();
					$('.p-loading').show();
		  		}).ajaxStop(function() {
		  			$('#comment').show();
		  			$('.p-loading').hide();
		  		});
		  	}
		});
    };
})(jQuery);
