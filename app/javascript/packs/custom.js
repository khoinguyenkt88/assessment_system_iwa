$(document).on('ready turbolinks:load', () => {
  $('.btn-save-user').on('click', (e) => {
    e.preventDefault();
    $("form").trigger('submit');
  });
});