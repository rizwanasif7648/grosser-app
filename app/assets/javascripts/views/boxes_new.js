com.healApp.BoxesNew = {
  init: function () {
    self = this;
    self.boxes_new();
    self.init_datatable();
  },
  init_datatable: function () {
    table = $('#incident_table').DataTable({
      "order": false,
      "pageLength": 50,
      "bPaginate": true,
      "bLengthChange": false,
      "bFilter": true,
      "bInfo": true,
      "bAutoWidth": true,
      "scrollY": "600px",
      "sDom": '<"row view-filter"<"col-sm-12"<"pull-left"l><"pull-right"f><"clearfix">>>t<"row view-pager"<"col-sm-12"<"text-center"ip>>>',
      "oLanguage": {
        "oPaginate": {
          "sNext": '<i class="fa fa-chevron-right"></i>\n',
          "sPrevious": '<i class="fa fa-chevron-left"></i>\n',
        }
      }
    });
  },
  boxes_new: function () {
    $(document).ready(function () {
      self.box_validations();

      $.fn.inputFilter = function (inputFilter) {
        // return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function () {
        return this.on("input keydown keyup", function () {
          if (inputFilter(this.value)) {
            this.oldValue = this.value;
            this.oldSelectionStart = this.selectionStart;
            this.oldSelectionEnd = this.selectionEnd;
          } else if (this.hasOwnProperty("oldValue")) {
            this.value = this.oldValue;
            this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
          }
          this.focus();
        });
      };
      $.validator.addMethod('lessthan', function (value, element, param) {
        return this.optional(element) || parseInt(value) <= parseInt($(param).val());
      }, 'Invalid value')

      $(function()
      {
        $('a[data-toggle="tab"]').on('show.bs.tab', function () {
          //save the latest tab;
          localStorage.setItem('active_box_tab', $(this).attr('href'));
        });

        //go to the latest tab, if it exists:
        var lastTab = localStorage.getItem('active_box_tab');
        if (lastTab) {
          $('a[href="' + lastTab + '"]').tab('show');
        }
        else
        {
          // Set the first tab if cookie do not exist
          $('a[data-toggle="tab"]:first').tab('show');
        }
      });


      $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        self.toggle_add_buttons($(this).attr('data-tab'));
      });
    });

    $('.minus').click(function () {
      var $input = $(this).parent().find('input');
      var count = parseInt($input.val()) - 1;
      count = count < 1 ? 1 : count;
      $input.val(count);
      $input.change();
      return false;
    });
    $('.plus').click(function () {
      var $input = $(this).parent().find('input');
      $input.val(parseInt($input.val()) + 1);
      $input.change();
      return false;
    });

    $(document).ready(function () {
      $('#box_customer_id').on('change', function () {
        $('input[type=hidden]#box_user_boxes_attributes_0_customer_id').val(this.value);
      });
    })

    $(document).on("change", "#box_customer_id", function (e) {
      var customer_id;
      customer_id = $('#box_customer_id').val();
      if (customer_id !== "") {
        return $.ajax({
          type: "GET",
          url: "/customer_users",
          dataType: "html",
          data: {
            customer_id: customer_id
          },
          success: function (data) {
            return $("#box_user_boxes_attributes_0_user_id").html(data);
          },
          error: function (e) {
            return console.log(e);
          }
        });
      }
    });

  },
  box_validations: function () {
    $("#box_form").validate({
      rules: {
        "box[min_products]": {
          lessthan: $('#box_max_products')
        }
      },
      ignore: [],
      messages: {
        "box[min_products]": {
          lessthan: "Must be less than max products",
        }
      }
    });
    jQuery.validator.addClassRules("required", {
      required: true,
      normalizer: function (value) {
        return $.trim(value);
      }
    });
  },
  toggle_add_buttons: function (active_tab) {
    switch(active_tab) {
      case 'product_tab':
        $('.add_user_btn').addClass("d-none");
        $('.add_product_btn').removeClass("d-none");
        break;
      case 'incident_tab':
        $('.add_product_btn').addClass("d-none");
        $('.add_user_btn').addClass("d-none");
        break;
      default:
        $('.add_product_btn').addClass("d-none");
        $('.add_user_btn').removeClass("d-none");
    }
  }
}
// #Haroon:s In case of error, server renders create route and JS doesn't work. So I had to add this work around
com.healApp.BoxesCreate = com.healApp.BoxesNew
com.healApp.BoxesEdit = com.healApp.BoxesNew
com.healApp.BoxesUpdate = com.healApp.BoxesNew
com.healApp.BoxesShow = com.healApp.BoxesNew