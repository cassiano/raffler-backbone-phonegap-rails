class App.Views.Entry extends Backbone.View
  template: JST['entries/entry']

  tagName: 'li'

  events:
    'click': 'showEntry'
    
  initialize: ->
    _.bindAll @
    
    @model.on 'change:winner', @render
    @model.on 'highlight', @highlightWinner
    
  highlightWinner: ->
    $('.winner').removeClass 'highlight'
    @$('.winner').addClass 'highlight'
  
  render: ->
    $(@el).html @template(entry: @model)
    @

  showEntry: ->
    Backbone.history.navigate "entries/#{@model.get('id')}", true