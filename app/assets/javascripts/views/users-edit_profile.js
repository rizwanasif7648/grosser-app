com.healApp.UsersEditProfile = {
    init: function () {
        self = this;
        self.users_edit_profile();
    },
    users_edit_profile: function () {
        $(document).ready(function () {
            $(".profile-picture-trigger").on("click", function (e) {
                $("#user_profile_picture").trigger("click");
            })
            $("#user_profile_picture").change(function (e) {
                readURL(this);
            });
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#user_image').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            phone_input = $('#edit_profile_form #phone_input')
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
            self.user_validations();
        });
    },
    user_validations: function(){
        $("#edit_profile_form").validate({
            rules: {
                "user[name]": {
                    required: true,
                    maxlength: 70
                },
                "user[phone]": {
                    required: true,
                    pattern: /\+(?:[0-9] ?){6,14}[0-9]/,
                    maxlength: 15
                }
            },
            ignore: [],
            messages: {
                "user[name]": {
                    required: "User name is required",
                    maxlength: "User name cannot be more than 70 characters"
                },
                "user[phone]": {
                    required: "User phone is required",
                    pattern: "Please enter a valid phone e.g +xxxxxxxxxxxxxx",
                    maxlength: "Phone cannot be more than 15 characters long",
                }
                }
            });
        jQuery.validator.addClassRules("required", {
            required: true,
            normalizer: function(value) {
                return $.trim(value);
            }
        });
    }
}
