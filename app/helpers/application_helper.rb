module ApplicationHelper
  def error_messages(model, type)
    content_tag(:ul, class: 'style-none') do
      model.errors[type].collect do |item|
        concat(content_tag(:li, item, class: 'text-danger error-text text-capitalize'))
      end
    end
  end

  def navbar
    content_tag(:ul, class: 'navbar-nav justify-content-end') do
      if user_signed_in?
        content_tag(:li, link_to('Sign out',
                                 destroy_user_session_path,
                                 method: :delete, data: { confirm: 'Are you sure?' },
                                 class: 'btn btn-warning btn-sm mx-1'), class: 'nav-item active')
      end
    end
  end

  def to_follow
    ids = current_user.followed_users.pluck(:id) << current_user.id
    users_to_follow = User.where.not(id: ids)
  end

  def follow_btns(user)
    if !current_user.followed_users.include?(user)
      link_to('Follow', followings_path(id: user.id), class: 'btn btn-primary btn-sm', method: :post)
    else
      link_to('Unfollow', following_path(user, current_user), class: 'btn btn-secondary btn-sm', method: :delete)
    end
  end

  def fav_btn(opinion)
    fav = Favorite.find_by(user_id: current_user.id, opinion_id: opinion.id)
    if fav
      link_to(content_tag(:i, nil, :class => "fa fa-heart red-color"), favorite_path(opinion.id), method: :delete)
    else
      link_to(content_tag(:i, nil, :class => "fa fa-heart grey-color"), favorites_path(opinion_id: opinion.id), method: :post)
    end
  end
end
