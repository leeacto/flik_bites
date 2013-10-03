var searchBar = function(el) {
  this.el = $(el);
  this.search = "";
}

searchBar.prototype.setSearch = function(text) {
  if(this.search != text)
  {
    this.search = text;
    var url = $('#url').text();
    var search_phrase = text.replace('      ','').replace('    ','').replace(/(\r\n|\n|\r)/gm,"");
    var pkg = {
      url: url,
      search: search_phrase
    };

    $.ajax({
      url: "/" + url + "/dishes",
      data: pkg,
      method: "GET"
    }).done(function(results){
      $('.dish_layout').html('');
      $('.dish_layout').append(results);
    });
  }
}

var catList = function(el) {
  this.el = $(el);
  this.categories = [];
}

catList.prototype.initialize = function(){
  var self = this;
  this.searchBar = new searchBar('#search_field');

  $.each(this.el.find('li'), function(){
    var newCat = new Category($(this).find('button'), self);
    self.addCat(newCat);
  });
}

catList.prototype.addCat = function(cat) {
  this.categories.push(cat);
}

var Category = function(el, list) {
  this.el = $(el);
  
  this.list = list;
  this.buttonDown = false;
  this.initialize();
}

Category.prototype.initialize = function(){
  var self = this;
  this.el.on("click", function(event) {
    event.stopPropagation();
    $(self.list.categories).each(function(){
      this.buttonDown = false;
      $(this.el).removeClass('button_down');
    });
    self.list.searchBar.setSearch(self.el.text());
    self.buttonDown = true;
    $(this).addClass('button_down');
  });
}

function setup() {
  catBoard = new catList('.dish_categories'),catBoard.initialize()
}

$(document).on('ready', setup);
$(document).on('page:load', setup);