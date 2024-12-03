require_relative '../entities/auth'
require_relative '../../../domain/auth_repository'

class AuthRepository_pg < AuthRepository
    def initialize
        @products = {}
    end

    def login(username, password)
        Infrastructure::Persistence::Entities::Auth.where(username: username, password_digest: password).first
    end
end