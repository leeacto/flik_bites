var catList = function(el) {
  this.el = $(el);
  this.categories = [];
}

catList.prototype.initialize = function(){
  var self = this;

  $.each(this.el.find('li'), function(){
    var el;
    var newCat = new Category(this.id);
    self.addCat(newCat);
  })
}

catList.prototype.addCat = function(cat) {
  this.categories.push(cat);
}

var Category = function(el) {
  this.el = $('#'+el);
  this.buttonDown = false;
  this.initialize();
}

Category.prototype.initialize = function(){
  var self = this;

  this.el.on("click", function(event) {
    event.stopPropagation();

    self.buttonDown = true;
    $('li').each(function(){
      $(this).removeClass('button_down');
    })

    $(this).addClass('button_down');
  });
}

Category.prototype.clicked = function(event) {
}

function setup() {
  catBoard = new catList('.dish_categories');
  catBoard.initialize();
}

$(document).on('ready', setup);
$(document).on('page:load', setup);
