class App.Views.EntriesIndex extends Backbone.View
  template: JST['entries/index']
  
  events:
    'submit form#new_entry': 'createEntry'
    'click  button#draw':    'drawWinner'
  
  drawWinner: (event) ->
    event.preventDefault()
    @collection.drawWinner()
                
  initialize: ->
    _.bindAll @
    
    @collection = new App.Collections.Entries

    @collection.on 'reset', @render
    @collection.on 'add',   @appendEntry

    @collection.fetch reset: true

  render: ->
    @$el.html @template
    @collection.each @appendEntry
    @

  appendEntry: (entry) ->
    view = new App.Views.Entry(model: entry, parentView: @)
    
    @$('#entries').append view.render().el
    
    @refreshListView()

  refreshListView: ->
    try 
      @$('#entries').listview 'refresh'

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
      
      $('#validation_error_messages').empty()
      
      for attribute, messages of errors
        for message in messages
          $('#validation_error_messages').append "<li>#{attribute} #{message}</li>"
        
      $("#validation_errors").popup('open')
