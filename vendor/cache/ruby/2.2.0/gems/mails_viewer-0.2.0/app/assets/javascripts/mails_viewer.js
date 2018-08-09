//= require jquery
//= require dataTables/jquery.dataTables
//= require_tree .

$(function() {
  $('#mails').on('click', 'a.preview', function() {
    $(this).colorbox({width:"80%", height:"80%", iframe:true});
  });

  $('#mails').on('click', 'a.raw', function(e) {
    e.preventDefault();
    e.stopPropagation();
    $.get($(this).attr('href'), function(data) {
      $('#raw div').text(data);
    });
  });

  $("#mails").dataTable({
    "aaSorting": [[4, "desc"]],
    "aoColumns": [
      null,
      null,
      null,
      null,
      null,
      { "bSortable": false }
    ]
  });


});
