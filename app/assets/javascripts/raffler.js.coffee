window.App =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  start: -> 
    new @Routers.Entries
    Backbone.history.start pushState: true
