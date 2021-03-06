class App.Views.EntriesIndex extends Backbone.View
  el: '#container'
  
  template: JST['entries/index']
  
  events:
    'submit form#new_entry':  'createEntry'
    'click  button#draw':     'drawWinner'
    'click a.delete_entry':   'delete_entry'
  
  drawWinner: (event) ->
    event.preventDefault()
    @collection.drawWinner()
                
  initialize: ->
    _.bindAll @
    
    @views = []
    
    @collection = new App.Collections.Entries

    @listenTo @collection, 'reset', @render
    @listenTo @collection, 'add',   @appendEntry

    @collection.reset @$el.data('entries')

    @render()

  render: ->
    @$el.html @template()
    @collection.each @appendEntry
    @

  appendEntry: (entry) ->
    view = new App.Views.Entry(model: entry)
    
    @views.push view
    
    @$('#entries').append view.render().el
        
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
  
  delete_entry: (event) ->
    event.preventDefault()
    entryId = parseInt(/entry_(\d+)/.exec(event.target.id)[1])
    
    view = _.find @views, (v) -> v.model.get('id') == entryId
    
    view.delete event
    