$(document).on('ready turbolinks:load', () => {
  triggerButton($('.btn-save-user, .btn-save'), $("form"), 'submit');
  triggerButton($('.btn-trigger-add-question'), $(".btn-add-question"), 'click');
});

var triggerButton = (buttonTrigger, button, event) => {
  buttonTrigger.on('click', (e) => {
    e.preventDefault();
    button.trigger(event);

    if (buttonTrigger.hasClass('btn-trigger-add-question')){
      $("html, body").animate({ scrollTop: $(document).height() }, 1000);
    };
  });
}