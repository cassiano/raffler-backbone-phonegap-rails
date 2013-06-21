class App.Views.Entry extends Backbone.View
  template: JST['entries/entry']

  tagName: 'li'
  
  events: 
    'click a.delete_entry': 'delete'
  
  initialize: (options) ->
    _.bindAll @
    
    @parentView = options.parentView
    
    @model.on 'change:winner',  @render
    @model.on 'highlight',      @highlightWinner
    @model.on 'remove',         @remove
    
  highlightWinner: ->
    $('.winner').removeClass 'highlight'
    @$('.winner').addClass 'highlight'
    @parentView.refreshListView()
  
  render: ->
    @$el.html @template(entry: @model)
    # @$('.delete_entry').trigger('start')
    @

  delete: (event) ->
    event.preventDefault()
    @model.destroy()