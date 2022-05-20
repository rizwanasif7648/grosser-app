# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :args

  def initialize(_user, args)
    @user = args[0]
    @role_id = @user.role_id
    @permission_name = args[1]
  end

  def index?
    Permission.authorized?(@role_id, @permission_name, 'is_readable')
  end

  def show?
    Permission.authorized?(@role_id, @permission_name, 'is_readable')
  end

  def create?
    Permission.authorized?(@role_id, @permission_name, 'is_createable')
  end

  def new?
    create?
  end

  def update?
    Permission.authorized?(@role_id, @permission_name, 'is_updateable')
  end

  def edit?
    update?
  end

  def destroy?
    Permission.authorized?(@role_id, @permission_name, 'is_deleteable')
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
