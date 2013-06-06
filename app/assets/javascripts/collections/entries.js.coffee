class App.Collections.Entries extends Backbone.Collection
  model: App.Models.Entry
  url: '/api/entries'
  
  drawWinner: ->
    winner = _.shuffle(@where(winner: null))[0]
    winner.win() if winner
