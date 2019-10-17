var Notifications;

Notifications = class Notifications {
  constructor() {
    this.handleClick = this.handleClick.bind(this);
    this.handleSuccess = this.handleSuccess.bind(this);
    this.notifications = $("[data-behavior='notifications']");
    if (this.notifications.length > 0 ) {
      this.setup();
    }
  }

  setup() {
    $("[data-behavior='notifications-link']").on("click", this.handleClick);
    return $.ajax({
      url: "/notifications.json",
      dataType: "JSON",
      method: "GET",
      success: this.handleSuccess
    });
  }

  handleClick(e) {
    if ($("[data-behavior='unread-count']").text() === "0"){
      return
    }
    else {
    return $.ajax({
      url: "/notifications/mark_as_read",
      dataType: "JSON",
      method: "POST",
      success: function() {}
    }, $("[data-behavior='unread-count']").text(0));
  }
  }

  handleSuccess(data) {
    var items;
    items = $.map(data, function(notification) {
      return `<a class='dropdown-item' href= # > ${notification.action}.</a>`;
    });
    $("[data-behavior='unread-count']").text(items.length);
    return $("[data-behavior='notification-items']").html(items);
  }

};

$(function() {
  return new Notifications;
});