module UsersHelper
  def gravatar_for user, options = {size: Settings.gravatar.size_for_show}
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = format(Settings.links.gravatar_url, gravatar_id:, size:)

    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def can_destroy_user? user
    current_user.admin? && !current_user?(user)
  end

  def check_micropost
    @user.microposts.any?
  end

  def count_microposts
    @user.microposts.count
  end
end
