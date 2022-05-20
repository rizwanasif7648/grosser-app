com.healApp.RolesIndex = {
  init: function () {
    self = this;
    self.roles_index();
    self.roles_table = null;
  },
  roles_index: function () {
    $(document).ready(function() {
      self.init_datatable();
      // navigate page to view role on click
      $('#roles_table tbody tr').on('click', function (e) {
        if($(e.target).is('td')){
          window.location.href = $(this).attr('href');
        }
      })

      $('#selected_customer').on('change', function(e){
        e.stopImmediatePropagation();
        e.stopPropagation();
        Cookies.set('selected_customer', this.value)
        window.location.href='/roles?customer_id='+this.value;

      });
    })
  },
  init_datatable: function () {
    self.roles_table = $('#roles_table').DataTable({
      "order": [
        [0, "asc"]
      ],
      "infoCallback": function( settings, start, end, max, total, pre ) {
        // Haroon: Might be helpful to get current page info
        // var api = this.api();
        // var pageInfo = api.page.info();

        $("#roles_info").text(total+" records");
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
        { "width": "15%" },
        { "width": "75%" },
        { "width": "10%" },
      ]
    });
    $('#roles_search_field').on('keyup keypress change', function() {
      self.roles_table
        .columns( 0 )
        .search( this.value )
        .draw();
    });
  }
}