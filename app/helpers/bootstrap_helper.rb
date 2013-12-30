module BootstrapHelper

  # Construct Bootstrap 3 navbars, like:
  #
  #   %nav.navbar.navbar-default{ role: 'navigation' }
  #
  #     / Brand and toggle get grouped for better mobile display
  #     .navbar-header
  #       %button.navbar-toggle{ type: 'button',
  #                              data: { target: '#bs-example-navbar-collapse-1',
  #                                      toggle: 'collapse' } }
  #         %span.sr-only Toggle navigation
  #         %span.icon-bar
  #         %span.icon-bar
  #         %span.icon-bar
  #       %a.navbar-brand{ href: '#' } Brand
  #
  #     / Collect the nav links, forms, and other content for toggling
  #     #bs-example-navbar-collapse-1.collapse.navbar-collapse
  #
  #       %ul.nav.navbar-nav
  #         %li.active
  #           %a{ href: '#' } Link
  #         %li
  #           %a{ href: '#' } Link
  #         %li.dropdown
  #           %a.dropdown-toggle{'data-toggle' => 'dropdown', href: '#'}
  #             Dropdown
  #             %b.caret
  #           %ul.dropdown-menu
  #             %li
  #               %a{ href: '#' } Action
  #             %li
  #               %a{ href: '#' } Another action
  #             %li
  #               %a{ href: '#' } Something else here
  #             %li.divider
  #             %li
  #               %a{ href: '#' } Separated link
  #             %li.divider
  #             %li
  #               %a{ href: '#' } One more separated link
  #
  #       %form.navbar-form.navbar-left{role: 'search'}
  #         .form-group
  #           %input.form-control{ placeholder: 'Search', type: 'text' }/
  #         %button.btn.btn-default{ type: 'submit' } Submit
  #
  #       %ul.nav.navbar-nav.navbar-right
  #         %li
  #           %a{ href: '#' } Link
  #         %li.dropdown
  #           %a.dropdown-toggle{ href: '#', data: { toggle: 'dropdown' } }
  #             Dropdown
  #             %b.caret
  #           %ul.dropdown-menu
  #             %li
  #               %a{ href: '#' } Action
  #             %li
  #               %a{ href: '#' } Another action
  #             %li
  #               %a{ href: '#' } Something else here
  #             %li.divider
  #             %li
  #               %a{ href: '#' } Separated link
  #
  def navbar_helper(nav_sections_data)
    content_tag :nav, class: 'navbar navbar-default', role: 'navigation' do
      navbar_header + navbar_body(nav_sections_data)
    end
  end

  private

  def navbar_header
    content_tag :div, class: 'navbar-header' do
      # Brand and toggle get grouped for better mobile display
      toggle_navigation_button +
      navbar_brand
    end
  end

  def toggle_navigation_button
    content_tag :button, class: 'navbar-toggle', data: {
      target: '#bs-navbar-collapse-1', toggle: 'collapse', type: 'button'
    } do
      content_tag(:span, 'Toggle navigation', class: 'sr-only') +
      (1..3).map { content_tag :span, '', class: 'icon-bar' }.join.html_safe
    end
  end

  def navbar_brand
    link_to 'Sam Pierson', root_path, class: 'navbar-brand'
  end

  def navbar_body(nav_sections_data)
    # Collect the nav links, forms, and other content for toggling
    content_tag(:div, id: 'bs-navbar-collapse-1',
                      class: 'collapse navbar-collapse') do
      navbar_sections nav_sections_data
    end
  end

  def navbar_sections(nav_sections_data)
    nav_sections_data.map do |section_data|
      navbar_section section_data
    end.reject(&:blank?).join.html_safe
  end

  def navbar_section(section_data)
    return nil if evaluate(section_data).blank?
    case section_data[:type]
    when :nav; navbar_ul section_data, class: 'nav navbar-nav'
    else raise 'unknown type'
    end
  end

  def navbar_ul(data, options={})
    ul_css_classes = CssClassList.new data[:class], options[:class]
    content_tag(:ul, class: ul_css_classes) do
      navbar_ul_lis data[:items]
    end
  end

  def navbar_ul_lis(items)
    items.map do |item|
      next if evaluate(item).blank? # Process :if and :unless
      navbar_li item
    end.reject(&:blank?).join.html_safe
  end

  def navbar_li(item)
    li_css_classes = CssClassList.new item[:class]
    li_css_classes << 'active' if item_is_active?(item)
    li_css_classes << 'dropdown' if item[:submenu]
    li_options = {}
    li_options[:class] = li_css_classes if li_css_classes.any?
    content_tag :li, li_options do
      navbar_li_content item
    end
  end

  def navbar_li_content(item)
    if item[:submenu]
      navbar_li_submenu item
    else
      navbar_link item
    end
  end

  def navbar_link(item)
    link_to_options = {}
    link_to_options[:method] = item[:method] if item[:method]
    link_to evaluate(item[:label]), item[:href], link_to_options
  end

  def navbar_li_submenu(item)
    content_tag(:a, href: '#', class: 'dropdown-toggle',
                    data: { toggle: 'dropdown' }) do
      evaluate(item[:label]).html_safe + content_tag(:b, '', class: 'caret')
    end +
    navbar_ul(items: item[:submenu], class: 'dropdown-menu')
  end

  def item_is_active?(item)
    if item[:active]
      request.path =~ item[:active]
    else
      item[:href] == request.path
    end
  end

  # If given a Proc, run it.
  # If given a symbol, use it as a method name and 'send' it.
  def evaluate(thing)
    return thing.call if thing.is_a? Proc
    return send thing if thing.is_a? Symbol
    return evaluate_hash(thing) if thing.is_a? Hash
    thing
  end

  # If hash has an :if key, evaluate the :if value and return the hash if it
  # is true, else an empty hash.
  # Do the reverse if the hash has an :unless
  def evaluate_hash(hash)
    if hash.has_key? :if
      evaluate(hash.delete :if) ? hash : {}
    elsif hash.has_key? :unless
      evaluate(hash.delete :unless) ? {} : hash
    else
      hash
    end
  end
end
