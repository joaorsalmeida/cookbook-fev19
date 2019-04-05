class Api::V1::ApplicationController < ActionController::API
 rescue_from ActiveRecord::RecordNotFound, with: :not_found

 private

 def not_found
   render json: 'Record not found', status: 404
 end
end
