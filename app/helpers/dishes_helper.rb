module DishesHelper
  def to_url(rest, dish)
    params[:restaurant][:name].downcase.gsub(' ','')
  end
end