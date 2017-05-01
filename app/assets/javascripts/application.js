// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-ui
//= require_tree .
//FIX THE JS FILE
$(document).on('turbolinks:load', function(){
  //Autocomplete for already registered participants
  var participants = $('#participants').attr('data')
  participants = participants.split(' ')
  $('.auto').autocomplete({
    source: participants,
    autoFocus: true
  })

  var parti = [] //Array which saves all the participants in meeting
  $('.p_block').children().each(function(i) {
    // Fills array with already added participants.
    parti.push($('.p_block').children()[i].innerHTML)
   
  })
  //Adds array to div which is used to send data to meeting model
  document.getElementById('hidden').value = parti.toString()
  
  $('#p_submit').click(function() {
    current_parti = $('.auto').val() //the participant just added
    
    //only adds if participant isn't already in array
    if ($.inArray(current_parti, parti) === -1) {
      //creates new div for every added participant
      var new_part = document.createElement("div")
      new_part.innerHTML = $('.auto').val()
      //adds class so that it can be removed if clicked
      new_part.setAttribute('class', 'part')
      $('.p_block').append(new_part)
      parti.push(current_parti)
      document.getElementById('hidden').value = parti.toString()
    }
  })

  //removes participant from meeting if name is clicked.
  $('.p_block').on("click", ".part", function() {
    $(this).hide()

    var index = $.inArray($(this)[0].innerHTML, parti)
    parti.splice(index, 1)
    document.getElementById('hidden').value = parti.toString()
  })
})
