$(document).on('click', '.burger-btn', function () {
  $('.burger-btn').toggleClass('close');
  $('.nav-wrapper').toggleClass('slide-in');
  $('body').toggleClass('noscroll');
});
