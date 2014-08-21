function autocomplete_with_hidden_id(autocomplete_id, hidden_id, source) {
    $(autocomplete_id).autocomplete({
        source: source,
        select: function (event, ui) {
            event.preventDefault();
            $(this).val(ui.item.label);
            $(hidden_id).val(ui.item.value);
        }
    });
}

function autocomplete_keydown(autocomplete_id, multiples) {
    $(autocomplete_id).bind('keydown.autocomplete', function(event) {
        var keyCode = $.ui.keyCode;
        switch (event.keyCode) {
            case keyCode.PAGE_DOWN:
            case keyCode.DOWN:
                set_value($(this), keyCode);
                break;
            case keyCode.PAGE_UP:
            case keyCode.UP:
                var menu = $('ul.ui-menu');
                var menu_visible = false;
                if (multiples) {
                    menu.each(function () {
                        menu_visible = menu_visible || $(this).css('display') != 'none';
                    });
                } else {
                    menu_visible = menu.first().css('display') != 'none';
                }
                if (menu_visible) {
                    set_value($(this), keyCode);
                }
                break;
        }
    });
}

function set_value (input, keyCode) {
    var keyEvent = $.Event('keydown');
    keyEvent.keyCode = keyCode.ENTER;
    input.trigger(keyEvent);
}
