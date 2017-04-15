class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, to: :@template
  delegate :titleize, to: :@template
  [:text_field, :text_area, :email_field, :password_field, :url_field, :number_field].each do |method|
    define_method method do |name, *args|
      options = args.extract_options!
      if options.has_key?(:class) then
        options[:class] += " form-control"
      else
        options[:class] = "form-control"
      end
      if options[:nodiv]
        return super(name, options)
      end
      content_tag :div, class: "form-group" do
        content_tag(:label, name.to_s.titleize, name: name) + super(name, options)
      end
    end
  end

  def file_field name, *args
    options = args.extract_options!
    content_tag(:label, name.to_s.titleize) + super(name, options)
  end

  def m_check_box name, *args
    options = args.extract_options!
    content_tag(:div, class: "checkbox") do
      content_tag(:label, check_box(name, options)+name.to_s.titleize)
    end
  end

  def toggle_button name, *args
    options = args.extract_options!
    content_tag(:div, class: "togglebutton") do
      content_tag(:label, check_box(name, options, checked: true) + name.to_s.titleize)
    end
  end

  def submit(*args)
    content_tag(:div) do
      super(args, class: "btn btn-default green white-text")
    end
  end

  def select name, items, *args
    options = args.extract_options!
    if options.has_key?(:class) then
      options[:class] += " form-control"
    else
      options[:class] = "form-control"
    end
    content_tag(:div, class: "form-group") do
      content_tag(:label, name.to_s.titleize, name: name) +
          super(name, items, {}, {:class => 'form-control'})
    end
  end

  def errors
    if object.errors.any?
      content_tag(:div, class: "large-padding") do
        content_tag(:h2, "Errores: ")+
            content_tag(:ul) do
              lis = ""
              object.errors.full_messages.each do |message|
                lis+=content_tag(:li, message)
              end
              lis.html_safe
            end
      end
    end
  end

  def bootstrap_datetime name, *args
    options = args.extract_options!
    id = options[:id] || name
    content_tag(:div, class: :form_group) do
      content_tag(:div, class: :"input-group date", id: id) do
        content_tag(:label, name.to_s.titleize, name: name) +
            text_field(name, class: "form-control", "nodiv": true) +
            content_tag(:span, content_tag(:span, nil, class: "glyphicon glyphicon-calendar"), class: "input-group-addon")
      end
    end
  end
end