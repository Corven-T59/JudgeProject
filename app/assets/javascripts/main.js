$(document).on("turbolinks:load", function () {
    // Init material design
    $.material.init();


    // Search for time and update
    moment.locale("es");
    $("time").each(function () {
        var message = moment($(this).data("time")).fromNow();
        $(this).html(message);
    });


    // Upgrade bootstrapTable
    var $table = $('#fresh-table'),
        $alertBtn = $('#alertBtn'),
        full_screen = false;

    window_height = $(window).height();
    table_height = window_height - 20;

    $table.bootstrapTable({

        //showColumns: true,
        striped: true,
        iconsPrefix: "fa",

        formatShowingRows: function(pageFrom, pageTo, totalRows){
            //do nothing here, we don't want to show the text "showing x of y from..."
        },
        formatRecordsPerPage: function(pageNumber){
            return pageNumber + " rows visible";
        }
    });
    $(window).resize(function () {
        $table.bootstrapTable('resetView');
    });

    // End bootstrap table
});