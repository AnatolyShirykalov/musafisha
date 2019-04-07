class Ability
  include CanCan::Ability

  def initialize(user)
    if user and user.role == 'admin'
      can :read, :all
      can :manage, :all
      cannot :destroy, Menu
      cannot :update, Menu
      admin_ui
    end
  end

  def admin_ui
    can :access, :rails_admin   # grant access to rails_admin
    can :dashboard, :all              # grant access to the dashboard
  end
end
