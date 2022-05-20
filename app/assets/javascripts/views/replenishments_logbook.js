com.healApp.ReplenishmentsLogbook = {
    init: function () {
        self = this;
        self.replenishments_logbook();
        self.replenishments_table = null;
    },
    replenishments_logbook: function () {
        $(document).ready(function () {
            self.init_datatable();
            $('.buttons-csv, .buttons-pdf').addClass('btn-sm rounded btn-danger');
            $('.buttons-csv').addClass('mr-2');
            $('.dt-buttons').addClass('mt-2');
            $('#selected_customer').on('change', function(){
                Cookies.set('selected_customer', this.value);
                window.location.href='/replenishments/logbook?customer_id='+this.value;
            });

            $('#selected_box').on('change', function(){
                Cookies.set('selected_box', this.value);
                window.location.href='/replenishments/logbook?customer_id='+$('#selected_customer').val()+'&box_id='+this.value;
            });

            $('#selected_product').on('change', function(){
                Cookies.set('selected_product', this.value);
                window.location.href='/replenishments/logbook?customer_id='+$('#selected_customer').val()+'&box_id='+$('#selected_box').val()+'&product_id='+this.value;
            });
        })
    },
    init_datatable: function () {
        self.replenishments_table = $('#replenishments_table').DataTable({
            "bPaginate": true,
            "bLengthChange": false,
            "bFilter": true,
            "bInfo": true,
            "bAutoWidth": true,
            "order": [[ 0, "desc" ]],
            "dom": 'Bfrtip',
            buttons: ['csv', 'pdf'],
            "sDom": '<"row view-filter"<"col-sm-12"<"pull-left"l><"pull-right"f><"clearfix">>>t<"row view-pager"<"col-sm-12"<"text-center"ip>>>',
            "oLanguage": {
                "oPaginate": {
                    "sNext": '<i class="fa fa-chevron-right"></i>\n',
                    "sPrevious": '<i class="fa fa-chevron-left"></i>\n',
                }
            },
        });
    }
}