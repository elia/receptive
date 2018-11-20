require 'opal-jquery'

class Element
  def has?(selector_or_element)
    `#{self}.has(#{selector_or_element}).length !== 0`
  end

  def hidden= value
    if value
      attr(:hidden, true)
    else
      remove_attribute(:hidden)
    end
  end
end
