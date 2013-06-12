class App.Views.Entry extends Backbone.View
  template: JST['entries/entry']

  tagName: 'li'

  # events:
  # #   'click': 'showEntry'
  #   'click a.delete_entry': 'delete'
    
  initialize: ->
    _.bindAll @
    
    @model.on 'change:winner',  @render
    @model.on 'highlight',      @highlightWinner
    @model.on 'destroy',        @remove
    
  highlightWinner: ->
    $('.winner').removeClass 'highlight'
    @$('.winner').addClass 'highlight'
  
  render: ->
    @el.id = 'entry_' + @model.get('id')
    @$el.html @template(entry: @model)
    @

  # showEntry: ->
  #   Backbone.history.navigate "entries/#{@model.get('id')}", true

  # delete: (event) ->
  #   event.preventDefault()
  #   @model.destroy()
