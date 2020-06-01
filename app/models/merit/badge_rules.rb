# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # Find badge by badge_id, badge_id takes presidence over badge

      # test this badge when I create a user on localhost
      grant_on 'users#create', badge: 'just-registered', to: :itself
      # model_name: 'User'
      # there is no create action for user since it depends on Devise

      # badge created when folloing a user
      grant_on 'users#follow', badge: 'Followed one person', to: :itself

      # enrollment create
      grant_on 'enrollments#create', badge: 'Enrollment prize', to: :user

      # first idea for level up
      # grant_on 'chapters#update', badge: 'Level up',
      #   to: :user do |chapter|
      #   course.index(chapter) == course.index(chapter) + 1
      #   # need to change
      # end

      # second idea
      grant_on 'enrollments#update', badge: 'Course completed!',
        to: :user do |enrollment|
        enrollment.completion_status == 100
        # user.enrollment.completion_status == 100 ?
        # need to create enrollments#update route and controller
        # scraping should be related to enrollments#update
      end

      # examples given automatically
      # If it has 10 comments, grant commenter-10 badge
      grant_on 'comments#create', badge: 'commenter', level: 10 do |comment|
        comment.user.comments.count == 10
      end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end
    end
  end
end
