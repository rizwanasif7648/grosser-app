com.healApp.UsersIndex = {
  init: function () {
    self = this;
    self.users_index();
    self.users_table = null;
  },
  users_index: function () {
    $(document).ready(function() {
      self.init_datatable();
      // navigate page to view customer on click
      $('#users_table tbody tr').on('click', function (e) {
        if($(e.target).is('td')){
          window.location.href = $(this).attr('href');
        }
      })

      $('#selected_customer').on('change', function(e){
        e.stopImmediatePropagation();
        e.stopPropagation();
        Cookies.set('selected_customer', this.value)
        window.location.href='/users?customer_id='+this.value;
      });
      // This function can be used to select the comma separated ids of selected users
      self.get_selected_rows()
    })
  },
  get_selected_rows: function(){
    var rows_selected = self.users_table.column(0).checkboxes.selected();
    return rows_selected.join(",");
  },
  init_datatable: function () {
    self.users_table = $('#users_table').DataTable({
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
      'columnDefs': [
        {
          'targets': 0,
          'checkboxes': {
            'selectRow': true
          }
        }
      ],
      'select': {
        'style': 'multi'
      },
      // "columns": [
      //   { "width": "22.5%" },
      //   { "width": "22.5%" },
      //   { "width": "22.5%" },
      //   { "width": "22.5%" },
      //   { "width": "10%" },
      // ]
    });
    $('#users_search_field').on('keyup keypress change', function() {
      self.users_table
        .columns( 1 )
        .search( this.value )
        .draw();
    });
  }
}