class App.Routers.Entries extends Backbone.Router
  routes:
    '': 'index'
    # 'entries/:id': 'show'
                
  initialize: ->
    _.bindAll @
                
  index: ->
    new App.Views.CurrentLocation
    new App.Views.EntriesIndex

  # show: (id) ->
  #   alert "Entry: #{id}"