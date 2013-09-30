//= require jquery
//= require jquery_ujs
//= require dishes_index

describe("Menu", function() {
	beforeEach(function() {
		menu = new Menu('.menu');
	})

	it("should have the menu class selector", function() {
		expect(menu.el).toEqual($('.menu'));
	})

	it("should load tabs upon init function", function(){
		menu.init();
		expect(menu.tabs.length).toBe(3);
	});

	it("should add tabs on init", function(){
		spyOn(menu, "addTab");
		menu.init();
		expect(menu.addTab).toHaveBeenCalled();
	});

	it("should select tabs when told to", function(){
		
	});
})