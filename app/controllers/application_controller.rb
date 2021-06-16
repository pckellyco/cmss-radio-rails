class ApplicationController < ActionController::Base

    before_action :authenticate

    def authenticate
        auth_header = request.headers[:Authorization]
        if !auth_header
            render json: { error: 'Auth bearer token header must be present' }, status: :forbidden
        else
            token = auth_header.split(' ')[1]
            secret = '123456789abcdef'
            begin
                JWT.decode token, secret
                @users = User.all
                render json: @users, status: :ok
            rescue
                render json: {error: 'Bad token'}, status: :forbidden
            end
        end
    end

end
