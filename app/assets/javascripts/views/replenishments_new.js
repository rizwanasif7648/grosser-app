com.healApp.ReplenishmentsNew = {
    init: function () {
        self = this;
        self.replenishments_new();
        self.replenishments_table = null;
    },
    replenishments_new: function () {
        $(document).ready(function () {
            $('#replenishment_submit').prop('disabled', true);
            $(".profile-picture-trigger").on("click", function (e) {
                $("#replenishment_photo").trigger("click");
            })
            $("#replenishment_photo").change(function(e){
                if(this.files.length){
                    $("input.profile-picture-trigger").val(this.files[0].name)
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
            $("#replenishment_form").validate({ignore: []});
            jQuery.validator.addClassRules("required", {
                required: true,
                normalizer: function (value) {
                    return $.trim(value);
                }
            });
        })

        $(document).on("change", "#replenishment_customer_id", function (e) {
            var customer_id;
            customer_id = $('#replenishment_customer_id').val();
            if (customer_id !== "") {
                return $.ajax({
                    type: "GET",
                    url: "/customer_boxes",
                    dataType: "html",
                    data: {
                        customer_id: customer_id,
                        type: 'all'
                    },
                    success: function (data) {
                        return $("#replenishment_box_id").html(data);
                    },
                    error: function (e) {
                        return console.log(e);
                    }
                });
            }
        });

        $(document).on("change", "#replenishment_box_id", function (e) {
            var box_id;
            box_id = $('#replenishment_box_id').val();
            if (box_id !== "") {
                return $.ajax({
                    type: "GET",
                    url: "/box_location",
                    dataType: "html",
                    data: {
                        box_id: box_id
                    },
                    success: function (data) {
                        return $("#replenishment_location").val(data);
                    },
                    error: function (e) {
                        return console.log(e);
                    }
                });
            }
            else {
                $("#replenishment_location").val('');
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

        $('form').on("click", ".line_items", function(e) {
            $('#line_items_table').removeClass('d-none');
        });

        $("#replenishment_product_id").autocomplete({
            source: function (request, response) {
                $.ajax({
                    type: "get",
                    url: "/boxes/search_product_box",
                    data: {search: request.term, id: $('#replenishment_box_id').val()},
                    dataType: "json",
                    success: function (data) {
                        response(data);
                    }
                });
            },
            minLength: 0,
            select: function (event, ui) {
                if (ui.item.id) {
                    $('#selected_product_picture').val(ui.item.photo.url)
                    $('#selected_product_name').val(ui.item.label)
                    $('#selected_product_id').val(ui.item.id)
                    $('#selected_product_expiry').val(ui.item.expiry)
                    $('#selected_product_box').val(ui.item.box_id)
                    $('#selected_product_box_code').val(ui.item.box_code)
                    self.is_selected_product_expired(ui.item)
                    $('.add_fields').prop('disabled', false);
                } else {
                    return false;
                }
            },
        }).focus(function () {
            $(this).autocomplete("search", "");
        });

        $('form').on('click', '.remove_record', function(event) {
            $(this).prev('input[type=hidden]').val('1');
            $(this).closest('tr').hide();
            $(this).closest('tr').next('tr').hide();
            // To check the visibility of nested rows (data map in 2 rows of table)
            if(($("tbody > tr:visible").length -1 ) /2 == 0)
            {
                $('#replenishment_submit').prop('disabled', true);
            } else {
                $('#replenishment_submit').prop('disabled', false);
            }
            return event.preventDefault();
        });

        $('form').on('click', '.add_fields', function(event) {
            var regexp, time;
            time = new Date().getTime();
            regexp = new RegExp($(this).data('id'), 'g');
            $('.fields').append($(this).data('fields').replace(regexp, time));
            $('#product_name').attr("id","product_name_"+time).html("<b>"+$('#selected_product_name').val()+"</b>");
            var imgTag = '<img src="' + $('#selected_product_picture').val() + '"/>';
            $('#product_picture').attr("id","product_picture_"+time).html(imgTag);
            $('#replenishment_replenishment_line_items_attributes_'+time+'_product_id').val($('#selected_product_id').val());
            $('#replenishment_replenishment_line_items_attributes_'+time+'_customer_id').val($('#replenishment_customer_id').val());
            $('#replenishment_replenishment_line_items_attributes_'+time+'_box_id').val($('#selected_product_box').val());
            $("label[for='"+'replenishment_replenishment_line_items_attributes_'+time+'_box_id'+"']").text($('#selected_product_box_code').val());
            $('#replenishment_replenishment_line_items_attributes_'+time+'_quantity_before').val($('#selected_product_quantity_before').val());
            $('#replenishment_replenishment_line_items_attributes_'+time+'_product_name').val($('#selected_product_name').val());
            if ($('#selected_product_expiry').val()) {
                $('#replenishment_replenishment_line_items_attributes_'+time+'_expiry_before').val($('#selected_product_expiry').val());
            }
            else {
                $('#replenishment_replenishment_line_items_attributes_'+time+'_expiry_before').val('N/A');
                $('#replenishment_replenishment_line_items_attributes_'+time+'_expiry_after').val('N/A').removeAttr('required').prop("disabled", true);
            }
            $("label[for='"+'replenishment_replenishment_line_items_attributes_'+time+'_quantity_before'+"']").text($('#selected_product_quantity_before').val());
            $('#replenishment_submit').prop('disabled', false);
            var label = $('#error-quantity').attr("id",'replenishment_replenishment_line_items_attributes_'+time+'_quantity-error');
            $('.add_fields').prop('disabled', true);
            self.check_threshold($('#replenishment_replenishment_line_items_attributes_'+time+'_product_id').val(), $('#replenishment_replenishment_line_items_attributes_'+time+'_box_id').val(), label, $('#replenishment_replenishment_line_items_attributes_'+time+'_quantity').val());
            $('#replenishment_product_id').val('')
            return event.preventDefault();
        });

        $(document).on("change", ".quantity-increase", function (e) {
            var time = $(this)[0].name.split("]")[1].split("[")[1];
            var quantity = $(this).val();
            var product_id = $('#replenishment_replenishment_line_items_attributes_'+time+'_product_id').val()
            var box_id = $('#replenishment_replenishment_line_items_attributes_'+time+'_box_id').val();
            var label = $('#replenishment_replenishment_line_items_attributes_'+time+'_quantity-error');
            self.check_threshold(product_id, box_id, label, quantity);
        });

        $('.add_fields').prop('disabled', true);

        $('form').on('click', '.remove_upload', function(event) {
            self.removefiles($(this));
            return event.preventDefault();
        });

        $('.upload_photo').on('click', function(event) {
            $('#uploads_table').removeClass('d-none');
            var regexp, time;
            time = new Date().getTime();
            regexp = new RegExp($(this).data('id'), 'g');
            $('.upload_fields').append($(this).data('fields').replace(regexp, time));
            self.upload_attachment(time)
            $('.upload_photo').prop('disabled', true);
            $('#replenishment_photo').val('')
            $('#replenishment_note').val('')
            $('#picture_input').val('')
            return event.preventDefault();
        });

        $('.upload_photo').prop('disabled', true);
    },
    is_selected_product_expired: function (item) {
        product_expiry = new Date($('#selected_product_expiry').val());
        current_date = new Date();
        if(product_expiry < current_date){
            $('#selected_product_quantity_before').val(0)
        }
        else{
            $('#selected_product_quantity_before').val(item.qunatity_before)
        }
    },
    upload_attachment: function (time) {
        var photo = $('#replenishment_photo')[0].files[0];
        var note = $('#replenishment_note').val();
        var data = new FormData();
        data.append('file', photo);
        data.append('note', note);
        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: "/uploadfiles",
            data: data,
            success: function (data) {
                $('#replenishment_uploads_attributes_'+time+'_id').val(data.id);
                $('#replenishment_uploads_attributes_'+time+'_photo').attr("src", data.photo);
                $('#replenishment_uploads_attributes_'+time+'_note').val(data.note);
            }
        });
    },
    check_threshold: function (product_id, box_id, label, quantity) {
        return $.ajax({
            type: "GET",
            url: "/boxes/product_boxes_threshold",
            data: {
                product_id: product_id,
                box_id: box_id
            },
            success: function (data) {
                if(data.threshold > quantity) {
                    $(label).text("must be greater than threshold value" + " " + data.threshold);
                    $('#replenishment_submit').prop('disabled', true);
                } else {
                    $(label).text("")
                    if ($('.error-quantity').text() == "") {
                        $('#replenishment_submit').prop('disabled', false);
                    }
                }
            }
        });
    },
    removefiles: function (tr) {
        var upload_id = parseInt(tr.closest('tr')[0].children[0].value)
        $.ajax({
            type: "DELETE",
            url: "/removefiles",
            data: {
                upload_id: upload_id
            },
            success: function(data) {
                tr.prev('input[type=hidden]').val('1');
                tr.closest('tr').hide();
            }
        });
    }
}

com.healApp.ReplenishmentsCreate = com.healApp.ReplenishmentsNew
