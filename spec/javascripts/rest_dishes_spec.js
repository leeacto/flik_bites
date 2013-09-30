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

	describe("Tab Selection", function(){
		beforeEach(function(){
			menu.init();
			testTab = menu.tabs[0];
			standByTab = menu.tabs[1];
		});
		
		it("should select tabs when told to", function(){
			spyOn(testTab.list.el, "removeClass");

			menu.selectTab(testTab);
			expect(testTab.list.el.removeClass).toHaveBeenCalled();
		});

		it("should unselect standby tabs", function(){
			spyOn(standByTab.list.el, "addClass");

			menu.selectTab(testTab);
			expect(standByTab.list.el.addClass).toHaveBeenCalled();
		});		
	})
});

describe("Tab", function(){
	beforeEach(function() {
		menu = new Menu('.menu');
		menu.init();
		tab = menu.tabs[0];
	});

	it("should have the correct selector", function(){
		expect(tab.el).toEqual($('#starters_tab'));
	});

	it("should have a List object", function(){
		console.log(tab.list.el);
		expect(tab.list.el.selector).toBe('.starters');
	});

	it("clicking should activate Menu selectTab method", function(){
		spyOn(tab.el, "removeClass");
		tab.el.trigger('click');
		expect(tab.el.removeClass).toHaveBeenCalled;
	});
});