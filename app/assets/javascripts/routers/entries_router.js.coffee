class App.Routers.Entries extends Backbone.Router
  routes:
    '': 'index'
    'entries/:id': 'show'
                
  initialize: ->
    _.bindAll @
                
  index: ->
    new App.Views.CurrentLocation
    new App.Views.EntriesIndex

  show: (id) ->
    entry = @view?.collection.get(id)
    alert "Entry: #{if entry then entry.get('name') else id}"