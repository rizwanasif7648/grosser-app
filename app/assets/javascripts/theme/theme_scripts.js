$(document).on('ready page:load', function () {
  (function ($) {
    "use strict"; // Start of use strict

    $(".ajax-call-loader").fadeOut();
    // Toggle the side navigation
    $("#sidebarToggle, #sidebarToggleTop").on('click', function (e) {
      $("body").toggleClass("sidebar-toggled");
      $(".sidebar").toggleClass("toggled");
      if ($(".sidebar").hasClass("toggled")) {
        $('.sidebar .collapse').collapse('hide');
      }
      ;
      e.stopPropagation();
    });

    // Close any open menu accordions when window is resized below 768px
    $(window).resize(function () {
      if ($(window).width() < 768) {
        $('.sidebar .collapse').collapse('hide');
      }
      ;
    });

    // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
    $('body.fixed-nav .sidebar').on('mousewheel DOMMouseScroll wheel', function (e) {
      if ($(window).width() > 768) {
        var e0 = e.originalEvent,
          delta = e0.wheelDelta || -e0.detail;
        this.scrollTop += (delta < 0 ? 1 : -1) * 30;
        e.preventDefault();
      }
    });

    // Scroll to top button appear
    $(document).on('scroll', function () {
      var scrollDistance = $(this).scrollTop();
      if (scrollDistance > 100) {
        $('.scroll-to-top').fadeIn();
      } else {
        $('.scroll-to-top').fadeOut();
      }
    });

    // search limit
    $("input[id$='search_field']").attr('maxLength', 255);

    // Smooth scrolling using jQuery easing
    $(document).on('click', 'a.scroll-to-top', function (e) {
      var $anchor = $(this);
      $('html, body').stop().animate({
        scrollTop: ($($anchor.attr('href')).offset().top)
      }, 1000, 'easeInOutExpo');
      e.preventDefault();
    });
    $("select.extended-form-control").select2();
    var loader = $(".ajax-call-loader");
    $("form").on('submit', function (e) {
      if ($(this).valid()) {
        loader.fadeIn();
      }
    });
    $(document)
      .ajaxStart(function () {
        loader.fadeIn();
      })
      .ajaxStop(function () {
        loader.fadeOut();
      });
    $('#notifications_icon').on('click', function (e) {
      if (!$("#notifications_dropdown").is(":visible")) {
        $('#notifications_dropdown').html('');
        $.ajax({
          type: 'GET',
          url: '/user_notifications',
          success: function (data) {/* response is handled in rails */},
          error: function (error) {}
        });
      }
    });

    var selected_customer = Cookies.get('selected_customer');
    if(selected_customer){
      $("select[id*=customer_id]").val(selected_customer);
      $("select[id*=customer_id]").trigger('change');
    }


  })(jQuery); // End of use strict
})

mark_notification_as_read = function(){
  $.ajax({
    type: 'POST',
    global: false, // This flag is used for those ajax call where loader is not required
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    url: '/mark_notification_as_read',
    success: function (data) {
      $(".unread_notification").removeClass('unread_notification');
      $("#notifications_count").html('');
    },
    error: function (error) {}
  });
}
jQuery.validator.setDefaults({
  errorPlacement: function (error, element) {
    if (element.is('select') && element.hasClass('extended-form-control')) {
      error.insertAfter(element.parent().find('.select2-container'));
    }
    else if(element.hasClass('product_count')){
      error.insertAfter(element.parent());
    }
    else {
      error.insertAfter(element);
    }
  }
});
