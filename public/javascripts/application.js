// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
	$(".submit").button();
    $("#accordion").accordion({autoHeight: false});
});

function display_time_to_reboot() {
    var timer = $.timer(function() {
        if( time_left > 0 ) {
          time_left--;
        }
        var minutes = Math.floor(time_left/60);
        var seconds = time_left - minutes * 60;
        $("#timer_display").html(minutes+" minutes, "+seconds+" seconds");
    });
    timer.set({ time : 1000, autostart : true });
}