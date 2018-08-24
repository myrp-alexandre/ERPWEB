$(document).on('submit', 'form', function () {
    var buttons = $(this).find('[type="submit"]');
    if ($(this).valid()) {
        buttons.each(function (btn) {
            $(buttons[btn]).prop('disabled', true);
        });
    } else {
        buttons.each(function (btn) {
            $(buttons[btn]).prop('disabled', false);
        });
    }
});