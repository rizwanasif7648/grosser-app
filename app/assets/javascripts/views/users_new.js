com.healApp.UsersNew = {
  init: function () {
    self = this;
    self.users_new();
  },
  users_new: function () {
    $(document).ready(function() {
      $(".profile-picture-trigger").on("click", function (e) {
        $("#user_profile_picture").trigger("click");
      })
      $("#user_profile_picture").change(function(e){
        if(this.files.length){
          $("input.profile-picture-trigger").val(this.files[0].name)
        }
      });
      phone_input = $('#user_form #phone_input')
      // Restricts input for each element in the set of matched elements to the given inputFilter.
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
      phone_input.inputFilter(function (value) {
        return /^\d*\.?\d*$/.test(value);
      });

      $(".toggle-password").click(function() {

        $(this).toggleClass("fa-eye fa-eye-slash");
        var input = $($(this).attr("toggle"));
        if (input.attr("type") == "password") {
          input.attr("type", "text");
        } else {
          input.attr("type", "password");
        }
      });

      $("#user_customer_id").on('change', function (e) {
        self.get_customer_roles($(this).val());
      })

      if ($('#user_customer_id').val() == "")
      {
          $("#user_customer_id").val($('#user_customer_id option[value!=""]:first').val());
      }
      $("#user_customer_id").trigger('change')
      self.user_validations();
    })

  },
  add_options_set_value: function(options, elm, value=''){
    element = $('#user_'+elm);
    element.empty();
    element.append( $('<option disabled="true" selected="true">Select Role</option>'));
    $.each(options, function (key, obj) {
      var opt = '<option value="'+ obj.id +'">' + obj.title + '</option>';
      element.append(opt);
    });
    if (value != '')
    {
      element.val(value)
    }
  },
  get_customer_roles: function(id){
    $.ajax({
      type: 'GET',
      url: '/customers/roles/'+id,
      success: function(data) {
        self.add_options_set_value(data['roles'], 'role_id', $('#role').val());
      },
      error: function(error) {
        console.log(error)
      }
    });
  },
  user_validations: function(){
    $("#user_form").validate({
      rules: {
        "user[name]": {
          required: true,
          maxlength: 70,
          pattern: /^[a-zA-Z0-9," "]+$/i
        },
        "user[email]": {
          pattern: "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*",
          email: true,
          maxlength: 255,
        },
        "user[customer_id]": {
          required: true
        },
        "user[phone]": {
          required: true,
          pattern: /\+(?:[0-9] ?){6,14}[0-9]/,
          maxlength: 15
        },
        "user[role_id]": {
          required: true
        },
        "user[is_web_user]": {
          required: true
        },
        "user[password]": {
          minlength: 8,
          maxlength: 12
        }
      },
      ignore: [],
      messages: {
        "user[name]": {
          required: "User name is required",
          maxlength: "User name cannot be more than 70 characters",
          pattern: "Only alphanumeric characters are allowed"
        },
        "user[email]": {
          required: "User email is required",
          pattern: "Please enter a valid email",
          email: "Please enter a valid email",
          maxlength: "Email cannot be more than 255 characters long",
        },
        "user[customer_id]": {
          required: "User customer is required",
        },
        "user[phone]": {
          required: "User phone is required",
          pattern: "Please enter a valid phone e.g +xxxxxxxxxxxxxx",
          maxlength: "Phone cannot be more than 15 characters long",
        },
        "user[role_id]": {
          required: "User role is required",
        },
        "user[is_web_user]": {
          required: "User type is required",
        },
        "user[password]": {
          required: "User password is required",
          minlength: "Password should be at least 8 characters long",
          maxlength:  "Password cannot be more than 12 characters long",
        }
      },
    });
    jQuery.validator.addClassRules("required", {
      required: true,
      normalizer: function(value) {
        return $.trim(value);
      }
    });
    $("#user_form").on('submit', function(e){
      fields = $(this).find("input");
      fields.each(function() {
        if ($(this).val() === "" && !$(this).is(':required')) {
          $(this).attr("disabled", "disabled");
        }
      });
    })
  }
}
// #Haroon:s In case of error, server renders create route and JS doesn't work. So I had to add this work around
com.healApp.UsersCreate = com.healApp.UsersNew;
com.healApp.UsersEdit = com.healApp.UsersNew;
com.healApp.UsersUpdate = com.healApp.UsersNew;