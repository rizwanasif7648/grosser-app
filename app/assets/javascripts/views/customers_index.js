com.healApp.CustomersIndex = {
  init: function () {
    self = this;
    self.customers_index();
    self.customers_table = null;
  },
  customers_index: function () {
    $(document).ready(function() {
      self.init_datatable();
      // navigate page to view customer on click
      $('#customers_table tbody tr').on('click', function (e) {
        if($(e.target).is('td')){
          window.location.href = $(this).attr('href');
        }
      })
    })
  },
  init_datatable: function () {
    self.customers_table = $('#customers_table').DataTable({
      "order": [
        [1, "asc"]
      ],
      "infoCallback": function( settings, start, end, max, total, pre ) {
        // Haroon: Might be helpful to get current page info
        // var api = this.api();
        // var pageInfo = api.page.info();

        $("#customers_info").text(total+" records");
      },
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
      },
      "columns": [
        { "width": "22.5%" },
        { "width": "22.5%" },
        { "width": "22.5%" },
        { "width": "22.5%" },
        { "width": "10%" },
      ]
    });
    $('#customers_search_field').on('keyup keypress change', function() {
      self.customers_table
        .columns( 1 )
        .search( this.value )
        .draw();
    });
  }
}