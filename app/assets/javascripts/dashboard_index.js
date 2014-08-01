$(document).ready(function() {
  initMasonry();
  showArtistInfo();

  $(document).keyup(function(evt) {
    if (evt.keyCode == 27) {
      var overlay = $("#search_overlay")[0];
      $(overlay).removeClass('show_overlay');
      $(overlay).addClass('overlay_hidden');
      // overlay.style.visibility = "hidden";
      $(".large_search_text").val('');
    }
  });

  // Enter is 13
  // Esc is 27
  $(window).on('keypress', function (evt){
    var overlay = $("#search_overlay")[0]
    // overlay.style.visibility = "visible";
    $(overlay).addClass('show_overlay');
    $(overlay).removeClass('overlay_hidden');
    var currVal = $(".large_search_text").val();
    $(".large_search_text").val(currVal + String.fromCharCode(evt.keyCode));
  });
});

var initMasonry = function() {
  // var artistContainer = $("#artist_list_container");
  // var artistContainer = document.querySelector("#artist_list_container");
  // var masonry = new Masonry(artistContainer);

  $('#artist_blocks_container').masonry({
    isAnimated: false,
    itemSelector: '.artist_block',
    columnWidth: 4,
     // isFitWidth: true,
    transitionDuration: 0
    // isAnimated: !Modernizr.csstransitions
  });
  // .imagesLoaded(function() {
  //  $('#artist_blocks_container').masonry('reload');
  // });
}

var showArtistInfo = function() {
  $(".artist_block").hover(function() {
    // debugger;
    $(this).find(".low").addClass('show_icons');
  }, function() {
    $(this).find(".low").removeClass('show_icons');
  });
} 