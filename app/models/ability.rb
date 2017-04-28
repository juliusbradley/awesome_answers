class Ability
  include CanCan::Ability

#cancancan will automataically initalize with every request to your controllers.
#It assumes that you have a method available to the controllers called 'current_user'
#and it will automatically initalize an 'Ability' object with 'current_user" passed to it.
  def initialize(user)
    #as per comments above 'user' here refers to 'current_user'
    # Define abilities for the passed in user here. For example:

#if the user is not logged in which means 'user' comes as 'nil' then 'user'
# will be assigned to 'User.new' this is useful so we don't have to check
# if 'user' is 'nil' all the time
    user ||= User.new

    if user.is_admin?
      #this gives the admin user super powers by enabling them to perform any action
      #on any model
      can :manage, :all
    end

#define abilities to prevent users from liking their own questions
can :like, Question do |q|
  user != q.user
end

cannot :like, Question do |q|
  user == q.user
end

  #in this example we're saying that the user can edit a question if the user
  #is the owner (creator) of that question
    can [:edit, :destroy], Question do |question|
      question.user == user
    end

    #
    #user_id is inside the 'questions' table and 'user' is the signed in user
    #(if the user is signed in) or 'User.new' as per line 14
    #can: edit, Question, user_id: user,id

    # to learn more about defining abilities in CanCanCan you can check out:
    # https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
