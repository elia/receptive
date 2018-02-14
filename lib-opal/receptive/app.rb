require 'receptive/view'

module Receptive::App
  extend self

  def trigger(event_name, data = nil)
    $console.log(
      "%c event %c #{event_name} %c ",
      'background-color:#eee;color:#444;border-radius:2px 0 0 2px',
      'background-color:#94D1F5;color:#0A3EA3;border-radius:0 2px 2px 0',
      'background-color:none;border:none;font-family:monospace;',
      `data != null && data.$inspect && data.$inspect()`,
      self
    ) if $DEBUG
    Document.trigger(event_name, data)
  end

  def on(event_name, &block)
    Document.on(event_name, &block)
  end

  def run
    trigger('app:starting', self)
    ::Receptive::View.extenders.each { |c| c.setup_persistent_events }
    trigger('app:started', self)

    # Managing dom:ready for sync & async script tags
    app_loaded = ->*{ trigger('app:loaded') }

    %x{
      if (document.readyState === 'complete') {
        setTimeout(#{app_loaded}, 1);
      } else {
        document.addEventListener('DOMContentLoaded', #{app_loaded}, false);
      }
    }

    # Managing visibility changes
    visibility_change = -> { trigger(`document`.JS[:hidden] ? 'visibility:hidden' : 'visibility:visible') }
    %x{
      if (!document.hidden) {
        setTimeout(#{visibility_change}, 1);
      } else {
        document.addEventListener('visibilitychange', #{visibility_change}, false);
      }
    }
  end
end
