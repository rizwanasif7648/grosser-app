com.healApp.BoxesIndex = {
  init: function () {
    self = this;
    self.boxes_index();
    self.boxes_table = null;
  },
  boxes_index: function () {
    $(document).ready(function() {
      self.init_datatable();
      // navigate page to view customer on click
      $('#boxes_table tbody tr').on('click', function (e) {
        if($(e.target).is('td') && !$(e.target).hasClass('radio-check')){
          window.location.href = $(this).attr('href');
        }
      })

      $('#selected_customer').on('change', function(){
        Cookies.set('selected_customer', this.value);
        window.location.href='/boxes?customer_id='+this.value;
      });

      // This function can be used to select the comma separated ids of selected boxes
      self.get_selected_rows();
      $('.radio-check input:checkbox').click(function() {
        $('.radio-check input:checkbox').not(this).prop('checked', false);
      });
    })
  },
  get_selected_rows: function(){
    var rows_selected = self.boxes_table.column(0).checkboxes.selected();
    return rows_selected.join(",");
  },
  init_datatable: function () {
    self.boxes_table = $('#boxes_table').DataTable({
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
    $('#boxes_search_field').on('keyup keypress change', function() {
      self.boxes_table
        .columns( 1 )
        .search( this.value )
        .draw();
    });

    $(document).on('click', '.generate-sticker-btn', function () {
      let url = $('.radio-check input:checkbox:checked').val();
      if(url != ''){
        window.open(url, '_blank');
      }
    });
  }
}