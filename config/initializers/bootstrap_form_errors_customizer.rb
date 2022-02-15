ActionView::Base.field_error_proc = proc do |html_tag, instance|
    class_attr_index = html_tag.index 'class="'
    class_attr_length = 'class="'.length
  
    if html_tag =~ /^<label/
      html_tag.html_safe
    else
      html_tag.insert(class_attr_index + class_attr_length, 'is-invalid ')
    end
end