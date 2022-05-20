com.healApp.ProductsNew = {
  init: function () {
    self = this;
    self.products_new();
  },
  products_new: function () {
    self.reset_form();
    $(document).ready(function() {
      $(".product-picture-trigger").on("click", function (e) {
        $("#product_photo").trigger("click");
      })
      $("#product_photo").change(function(e){
        if(this.files.length){
          $("input.product-picture-trigger").val(this.files[0].name)
        }
      });
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
      self.product_validations();
    })

  },
  reset_form: function(){
    $("#product_form").trigger('reset');
    $(".btn-user-type").removeClass('active');
    $('input[name="product[is_expirable]"]:checked').parent().addClass('active');

  },
  product_validations: function(){
    $("#product_form").validate({
      rules: {
        "product[code]": {
          required: true,
          maxlength: 20
        },
        "product[name]": {
          required: true,
          maxlength: 50
        },
        "product[description]": {
          required: true,
          maxlength: 70
        },
        "product[category]": {
          required: true,
        },
        "product[status]": {
          required: true,
        },
        "product[asset_type]": {
          required: true,
        }
      },
      ignore: [],
      messages: {
        "product[code]": {
          required: "Product code is required",
          maxlength: "Product code cannot be more than 20 characters"
        },
        "product[name]": {
          required: "Product name is required",
          maxlength: "Product name cannot be more than 50 characters"
        },
        "product[description]": {
          required: "Product description is required",
          maxlength: "Product description cannot be more than 70 characters"
        },
        "product[category]": {
          required: "Product category is required",
        },
        "product[status]": {
          required: "Product status is required",
        },
        "product[asset_type]": {
          required: "Product asset type is required",
        },
        "product[photo]": {
          required: "Product picture is required",
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
// #Haroon:s In case of error, server renders create route and JS doesn't work. So I had to add this work around
com.healApp.ProductsCreate = com.healApp.ProductsNew
com.healApp.ProductsEdit = com.healApp.ProductsNew
com.healApp.ProductsUpdate = com.healApp.ProductsNew