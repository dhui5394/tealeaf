$(document).ready(function(){
  form_hit_button();
  form_stay_button();
  form_dealer_play_button();
});

function form_hit_button() {
  $(document).on("click", "form#form_hit_button input", function() {
    $.ajax({
      type: 'POST',
      url: '/play_game/player/hit'
    }).done(function(msg){
      $("div#game").replaceWith(msg);
    });
    return false;
  });
}

function form_stay_button() {
  $(document).on("click", "form#form_stay_button input", function() {
    $.ajax({
      type: 'POST',
      url: '/play_game/player/stay'
    }).done(function(msg){
      $("div#game").replaceWith(msg);
    });
    return false;
  });
}

function form_dealer_play_button() {
  $(document).on("click", "form#form_dealer_play_button input", function() {
    $.ajax({
      type: 'POST',
      url: '/play_game/dealer/play'
    }).done(function(msg){
      $("div#game").replaceWith(msg);
    });
    return false;
  });
}
