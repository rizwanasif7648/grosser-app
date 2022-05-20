com.healApp.ReplenishmentsIndex = {
    init: function () {
        self = this;
        self.replenishments_index();
        self.replenishments_table = null;
    },
    replenishments_index: function () {
        $(document).ready(function () {
            self.init_datatable();
            // navigate page to view customer on click
            $('#replenishments_table tbody tr').on('click', function (e) {
                if($(e.target).is('td')){
                    window.location.href = $(this).attr('href');
                }
            });
            $('.buttons-csv, .buttons-pdf').addClass('btn-sm rounded btn-danger');
            $('.buttons-csv').addClass('mr-2');
            $('.dt-buttons').addClass('mt-2');
            $('#selected_customer').on('change', function(){
                Cookies.set('selected_customer', this.value);
                window.location.href='/replenishments?customer_id='+this.value;
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
        $('#replenishments_search_field').on('keyup keypress change', function () {
            self.replenishments_table
                .columns(2)
                .search(this.value)
                .draw();
        });
    }
}