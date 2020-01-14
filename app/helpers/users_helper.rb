module UsersHelper

  def recommendusers_judge(recommend_users)
    if recommend_users.blank?
      popularity_users = User.find(Follow.group(:followable_id).order('count(followable_id) desc').limit(5).pluck(:followable_id))
      return popularity_users
    else
      return recommend_users
    end
  end

end
