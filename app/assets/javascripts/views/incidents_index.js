com.healApp.IncidentsIndex = {
    init: function () {
        self = this;
        self.incidents_index();
        self.incidents_table = null;
    },
    incidents_index: function () {
        $(document).ready(function() {
            self.init_datatable();

            $('#selected_customer').on('change', function(){
                Cookies.set('selected_customer', this.value)
                window.location.href='/incidents?customer_id='+this.value;
            });
        })
        $(".incident_request_img").click(function() {
            $('#myOverlay').show();
            $('#full_screen_image').prepend('<img class="img-fluid" src="' + $(this).data('id') + '" />');
            $('#full_screen_image').show()
        });
        $('#myOverlay').click(function(){
            $('#full_screen_image').empty()
            $('#myOverlay, #full_screen_image').hide();
        });
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
            "sDom": '<"row view-filter"<"col-sm-12"<"pull-left"l><"pull-right"f><"clearfix">>>t<"row view-pager"<"col-sm-12"<"text-center"ip>>>',
            "oLanguage": {
                "oPaginate": {
                    "sNext": '<i class="fa fa-chevron-right"></i>\n',
                    "sPrevious": '<i class="fa fa-chevron-left"></i>\n',
                }
            }
        });
        $('#incidents_search_field').on('keyup keypress change', function() {
            table.search(this.value).draw();
        });
    }
}