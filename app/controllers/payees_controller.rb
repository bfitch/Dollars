class PayeesController < ApplicationController
  def autocomplete
    @payees = Payee.distinct_by_user_and_name_search(current_user, params[:q])
    render json: @payees
  end
end
