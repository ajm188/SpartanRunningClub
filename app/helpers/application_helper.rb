module ApplicationHelper
  def alert_tag alert_level, options = {}, &block
    options[:class] = append_string options, :class,
      "alert alert-#{alert_level}"

    haml_tag :div, options do
      yield block if block_given?
    end
  end

  def badge_tag type = nil, options = {}, &block
    badge_class = type.nil? ? '' : "badge-#{type}"
    options[:class] = append_string options, :class, "badge #{badge_class}"

    haml_tag :span, options do
      yield block if block_given?
    end
  end

  def table_tag options = {}, &block
    options[:class] = append_string options, :class,
      'table table-striped table-hover'

    haml_tag :table, options do
      yield block if block_given?
    end
  end

  def glyphicon_tag icon, options = {}, &block
    options[:class] = append_string options, :class, "glyphicon glyphicon-#{icon}"

    haml_tag :span, options do
      yield block if block_given?
    end
  end

  def header_tag options = {}, &block
    options[:class] = append_string options, :class, 'page-header'
    
    haml_tag :div, options do
      yield block if block_given?
    end
  end

  def spacer_tag options = {}
    options[:style] = append_string options, :style, 'display:block;margin-top:5px;'
    haml_tag :div, options
  end

  private

  # Append a string to a hash value
  def append_string hash, key, string
    hash.fetch(key, '') <<  ' ' << string
  end
end
