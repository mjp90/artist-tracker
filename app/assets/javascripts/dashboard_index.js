$(document).ready(function() {
  initMasonry();
  showArtistInfo();
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