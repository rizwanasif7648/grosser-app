com.healApp.DashboardIndex = {
  init: function () {
    self = this;
    self.dashboard_index();
  },
  dashboard_index: function () {
    $(document).ready(function () {
      graph('consumed_products', 'chartContainer', 'products_by_customers_no_chart');
      graph('consumed_products_by_boxes', 'products_by_boxes_chart', 'products_by_boxes_no_chart');

      $('#dashboard_table, #products_by_boxes_table').DataTable({
        "pageLength": 5,
        "bLengthChange": false,
        "sDom": '<"row view-filter"<"col-sm-12"<"pull-left"l><"pull-right"f><"clearfix">>>t<"row view-pager"<"col-sm-12"<"text-center"ip>>>',
      });

      $('#select_customer').on('change', function () {
        window.location.href = '/dashboard/?customer_id=' + this.value;
      });

      $('.consumed_product_btn').on('click', function () {
        this_class = $(this)
        var duration;
        duration = $(this).data().value;
        customer_id = $('#customer_id').val();
        if (duration !== "") {
          return $.ajax({
            type: "GET",
            url: "/consumed_products_by_duration",
            dataType: "html",
            data: {
              duration: duration,
              customer_id: customer_id
            },
            success: function (data) {
              remove_add_color_class('consumed_product_btn', this_class)
              graph_datatable('dashboard_table', 'chartContainer', 'products_by_customers_no_chart', data);
            },
            error: function (e) {
              return console.log(e);
            }
          });
        }
      });

      $('.consumed_products_boxes').on('click', function () {
        this_class = $(this)
        var duration, box_id;
        duration = $(this).data().value;
        box_id = $('#select_box').val();
        if (duration !== "" && box_id !== "") {
          return $.ajax({
            type: "GET",
            url: "/consumed_products_boxes_by_duration",
            dataType: "html",
            data: {
              duration: duration,
              box_id: box_id
            },
            success: function (data) {
              remove_add_color_class('consumed_products_boxes', this_class)
              graph_datatable('products_by_boxes_table', 'products_by_boxes_chart', 'products_by_boxes_no_chart', data);
            },
            error: function (e) {
              return console.log(e);
            }
          });
        }
      });

      $('.incident_boxes_btn').on('click', function () {
        this_class = $(this)
        var duration;
        duration = $(this).data().value;
        customer_id = $('#customer_id').val();
        if (duration !== "") {
          return $.ajax({
            type: "GET",
            url: "/incidents_by_boxes",
            dataType: "html",
            data: {
              duration: duration,
              customer_id: customer_id
            },
            success: function (data) {
              remove_add_color_class('incident_boxes_btn', this_class)
              incidents_graph(data)
            },
            error: function (e) {
              return console.log(e);
            }
          });
        }
      });

      $('.red_boxes_btn').on('click', function () {
        this_class = $(this)
        var duration;
        duration = $(this).data().value;
        customer_id = $('#customer_id').val();
        if (duration !== "") {
          return $.ajax({
            type: "GET",
            url: "/boxes_in_red_zone",
            dataType: "html",
            data: {
              duration: duration,
              customer_id: customer_id
            },
            success: function (data) {
              remove_add_color_class('red_boxes_btn', this_class)
              boxes_in_red_graph(data)
            },
            error: function (e) {
              return console.log(e);
            }
          });
        }
      });

      $('#select_box').on('change', function () {
        var box_id;
        box_id = $('#select_box').val();
        if (box_id !== "") {
          return $.ajax({
            type: "GET",
            url: "/consumed_products_by_box",
            dataType: "html",
            data: {
              box_id: box_id
            },
            success: function (data) {
              graph_datatable('products_by_boxes_table', 'products_by_boxes_chart', 'products_by_boxes_no_chart', data);
            },
            error: function (e) {
              return console.log(e);
            }
          });
        }
      });
    });

    function incidents_graph(data) {
      incident_by_boxes = $.parseJSON(data);
      combination_graph(incident_by_boxes["data"], incident_by_boxes["time_duration"])
    }

    function combination_graph(incidents_data, time_duration) {
      var d1 = [];
      $.map(incidents_data, function (n, i) {
        d1.push(n[1]);
      });
      Highcharts.chart('yellow_zone_chart', {
        title: false,
        xAxis: [{
          categories: time_duration
        }],
        yAxis: [{
          labels: {
            format: '{value}',
          },
          title: {
            text: 'Incidents'
          }
        }],
        series: [{
          name: 'Incidents',
          type: 'column',
          data: d1,
          color: '#669ade'
        },
          {
            type: 'spline',
            name: 'Average',
            data: d1,
            marker: {
              lineWidth: 2,
              lineColor: 'white',
              fillColor: '#669ade'
            },
            color: '#434348'

          }]
      });
    }

    function remove_add_color_class(btn_name, this_class) {
      $('.' + btn_name).addClass("btn-month");
      $('.' + btn_name).removeClass("btn-danger");
      this_class.removeClass("btn-month");
      this_class.addClass("btn-danger");
    }

    function graph_datatable(table_id, graph_id, nochart, data) {
      var result = jQuery.parseJSON(data)
      $('#' + table_id).DataTable({
        "pageLength": 5,
        "bLengthChange": false,
        destroy: true,
        "data": result.data
      });
      var d1 = [];
      d2 = result.data;
      $.map(d2, function (n, i) {
        d1.push([n[0], n[2]]);
      });
      donut_graph(graph_id, nochart, d1);
    }

    function graph(data_id, graph_id, nochart) {
      d2 = $('#' + data_id).data('products')
      if (d2 != undefined) {
        donut_graph(graph_id, nochart, d2);
      }
    }

    function donut_graph(graph_id, nochart, data) {
      if (data.length == 0) {
        $('#' + graph_id).hide();
        $('#' + nochart).show();
      } else {
        $('#' + nochart).hide();
        $('#' + graph_id).show();
        Highcharts.chart(graph_id, {
          tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          title: false,
          series: [{
            type: 'pie',
            innerSize: '70%',
            name: 'quantity',
            fontSize: '16px',
            data: data
          }]
        });
      }
    }

    function boxes_in_red_graph(data) {
      red_boxes = $.parseJSON(data);
      red_boxes_graph(red_boxes["data"], red_boxes["time_duration"])
    }

    function red_boxes_graph(red_boxes_data, time_duration) {
      var d1 = [];
      $.map(red_boxes_data, function (n, i) {
        d1.push(n[1]);
      });
      Highcharts.chart('red_zone_box', {
        title: false,
        xAxis: [{
          categories: time_duration
        }],
        yAxis: [{
          labels: {
            format: '{value}',
          },
          title: {
            text: 'Boxes'
          }
        }],
        series: [{
          name: 'Boxes in red zone',
          type: 'column',
          data: d1,
          color: '#669ade'
        },
          {
            type: 'spline',
            name: 'Average',
            data: d1,
            marker: {
              lineWidth: 2,
              lineColor: 'white',
              fillColor: '#669ade'
            },
            color: '#ec2224'

          }]
      });
    }

    week_dates = $('#week_dates').data('products')
    incidents = $('#incidents_per_week').data('products')
    combination_graph(incidents, week_dates)

    red_boxes_week_dates = $('#boxes_in_red_week_dates').data('products')
    boxes_in_red_week = $('#boxes_in_red_week').data('products')
    red_boxes_graph(boxes_in_red_week, red_boxes_week_dates)
  }
}