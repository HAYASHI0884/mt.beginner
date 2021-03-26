document.addEventListener('DOMContentLoaded', function () {
  const ImageList = document.getElementById('image-list');
  document.getElementById('tweet_image').addEventListener('change', function (e) {
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
  });
});
