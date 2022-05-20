com.healApp.ReportsIndex = {
  init: function () {
    self = this;
    self.reports_index();
    self.reports_table = null;
  },
  reports_index: function () {
    $(document).ready(function() {
      url = '/reports/medicine_report';
      self.get_data_from_server(url);
    })
  },
  medicine_report: function () {
    self.init_datatable('medicine_reports_table');

    $('.medicine_reports #selected_customer_report').on('change', function(e){
      e.stopImmediatePropagation();
      e.stopPropagation();
      Cookies.set('selected_customer', this.value)
      url = '/reports/medicine_report?customer_id='+this.value;
      self.get_data_from_server(url);

    });
  },
  get_data_from_server: function (url) {
    $.ajax({
      type: 'GET',
      url: url,
      success: function(data) {
      },
      error: function(error) {
        console.log(error)
      }
    });
  },
  init_datatable: function (table_name) {
    self[table_name] = $('#'+table_name).DataTable({
      "order": [
        [1, "desc"]
      ],
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
    });
    $('#'+table_name+'_search_field').on('keyup keypress change', function() {
      self[table_name]
        .columns( 0 )
        .search( this.value )
        .draw();
    });
  }
}