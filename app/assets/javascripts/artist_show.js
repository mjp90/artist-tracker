$(document).ready(function() {
  // playTrack();
});

var playTrack = function() {
  SC.initialize({
    client_id: "854f20c74e55b29bf7f90dcdb88a4f04",
  });

  SC.stream("/tracks/137078163", function(sound) {
    sound.play();
  });
} 