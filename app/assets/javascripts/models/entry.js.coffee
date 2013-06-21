class App.Models.Entry extends Backbone.Model
  win: ->
    @set winner: true
    @save()
    @trigger 'highlight'
    
  # validate: (attrs, options) ->
  #   "name is required" unless !!attrs.name