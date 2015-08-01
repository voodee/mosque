
#Check IE11

IEVersion = ->
  if ! !navigator.userAgent.match(/Trident\/7\./)
    return 11
  return
  
if IEVersion() != 11
  $('html').niceScroll
    cursorcolor: '#1A212C'
    zindex: '99999'
    cursorminheight: 60
    scrollspeed: 80
    cursorwidth: 7
    autohidemode: true
    background: '#aaa'
    cursorborder: 'none'
    cursoropacitymax: .7
    cursorborderradius: 0
    horizrailenabled: false

triggerAnimation = ->
  if MQ == 'desktop'
    #if on desktop screen - animate sections
    if !window.requestAnimationFrame then animateSection() else window.requestAnimationFrame(animateSection)
  else
    #on mobile - remove the style added by jQuery 
    $('.section').find('.cd-block').removeAttr('style').find('.cd-half-block').removeAttr 'style'
  #update navigation arrows visibility
  checkNavigation()
  return

animateSection = ->
  scrollTop = $(window).scrollTop()
  windowHeight = $(window).height()
  windowWidth = $(window).width()
  $('.section').each ->
    actualBlock = $(this)
    offset = scrollTop - actualBlock.offset().top
    scale = 1
    translate = windowWidth / 2 + 'px'
    opacity = undefined
    boxShadowOpacity = undefined

    if offset >= -windowHeight and offset <= 0
      #move the two .cd-half-block toward the center - no scale/opacity effect
      scale = 1
      opacity = 1
      translate = (windowWidth * .6 * (- offset/windowHeight)).toFixed(0) + 'px'

    else if offset > 0 and offset <= windowHeight
      #the two .cd-half-block are in the center - scale the .cd-block element and reduce the opacity
      _offset = Math.max offset - windowHeight * .15, 0
      _offset = _offset * 1.15
      translate = 0 + 'px'
      scale = (1 - (_offset * scaleSpeed / windowHeight)).toFixed(5)
      opacity = (1 - (_offset / windowHeight)).toFixed(5)
    else if offset < -windowHeight
      #section not yet visible
      scale = 1
      translate = windowWidth / 2 + 'px'
      opacity = 1
    else
      #section not visible anymore
      opacity = 0
    boxShadowOpacity = parseInt(translate.replace('px', '')) * boxShadowOpacityInitialValue / 20
    #translate/scale section blocks
    scaleBlock actualBlock.find('.cd-block'), scale, opacity
    directionFirstChild = if actualBlock.is(':nth-of-type(odd)') then '-' else '+'
    directionSecondChild = if actualBlock.is(':nth-of-type(odd)') then '+' else '-'
    if actualBlock.find('.cd-half-block')
      translateBlock actualBlock.find('.cd-half-block').eq(0), directionFirstChild + translate, boxShadowOpacity
      translateBlock actualBlock.find('.cd-half-block').eq(1), directionSecondChild + translate, boxShadowOpacity
    #this is used to navigate through the sections
    if offset >= 0 and offset < windowHeight then actualBlock.addClass('is-visible') else actualBlock.removeClass('is-visible')
    return
  return

translateBlock = (elem, value, shadow) ->
  position = Math.ceil(Math.abs(value.replace('px', '')))
  if position >= $(window).width() / 2
    shadow = 0
  else if position > 20
    shadow = boxShadowOpacityInitialValue
  elem.css
    '-moz-transform': 'translateX(' + value + ')'
    '-webkit-transform': 'translateX(' + value + ')'
    '-ms-transform': 'translateX(' + value + ')'
    '-o-transform': 'translateX(' + value + ')'
    'transform': 'translateX(' + value + ')'
    'box-shadow': '0px 0px 40px rgba(0,0,0,' + shadow + ')'
  return

scaleBlock = (elem, value, opac) ->
  elem.css
    '-moz-transform': 'scale(' + value + ')'
    '-webkit-transform': 'scale(' + value + ')'
    '-ms-transform': 'scale(' + value + ')'
    '-o-transform': 'scale(' + value + ')'
    'transform': 'scale(' + value + ')'
    'opacity': opac
  return

nextSection = ->
  if !animating
    if $('.section.is-visible').next().length > 0
      smoothScroll $('.section.is-visible').next()
  return

prevSection = ->
  `var prevSection`
  if !animating
    prevSection = $('.section.is-visible')
    if prevSection.length > 0 and $(window).scrollTop() != prevSection.offset().top
      smoothScroll prevSection
    else if prevSection.prev().length > 0 and $(window).scrollTop() == prevSection.offset().top
      smoothScroll prevSection.prev('.section')
  return

checkNavigation = ->
  # ( $(window).scrollTop() < $(window).height()/2 ) ? $('.cd-vertical-nav .cd-prev').addClass('inactive') : $('.cd-vertical-nav .cd-prev').removeClass('inactive');
  # ( $(window).scrollTop() > $(document).height() - 3*$(window).height()/2 ) ? $('.cd-vertical-nav .cd-next').addClass('inactive') : $('.cd-vertical-nav .cd-next').removeClass('inactive');
  if $(window).scrollTop() < $(window).height() / 2 then $('.cd-vertical-nav .cd-prev').addClass('inactive') else $('.cd-vertical-nav .cd-prev').removeClass('inactive')
  if $(window).scrollTop() < $(window).height() / 2 then $('.cd-vertical-nav .cd-next').addClass('inactive1') else $('.cd-vertical-nav .cd-next').removeClass('inactive1')
  if $(window).scrollTop() > $(document).height() - (3 * $(window).height() / 2) then $('.cd-vertical-nav .cd-next').addClass('inactive') else $('.cd-vertical-nav .cd-next').removeClass('inactive')
  return

smoothScroll = (target) ->
  animating = true
  $('body,html').animate { 'scrollTop': target.offset().top }, 500, ->
    animating = false
    return
  return

#change this value if you want to change the speed of the scale effect
scaleSpeed = 0.3
boxShadowOpacityInitialValue = 0.7
animating = false
#check the media query 
MQ = window.getComputedStyle(document.querySelector('body'), '::before').getPropertyValue('content').replace(/"/g, '')
$(window).on 'resize', ->
  MQ = window.getComputedStyle(document.querySelector('body'), '::before').getPropertyValue('content').replace(/"/g, '')
  return
#bind the animation to the window scroll event
triggerAnimation()
$(window).on 'scroll', ->
  triggerAnimation()

$(document).keydown (event) ->
  if event.which == '38'
    prevSection()
    event.preventDefault()
  else if event.which == '40'
    nextSection()
    event.preventDefault()

$('.link2map, .link2shema, .link2help').click (e) ->
  e.preventDefault()
  nextSection()
