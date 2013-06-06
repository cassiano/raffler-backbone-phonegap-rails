class App.Views.EntriesIndex extends Backbone.View
  el: '#container'
  
  template: JST['entries/index']
  
  events:
    'submit #new_entry': 'createEntry'
    'click #draw': 'drawWinner'
  
  drawWinner: (event) ->
    event.preventDefault()
    @collection.drawWinner()
                
  initialize: ->
    _.bindAll @

    @collection = new App.Collections.Entries

    @collection.on 'reset', @render
    @collection.on 'add',   @appendEntry

    @collection.reset $('#container').data('entries')

    @render()

  render: ->
    $(@el).html @template()
    @collection.each @appendEntry
    @

  appendEntry: (entry) ->
    view = new App.Views.Entry(model: entry)
    $('#entries').append view.render().el
        
  createEntry: (event) ->
    event.preventDefault()

    attributes = name: $('#new_entry_name').val()
    @collection.create attributes,
      wait: true
      success: -> $('#new_entry')[0].reset()
      error: @handleError

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
