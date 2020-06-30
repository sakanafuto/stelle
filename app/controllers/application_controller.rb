class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def set_search
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def search_params
    params.require(:q).permit(:prefecture_id, :prefecture_id_eq)
  end

  protected

    def configure_permitted_parameters
      added_attrs = [:name, :avatar]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    end
end
