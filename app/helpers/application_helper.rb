module ApplicationHelper

  def gender_display(gender)
    case gender
    when 1
      "男"
    when 2
      "女"
    else
      "其它"
    end
  end

  def my_link_to(label, link)
    link_to label, link, class: "btn btn-default"
  end
end
