var $table = $('#fresh-table'),
    $alertBtn = $('#alertBtn'),
    full_screen = false;
$(document).on("turbolinks:load", function () {

    // Enable bootstrap date picker
    console.log("startDate");
    $("#startDate").datetimepicker();
    console.log("endDate");
    $("#endDate").datetimepicker();

    // Search for time and update
    moment.locale("es");
    $("time").each(function () {
        var message = moment($(this).data("time")).fromNow();
        $(this).html(message);
    });

    // Init material design
    $.material.init();

    // Init hipster cards
    var $container = $('.masonry-container');
    doc_width = $(document).width();
    if (doc_width >= 768) {
        $container.masonry({
            itemSelector: '.card-box',
            columnWidth: '.card-box',
            transitionDuration: 0
        });
    } else {
        $('.mas-container').removeClass('mas-container').addClass('row');
    }

    // Upgrade bootstrapTable
    $table.bootstrapTable({
        toolbar: ".toolbar",

        showRefresh: true,
        search: true,
        showToggle: true,
        showColumns: true,
        pagination: true,
        striped: true,
        sortable: true,
        pageSize: 8,
        pageList: [8, 10, 25, 50, 100],

        formatShowingRows: function (pageFrom, pageTo, totalRows) {
            //do nothing here, we don't want to show the text "showing x of y from..."
        },
        formatRecordsPerPage: function (pageNumber) {
            return pageNumber + " rows visible";
        },
        icons: {
            refresh: 'fa fa-refresh',
            toggle: 'fa fa-th-list',
            columns: 'fa fa-columns',
            detailOpen: 'fa fa-plus-circle',
            detailClose: 'fa fa-minus-circle'
        }
    });


});

$(function () {
    $alertBtn.click(function () {
        alert("You pressed on Alert");
    });
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

window.operateEvents = {
    'click .like': function (e, value, row, index) {
        alert('You click like icon, row: ' + JSON.stringify(row));
        console.log(value, row, index);
    },
    'click .edit': function (e, value, row, index) {
        console.log(value, row, index);
    },
    'click .remove': function (e, value, row, index) {
        alert('You click remove icon, row: ' + JSON.stringify(row));
        console.log(value, row, index);
    }
};