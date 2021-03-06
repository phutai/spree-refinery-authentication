Spree::User.class_eval do
  # The default NilUser has all roles and can access all plugins.
  # Should be overridden in authentication solutions.
  def has_role?(role)
    case
    when role == :superuser
      admin?
    when role == :refinery
      admin?
    when role == :user
      has_spree_role?('user')
    else
      false
    end
  end

  def active_plugins
    @active_plugins ||= Refinery::Plugins.new(
      Refinery::Plugins.registered.select do |plugin|
        has_role?(:superuser)
      end
    )
  end

  def has_plugin?(name)
    active_plugins.names.include?(name)
  end

  def landing_url
    active_plugins.in_menu.first_url_in_menu
  end
end
