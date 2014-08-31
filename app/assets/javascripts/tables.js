function fix_cell_widths () {
    $('td').each(function() {
        $(this).width($(this).width() + 'px');
    });
}
