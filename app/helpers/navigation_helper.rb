module NavigationHelper

  def main_navbar_content_data
    [
      {
        type: :nav,
        items: [
          { label: 'Blog', href: root_path }
        ]
      },
      {
        type: :nav,
        items: [
          {
            label: 'Articles', href: articles_path,
            active: /^\/articles/,
            if: user_logged_in?
          }
        ]
      },
      {
        type: :nav,
        items: [
          {
            label: 'Topics', href: topics_path,
            active: /^\/topics/,
            if: user_logged_in?
          }
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
