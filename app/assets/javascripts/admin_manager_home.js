$(document).ready(function() {
  hideFlashSuccess();
  resetFields();
});

var hideFlashSuccess = function() {
  if ($("#admin_success_message").length) {
    document.body.addEventListener('webkitTransitionEnd', removeElement);
    $("#admin_success_message").addClass('flash_animate_hide');
  }
}

var removeElement = function(event) {
  // $("#admin_success_message").hide();
  $(".admin_section").addClass("admin_move_container_up");
}

var resetFields = function() {
  $("#admin_reset_bt").click(function(e){
    e.preventDefault();
    // $(".admin_artist_tf").val('');

    // Temporary for Tyler
    $(".admin_artist_tf:not(#artist_music_genre)").val('');
  });
}
