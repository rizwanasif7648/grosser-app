com.healApp.DevisePasswordsNew = {
  init: function () {
    self = this;
    self.devise_passwords();
  },
  devise_passwords: function () {
    $(document).ready(function() {
      self.user_validations();
    })

  },
  user_validations: function(){
    $("#password_form").validate({
      rules: {
        "user[email]": {
          required: true,
          pattern: "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*",
          email: true,
          maxlength: 255,
        },
        "user[password]": {
          required: true,
        },
        "user[password_confirmation]": {
          required: true,
          equalTo: '#user_password'
        }
      },
      ignore: [],
      messages: {
        "user[email]": {
          required: "Email is required",
          pattern: "Please enter a valid email",
          email: "Please enter a valid email",
          maxlength: "Email cannot be more than 255 characters long",
        },
        "user[password]": {
          required: "Password is required",
        },
        "user[password_confirmation]": {
          required: "Confirm password is required",
          equalTo: "Please enter same password"
        }
      },
    });
    jQuery.validator.addClassRules("required", {
      required: true,
      normalizer: function(value) {
        return $.trim(value);
      }
    });
  }
}

com.healApp.DevisePasswordsCreate = com.healApp.DevisePasswordsNew;
com.healApp.DevisePasswordsEdit = com.healApp.DevisePasswordsNew;