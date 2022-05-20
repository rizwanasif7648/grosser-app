com.healApp.IncidentsNew = {
  init: function () {
    self = this;
    self.incidents_new();
  },
  incidents_new: function () {
    $(document).ready(function() {
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
      $("#incident_form").validate({ignore: []});
      jQuery.validator.addClassRules("required", {
        required: true,
        normalizer: function(value) {
          return $.trim(value);
        }
      });
    })

    $(document).on("change", "#incident_customer_id", function(e) {
      var customer_id;
      customer_id = $('#incident_customer_id').val();
      if (customer_id !== "") {
        return $.ajax({
          type: "GET",
          url: "/customer_users",
          dataType: "html",
          data: {
            customer_id: customer_id,
            type: 'all'
          },
          success: function(data) {
            return $("#incident_user_id").html(data);
          },
          error: function(e) {
            return console.log(e);
          }
        });
      }
    });

    $(document).on("change", "#incident_user_id", function(e) {
      var user_id;
      user_id = $('#incident_user_id').val();
      if (user_id !== "") {
        return $.ajax({
          type: "GET",
          url: "/user_boxes",
          dataType: "html",
          data: {
            user_id: user_id
          },
          success: function(data) {
            return $("#incident_box_id").html(data);
          },
          error: function(e) {
            return console.log(e);
          }
        });
      }
    });

    $(document).on("change", "#incident_box_id", function(e) {
      var box_id;
      box_id = $('#incident_box_id').val();
      if (box_id !== "") {
        return $.ajax({
          type: "GET",
          url: "/box_products",
          dataType: "html",
          data: {
            box_id: box_id
          },
          success: function(data) {
            return $("#incident_product_id").html(data);
          },
          error: function(e) {
            return console.log(e);
          }
        });
      }
    });

    $(document).ready(function() {
      $(document).on("click", ".minus", function(e) {
        var $input = $(this).parent().find('input');
        var count = parseInt($input.val()) - 1;
        count = count < 1 ? 1 : count;
        $input.val(count);
        $input.change();
        return false;
      });
      $(document).on("click", ".plus", function(e) {
        var $input = $(this).parent().find('input');
        var count = parseInt($input.val()) + 1;
        count = count < 1 ? 1 : count;
        $input.val(count);
        $input.change();
        return false;
      });
    });

    $( "#incident_product_id" ).autocomplete({
      source: function( request, response ) {
       $.ajax({
          type: "get",
          url: "/boxes/search_product_box",
          data: { search: request.term, id: $('#incident_box_id').val() },
          dataType: "json",
          success: function(data) {
            response( data );
          }
        });
      },
      minLength: 0,
      select: function( event, ui ) {
        if (ui.item.id){
          $('#selected_product_picture').val(ui.item.photo.url)
          $('#selected_product_name').val(ui.item.label)
          $('#selected_product_id').val(ui.item.id)
          $('#selected_product_expiry').val(ui.item.expiry)
          $('.add_fields').prop('disabled', false);
        }
        else{
          return false;
        }
      },
    }).focus(function () {
        $(this).autocomplete("search", "");
    });

    $('form').on('click', '.remove_record', function(event) {
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('tr').hide();
      return event.preventDefault();
    });

    $('form').on('click', '.add_fields', function(event) {
      if(self.is_selected_product_expired()){
        return false;
      }
      $('.submit-btn-div').removeClass("d-none");
      var regexp, time;
      time = new Date().getTime();
      regexp = new RegExp($(this).data('id'), 'g');
      $('.fields').append($(this).data('fields').replace(regexp, time));
      $('#product_name').attr("id","product_name_"+time).html("<b>"+$('#selected_product_name').val()+"</b>");
      var imgTag = '<img src="' + $('#selected_product_picture').val() + '"/>';
      $('#product_picture').attr("id","product_picture_"+time).html(imgTag);
      $('#incident_product_incidents_attributes_'+time+'_product_id').val($('#selected_product_id').val());
      $('#incident_product_incidents_attributes_'+time+'_customer_id').val($('#incident_customer_id').val());
      $('#incident_product_incidents_attributes_'+time+'_box_id').val($('#incident_box_id').val());
      $('.add_fields').prop('disabled', true);
      $('#incident_product_id').val('')
      return event.preventDefault();
    });

    $('.add_fields').prop('disabled', true);

  },
  is_selected_product_expired: function () {
    product_expiry = new Date($('#selected_product_expiry').val());
    current_date = new Date();
    if(product_expiry < current_date){
      htmlData = '<div class="alert alert-danger alert-fade alert-dismissible text-center"> <button class="close" data-dismiss="alert" aria-label="close">x</button>Product already expired </div>';
      $('#expiry_error').html(htmlData);
      return true;
    }
    else{
      $('#expiry_error').html('');
      return false;
    }
  }
}

// #Haroon:s In case of error, server renders create route and JS doesn't work. So I had to add this work around
com.healApp.IncidentsCreate = com.healApp.IncidentsNew
com.healApp.IncidentsEdit = com.healApp.IncidentsNew
com.healApp.IncidentsUpdate = com.healApp.IncidentsNew