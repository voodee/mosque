window.jQuery     = window.$ = require 'jquery'
plugin            = require 'plugin'



(($) ->
  if $('.royal_preloader').length
    require './lib/royal_preloader.min.js'
    Royal_Preloader.config
      mode: "logo"
      logo: "img/logo.png"
      logo_size: [213, 248]
      showInfo: true
      opacity: 1
      showProgress: true
      showPercentage: true
      text_colour: '#ссс'
      background: '#ffffff'
) jQuery




$(document).ready ->

  require './map.coffee'

  require './lib/jquery.nicescroll.js'
  require './lib/scroll.coffee'

  require './lib/jquery.reveal.js'


  require './lib/jquery.maskedinput.min.js'
  $('input[name=tel]').mask('+7 (999) 999-99-99')

  require './lib/jquery.fancybox.js'
  $('.fancybox').fancybox()

  $('.help-smeta').niceScroll
    cursorcolor: '#1A212C'
    zindex: '99999'
    cursorminheight: 60
    scrollspeed: 80
    cursorwidth: 7
    autohidemode: false
    background: '#aaa'
    cursorborder: 'none'
    cursoropacitymax: .7
    cursorborderradius: 0
    horizrailenabled: false


  window.sweetAlert = require './lib/sweet-alert.js'

  $('form').submit (e) ->
    e.preventDefault()
    that = this
    $.ajax
      type: 'POST'
      url: 'order.php'
      data: $(that).serialize()
      timeout: 6000
      error: (request, error) ->
        sweetAlert "Обнаружена ошибка", "", "error"

      success: (request) ->
        if request == true
          sweetAlert "Заявка принята!", " ", "success"

          $(that).reset()

        else
          sweetAlert "Обнаружена ошибка", request, "error"
    false


console.log 'load completed'