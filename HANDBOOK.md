# Receptive handbook

## A basic view

The README example, annotated:

```html
<div class="hello-world">
  <input type="text">
  <button>Greet</button>
  <span class="output"></span>
</div>
```

```rb
require 'opal'
require 'jquery'                                  # your own jQuery version
require 'receptive'

class HelloWorld
  extend Receptive::View

  self.selector = ".hello-world"                  # this will set the root-node for our view

                                                  # `on` takes an event, and optionally a selector
                                                  # leaving the selector black will listen for events
  on :click, 'button' do |event|                  # on the root-node

    @greeting_text = find('input').text           # `find` operates only on inside the root-node

    render!                                       # `render!` will execute the render method below
  end                                             # wrapped in `requestAnimationFrame()`

  def self.render                                 # where possible is advisable to separate data collection
    find('.output').text = @greeting_text         # from the rendering/updating of the node, this has been
  end                                             # proven almost invariably useful in managing UI interactions
end

Receptive::App.run
```

---

*upcoming chapters…*

## Application lifecycle
## Events
## Incremental DOM
## The `render!` method
## `window` and `document` events
## Why still jQuery?
## Using actions and the global status


