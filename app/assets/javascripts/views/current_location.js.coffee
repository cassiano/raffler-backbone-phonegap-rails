class App.Views.CurrentLocation extends Backbone.View
  el: '#current_location'
  
  initialize: ->
    _.bindAll @

    @render()

  render: (refreshPosition = false) ->
    if @position? and not refreshPosition
      @renderWithPosition @position
    else
      navigator.geolocation.getCurrentPosition @renderWithPosition, @showPositionError
    
  renderWithPosition: (position) ->
    @position = position
    
    mapCoords = new google.maps.LatLng @lat(), @lng()

    options =
      center: mapCoords
      zoom: 17
      mapTypeId: google.maps.MapTypeId.ROADMAP
      mapTypeControl: false
      navigationControlOptions:
        style: google.maps.NavigationControlStyle.SMALL

    @$el.show()

    map     = new google.maps.Map @el, options
    marker  = new google.maps.Marker position: mapCoords, map: map, title: "You are here!"

  showPositionError: (error) ->
    alert "Code: #{error.code}\nMessage: #{error.message}"

  lat: -> @position?.coords.latitude
  lng: -> @position?.coords.longitude
