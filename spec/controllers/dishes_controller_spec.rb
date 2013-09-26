require 'spec_helper'


describe DishesController do 

 describe "GET #index" do
    it "loads an array of dishes" do
      
    end

    it "renders the :index view"
  end

  describe "GET #show" do
    it "assigns the requested dish to @dish"
    it "renders the :show template"
  end

  describe "POST #create" do 
    context "with valid attributes" do
      it "saves the new dish in the database"
      it "redirects to the restaurant menu page"
    end

    context "with invalid attributes" do
      it "does not save dish in the database"
      it "re-renders the dish :new template"
    end
  end

end