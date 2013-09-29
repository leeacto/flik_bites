FactoryGirl.define do
  factory :photo do
    image File.new(Rails.root + 'spec/factories/images/rails.png') 
  end
end