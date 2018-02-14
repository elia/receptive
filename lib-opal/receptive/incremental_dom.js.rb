require 'receptive/incremental-dom-0.5.1'
require 'console'
require 'js'

module Receptive::IncrementalDOM
  extend self
  # Keep the var in the closure
  `var native = #{JS.global.JS[:IncrementalDOM]}`

  def patch_element(element, patch, data = nil)
    `native`.JS.patch(element, patch.to_n, data.to_n)
  end

  # Add a tag
  # @param tagname [String]
  def tag(tagname, uid = nil, static_props = nil, dynamic_props = nil, &block)
    if Hash === static_props
      static_props = static_props.to_a.flatten
    end

    if Hash === dynamic_props
      innerHTML = dynamic_props.delete(:innerHTML) if Hash === dynamic_props
      dynamic_props = dynamic_props.to_a.flatten
      # l innerHTML: innerHTML
    end

    dynamic_props ||= []
    if block_given?
      raise ArgumentError, 'cannot accept both a block and innerHTML' if innerHTML
      `native`.JS.elementOpen(tagname, uid.to_n, static_props.to_n, *dynamic_props)
      result = block.call
      text result if String === result
      `native`.JS.elementClose(tagname)
    else
      node = `native`.JS.elementVoid(tagname, uid.to_n, static_props.to_n, *dynamic_props)
      node.JS[:innerHTML] = innerHTML
      node
    end
  end

  # Add a text node
  def text(value, &formatter)
    if block_given?
      `native`.JS.text(value, formatter)
    else
      `native`.JS.text(value)
    end
  end

  # @param element [DOM Node] doesn't accept jQuery elements
  def update_element(element, data = nil, &block)
    t0 = `performance.now()` if $DEBUG
    patch_element(element, -> { block.call(self) }, data)
    if $DEBUG
      t1 = `performance.now()`
      $console.log(
        "%c render/incremental %c #{inspect} %c #{t1 - t0}ms ",
        'background-color:#eee;color:#444;border-radius:2px 0 0 2px',
        'background-color:#94E2C8;color:#193F32;border-radius:0 2px 2px 0',
        'background-color:none;border:none;font-family:monospace;',
        data.to_n,
        element
      )
    end
  end

  module DSL
    HTML_TAGS = %w(a abbr address area article aside audio b base bdi bdo big blockquote body br
                  button canvas caption cite code col colgroup data datalist dd del details dfn
                  dialog div dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5
                  h6 head header hr html i iframe img input ins kbd keygen label legend li link
                  main map mark menu menuitem meta meter nav noscript object ol optgroup option
                  output p param picture pre progress q rp rt ruby s samp script section select
                  small source span strong style sub summary sup table tbody td textarea tfoot th
                  thead time title tr track u ul var video wbr)

    HTML_TAGS.each do |tagname|
      define_method tagname do |params, &block|
        tag tagname, nil, nil, params, &block
      end
    end

    def _p(*args)
      Kernel.p(*args)
    end
  end
end
