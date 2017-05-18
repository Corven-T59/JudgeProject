App.web_notifications = App.cable.subscriptions.create("WebNotificationsChannel", {
    connected: function () {
        // Called when the subscription is ready for use on the server
        console.log("connected");
    },

    disconnected: function () {
        // Called when the subscription has been terminated by the server
        console.log("disconected");
    },

    received: function (data) {
        console.log(data);
        var options = {
            content: data["message"], // text of the snackbar
            style: "snackbar", // add a custom class to your snackbar
            timeout: 8000 // time in milliseconds after the snackbar autohides, 0 is disabled
        }

        $.snackbar(options);
    }
});
