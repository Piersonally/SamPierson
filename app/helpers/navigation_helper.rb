module NavigationHelper

  def main_navbar_content_data
    [
      {
        type: :nav,
        items: [
          { label: 'Home', href: root_path, if: user_logged_in? }
        ]
      },
      {
        type: :nav,
        class: 'navbar-right',
        items: [
          { label: 'Log In', href: login_path }
        ],
        unless: user_logged_in?
      },
      {
        type: :nav,
        class: 'navbar-right',
        items: [
          {
            label: -> { current_user.full_name },
            submenu: [
              { label: 'Log Out', href: logout_path, method: :delete }
            ]
          }
        ],
        if: user_logged_in?
      },
    ]
  end
end
