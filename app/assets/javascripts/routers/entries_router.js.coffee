class App.Routers.Entries extends Backbone.Router
  routes:
    '': 'index'
    'entries/:id': 'show'
                
  initialize: ->
    _.bindAll @
                
  index: ->
    @changePage new App.Views.EntriesIndex

  show: (id) ->
    alert "Entry: #{id}"
  
  changePage: (page) ->
    page.$el.attr 'data-role', 'page'
    page.render()
    $('body').append page.$el
    $.mobile.changePage page.$el, changeHash: false
    window.setTimeout (-> page.$el.trigger('create')), 100
