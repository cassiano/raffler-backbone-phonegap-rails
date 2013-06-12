class App.Views.EntriesIndex extends Backbone.View
  el: '#container'
  
  template: JST['entries/index']
  
  events:
    'submit form#new_entry':  'createEntry'
    'click  button#draw':     'drawWinner'
    'click  a.delete_entry':  'deleteEntry'
  
  drawWinner: (event) ->
    event.preventDefault()
    @collection.drawWinner()
                
  initialize: ->
    _.bindAll @
    
    # @modelViews = []

    @collection = new App.Collections.Entries

    @collection.on 'reset', @render
    @collection.on 'add',   @appendEntry

    @collection.reset @$el.data('entries')

    @render()

  render: ->
    @$el.html @template
    @collection.each @appendEntry
    @

  appendEntry: (entry) ->
    view = new App.Views.Entry(model: entry)
    # @modelViews.push view
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

  deleteEntry: (event) ->
    event.preventDefault()

    # entryId = @_extractEntryId(event.target.id)
    # view = @_findEntryView(entryId)
    # view.model.destroy()

    entryId = @_extractEntryId(event.target.id)
    entry = @collection.get(entryId)
    entry.destroy()

  # _findEntryView: (entryId) ->
  #   _.find @modelViews, (v) -> v.model.get('id') == entryId

  _extractEntryId: (name) ->
    parseInt /entry_(\d+)/.exec(name)[1]
