com.healApp.UsersEditPassword = {
    init: function () {
        self = this;
        self.edit_passwords();
    },
    edit_passwords: function () {
        $(document).ready(function() {
            self.user_validations();
        })

    },
    user_validations: function(){
        $("#edit_password_form").validate({
            rules: {
                "user[current_password]": {
                    required: true
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
                "user[current_password]": {
                    required: "Current Password is required"
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
