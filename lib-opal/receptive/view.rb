module Receptive::View
  def self.extenders
    @extenders ||= []
  end

  def self.extended(base)
    extenders << base
  end

  attr_accessor :selector

  def setup
    # noop, this is hook for extenders
  end

  def selector
    @selector or raise('Please set the selector')
  end

  def persistent_events
    @persistent_events ||= []
  end

  def setup_persistent_events
    setup
    persistent_events.each do |persistent_event|
      element, event, selector, block = *persistent_event
      selector ?
        element.on(event, selector, &block) :
        element.on(event, &block)
    end
  end

  def on event, selector = '', &block
    selector = combine_selectors([self.selector, selector])
    persistent_events << [Document, event, selector, block]
  end

  def on_window(event, selector = nil, &block)
    window = Window.element
    on_document('page:change',        selector) { window.on(event, &block) }
    on_document('page:before-unload', selector) { window.off(event, &block) }
  end

  def on_document(event, selector = nil, &block)
    persistent_events << [Document, event, nil, block_with_guard(block, selector)]
  end

  def block_with_guard(block, selector)
    selector = combine_selectors([self.selector, selector])
    block_with_guard = -> *args { block.call(*args) if Document.has? selector }
  end

  def find(selector = '')
    Document.find(combine_selectors([self.selector, selector]))
  end

  # Support combining multiple selectors with commas
  def combine_selectors(*selectors)
    selectors = selectors.flatten.compact
    splitted = selectors.map { |s| next if s.nil? or s.empty?; s.split(',') }.compact
    return '' if splitted.size.zero?
    return splitted.join(', ') if splitted.size == 1

    # About Array#product:
    #
    #   >> ['a,b', 'c,d'].map{|s| s.split(',')}.reduce(:product)
    #   => [["a", "c"], ["a", "d"], ["b", "c"], ["b", "d"]]
    #
    return splitted.reduce(:product).map {|s| s.join(' ')}.join(', ')
  end

  alias :element :find


  # Rendering

  def render
    warn "#{name}#render not found, should be implemented!"
  end

  def render!
    $console.log(
      "%c render %c #{inspect} %c #{selector} ",
      'background-color:#eee;color:#444;border-radius:2px 0 0 2px',
      'background-color:#BFE99C;color:#30491B;border-radius:0 2px 2px 0',
      'background-color:none;border:none;font-family:monospace;',
      self
    ) if $DEBUG
    `window`.JS.requestAnimationFrame(&method(:render))
    nil
  end

  alias_method :on_event, :on_document
end
