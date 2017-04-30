/**
 * Created by Aldo Rincón Mora on 17-Apr-17.
 */

$(document).on("turbolinks:load", function () {

    $("#new_solution").on("ajax:success", function (e, data, status, xhr) {
            alert("sent");
    });

    $("#new_solution").on("ajax:error", function(e, xhr, status, error){
        alert("Fail");
        alert(error)
    });
});