class App.Views.Entry extends Backbone.View
  template: JST['entries/entry']

  tagName: 'li'
  
  # events: 
  #   'click a.delete_entry': 'delete'
  
  initialize: ->
    _.bindAll @
    
    @listenTo @model, 'change:winner',  @render
    @listenTo @model, 'highlight',      @highlightWinner
    @listenTo @model, 'remove',         @remove
    
  highlightWinner: ->
    $('.winner').removeClass 'highlight'
    @$('.winner').addClass 'highlight'
  
  render: ->
    @$el.html @template(entry: @model)
    @

  delete: (event) ->
    event.preventDefault()
    @model.destroy()