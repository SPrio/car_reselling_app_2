module ApplicationHelper

  private
  def model_params(model_name)
    params.require(model_name).permit(:name)
  end
end
