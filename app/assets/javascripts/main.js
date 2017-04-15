$(document).on("turbolinks:load", function () {
    // Init material design
    $.material.init();

    // Enable bootstrap date picker
    $("#startDate").datetimepicker();
    $("#endDate").datetimepicker();

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
        toolbar: ".toolbar",

        showRefresh: true,
        search: true,
        showToggle: true,
        showColumns: true,
        striped: true,
        sortable: true,
        iconsPrefix: "fa",

        formatShowingRows: function(pageFrom, pageTo, totalRows){
            //do nothing here, we don't want to show the text "showing x of y from..."
        },
        formatRecordsPerPage: function(pageNumber){
            return pageNumber + " rows visible";
        },
        icons: {
            refresh: 'fa-refresh',
            toggle: 'fa-th-list',
            columns: 'fa-columns',
            detailOpen: 'fa-plus-circle',
            detailClose: 'fa-minus-circle'
        }
    });


    window.operateEvents = {
        'click .like': function (e, value, row, index) {
            alert('You click like icon, row: ' + JSON.stringify(row));
            console.log(value, row, index);
        },
        'click .edit': function (e, value, row, index) {
            alert('You click edit icon, row: ' + JSON.stringify(row));
            console.log(value, row, index);
        },
        'click .remove': function (e, value, row, index) {
            $table.bootstrapTable('remove', {
                field: 'id',
                values: [row.id]
            });

        }
    };
    $alertBtn.click(function () {
        alert("You pressed on Alert");
    });
    $(window).resize(function () {
        $table.bootstrapTable('resetView');
    });

    // End bootstrap table
});

function operateFormatter(value, row, index) {
    return [
        '<a rel="tooltip" title="Like" class="table-action like" href="javascript:void(0)" title="Like">',
        '<i class="fa fa-heart"></i>',
        '</a>',
        '<a rel="tooltip" title="Edit" class="table-action edit" href="javascript:void(0)" title="Edit">',
        '<i class="fa fa-edit"></i>',
        '</a>',
        '<a rel="tooltip" title="Remove" class="table-action remove" href="javascript:void(0)" title="Remove">',
        '<i class="fa fa-remove"></i>',
        '</a>'
    ].join('');
}