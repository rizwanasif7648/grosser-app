com.healApp.ProductsIndex = {
  init: function () {
    self = this;
    self.products_index();
    self.products_table = null;
  },
  products_index: function () {
    $(document).ready(function () {
      self.init_datatable();
      // navigate page to view customer on click
      $('#products_table tbody tr').on('click', function (e) {
        if($(e.target).is('td') && !$(e.target).hasClass('radio-check')){
          window.location.href = $(this).attr('href');
        }
      })
      // This function can be used to select the comma separated ids of selected users
      self.get_selected_rows()
      $('.radio-check input:checkbox').click(function() {
        $('.radio-check input:checkbox').not(this).prop('checked', false);
      });
    })
  },
  get_selected_rows: function () {
    var rows_selected = self.products_table.column(0).checkboxes.selected();
    return rows_selected.join(",");
  },
  init_datatable: function () {
    self.products_table = $('#products_table').DataTable({
      "infoCallback": function (settings, start, end, max, total, pre) {
        // Haroon: Might be helpful to get current page info
        // var api = this.api();
        // var pageInfo = api.page.info();

        $("#products_info").text(total + " records");
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
    });
    $('#products_search_field').on('keyup keypress change', function () {
      self.products_table
        .columns(2)
        .search(this.value)
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