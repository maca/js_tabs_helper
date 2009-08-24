$(function(){ 
    $('div.tabbed ul#tabnav a').bind( 'click', function(event){
      var link_id        = $(event.target).attr('id');
      var content_div_id = link_id.match(/(.*)_link$/)[1];
      $('div.tabbed ul#tabnav a').removeClass('selected').filter('#' + link_id).addClass('selected');
      $('div.tabbed div.tab_content').hide().filter('#' + content_div_id).show();
      return false;
    });
});