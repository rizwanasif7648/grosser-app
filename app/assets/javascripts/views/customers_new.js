com.healApp.CustomersNew = {
  init: function () {
    self = this;
    self.customers_new();
  },
  customers_new: function () {
    $(document).ready(function() {
      self.city_state_country_select();
      $("#customer_industry").val($("#industry").val()); // To retain industry value
      self.customer_validations();
    })
  },
  customer_validations: function(){
    $("#customer_form").validate({
      rules: {
        "customer[name]": {
          required: true,
          maxlength: 70
        },
        "customer[url]": {
          required: false,
          pattern: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/,
          maxlength: 2000,
        },
        "customer[email]": {
          required: true,
          pattern: "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*",
          email: true,
          maxlength: 255,
        },
        "customer[phone]": {
          required: true,
          pattern: /\+(?:[0-9] ?){6,14}[0-9]/,
          maxlength: 15
        },
        "customer[street_address]": {
          required: true,
          maxlength: 100
        },
        "customer[country]": {
          required: true,
        },
        "customer[state]": {
          required: true,
        },
        "customer[city]": {
          required: true,
        },
        "customer[postcode]": {
          required: true,
          maxlength: 15
        },
        "customer[status]": {
          required: true,
        }
      },
      ignore: [],
      messages: {
        "customer[name]": {
          required: "customer name is required",
          maxlength: "customer name cannot be more than 70 characters"
        },
        "customer[url]": {
          pattern: "please enter a valid url",
          maxlength: "url cannot be more than 2000 characters long",
        },
        "customer[email]": {
          required: "customer email is required",
          pattern: "please enter a valid email",
          email: "please enter a valid email",
          maxlength: "url cannot be more than 255 characters long",
        },
        "customer[phone]": {
          required: "customer phone is required",
          pattern: "please enter a valid phone e.g +xxxxxxxxxxxxxx",
          maxlength: "phone cannot be more than 15 characters long",
        },
        "customer[street_address]": {
          required: "customer address is required",
          maxlength: "address cannot be more than 100 characters long"
        },
        "customer[country]": {
          required: "customer country is required",
        },
        "customer[state]": {
          required: "customer state is required",
        },
        "customer[city]": {
          required: "customer city is required",
        },
        "customer[postcode]": {
          required: "customer postcode is required",
          maxlength: "postcode cannot be more than 15 characters long"
        },
        "customer[status]": {
          required: "customer status is required",
        }
      },
      errorPlacement: function(error, element) {
        if (element.is('select') && element.hasClass('extended-form-control')){
          error.insertAfter(element.parent().find('.select2-container'));
        }
        else{
          error.insertAfter(element);
        }
      }
    });
    jQuery.validator.addClassRules("required", {
      required: true,
      normalizer: function(value) {
        return $.trim(value);
      }
    });
  },
  city_state_country_select: function(){
    $("#customer_country").change(function() {
      url = "/states?country=" + $("#customer_country").val();
      self.state_ajax(url, 'state');
    });

    $("#customer_state").change(function() {
      url = "/cities?country=" + $("#customer_country").val() + "&state=" + $("#customer_state option:selected").attr('data-key');
      self.city_ajax(url, 'city');
    });

    url = "/states?country=" + $("#customer_country").val();
    self.state_ajax(url, 'state');

  },
  add_options_set_value: function(options, elm, value=''){
    element = $('#customer_'+elm);
    element.empty();
    element.append( $('<option disabled="true" selected="true">Select ' + elm + '</option>'));
    $.each(options, function (key, value) {
      var opt = '<option data-key="'+key+'" value="'+ value +'">' + value + '</option>';
      element.append(opt);
    });
    if (value != '')
    {
      element.val(value)
    }
  },
  state_ajax: function(url, elm){
    $.ajax({
      type: 'GET',
      url: url,
      success: function(data) {
        state_list = data
        self.add_options_set_value(state_list['states'], elm, $('#'+elm).val());
        url = "/cities?country=" + $("#customer_country").val() + "&state=" + $("#customer_state option:selected").attr('data-key');
        self.city_ajax(url, 'city');
      },
      error: function(error) {
        console.log(error)
      }
    });
  },
  city_ajax: function(url, elm){
    $.ajax({
      type: 'GET',
      url: url,
      success: function(data) {
        city_list = data
        self.add_options_set_value(city_list["cities"], elm, $('#'+elm).val());
      },
      error: function(error) {
        console.log(error)
      }
    });
  }
}
// #Haroon:s In case of error, server renders create route and JS doesn't work. So I had to add this work around
com.healApp.CustomersCreate = com.healApp.CustomersNew
com.healApp.CustomersEdit = com.healApp.CustomersNew
com.healApp.CustomersUpdate = com.healApp.CustomersNew