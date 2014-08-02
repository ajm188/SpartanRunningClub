function show_hide_form (link_id, form_id, cancel_link_id) {
    show_form_on_click(link_id, form_id);
    hide_form_on_submit(link_id, form_id);
    cancel_form(cancel_link_id, link_id, form_id);
}

function show_form_on_click (link_id, form_id) {
    $(link_id).click(function(event) {
        $(this).toggle();
        var form = $(form_id);
        if (form.html() !== '') {
            // Don't bother hitting the server
            form.toggle();
            return false;
        }
    });
}

function hide_form_on_submit (link_id, form_id) {
    $(form_id).on('ajax:beforeSend', function(event, xhr, settings) {
        $(link_id).toggle();
        $(form_id).html('');
    });
}

function cancel_form (cancel_link_id, show_link_id, form_id) {
    $(document).on('click', cancel_link_id, function(event) {
        $(show_link_id).show();
        $(form_id).hide();
        event.preventDefault();
    });
}
