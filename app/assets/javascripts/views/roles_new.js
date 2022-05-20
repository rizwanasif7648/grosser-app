com.healApp.RolesNew = {
  init: function () {
    self = this;
    self.roles_new();
  },
  roles_new: function () {
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
      $("#role_form").validate({
          rules: {
              "role[title]": {
                  required: true,
                  maxlength: 20
              }
          },
          ignore: [],
          messages: {
              "role[title]": {
                  required: "Role Title is required",
                  maxlength: "Role Title cannot be more than 20 characters"
              }
          }
      });
      jQuery.validator.addClassRules("required", {
        required: true,
        normalizer: function(value) {
          return $.trim(value);
        }
      });
      select_all('create_permission');
      select_all('read_permission');
      select_all('update_permission');
      select_all('delete_permission');

      function select_all(permission_type){
          if ($("." + permission_type + ":checked").length == $('input:checkbox.' + permission_type).length) {
              $("#" + permission_type).prop("checked", true)
          }
      }
      if ($("input[type=checkbox]:not(#all_permission):checked").length == $("input[type=checkbox]:not(#all_permission)").length) {
          $("#all_permission").prop("checked", true)
      }
      $("input[type=checkbox]:not(#all_permission)").on("change", function () {
          $("#all_permission").prop("checked", $("input[type=checkbox]:not(#all_permission):checked").length == $("input[type=checkbox]:not(#all_permission)").length);
      });
      $("#all_permission").on("change", function () {
          $("input[type=checkbox]").prop("checked", $(this).is(":checked"));
      });
    })
    specific_permission('create_permission');
    specific_permission('read_permission');
    specific_permission('update_permission');
    specific_permission('delete_permission');

    function specific_permission(permission_type) {
        $("#" + permission_type).on("change", function () {
            $("." + permission_type).prop("checked", $(this).is(":checked"));
        });
        $("input[type=checkbox]:not(#" + permission_type + ")").on("change", function () {
            $("#" + permission_type).prop("checked", $("." + permission_type + ":checked").length == $('input:checkbox.' + permission_type).length);
        });
    }
  }
}
// #Haroon:s In case of error, server renders create route and JS doesn't work. So I had to add this work around
com.healApp.RolesCreate = com.healApp.RolesNew
com.healApp.RolesEdit = com.healApp.RolesNew
com.healApp.RolesUpdate = com.healApp.RolesNew