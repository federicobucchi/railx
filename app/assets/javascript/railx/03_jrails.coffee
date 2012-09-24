
$(document).ready ->
  Railx.init()
  
window.Railx = {
  default_target: "body",
  postloads: null,
  use_gritter: true,
  link_selector: "a[href!='javascript:;']:not(.noajax)",
  form_selector: "form:not(.noajax)", 
  _postload: ->
    $(@form_selector).ajax_form()
    if @.postloads
      console.log @.postloads
      if @.postloads.update
        for i of @.postloads.update
          item = @.postloads.update[i]
          $(item.target).html(item.html)
      if @.postloads.redirect    
        History.pushState
          target: @.postloads.redirect.target
        , document.title, @.postloads.redirect.url   
    @.postload()
  raise: (args) -> # text, type, sticky
    args.image = ("/assets/" + args.type + ".png")
    args.title = args.type
    args.sticky = args.sticky || false
    if @use_gritter
      $.gritter.add(args)
    console.log(args)
  start_loading: (text) ->
   $("#loading_text").html(text) 
   $("#loading").show()     
  stop_loading: ->
   $("#loading").hide()     
  ajax: (options) ->
    @start_loading()
    $.ajax
      url: options.url
      type: options.method
      success: (data) ->
        target = options.target
        $(target).html(data) 
        Railx._postload()
      complete: (data, status) -> 
        Railx.stop_loading()
        if status == "error"
          Railx.raise
            type: "error"
            text: data.error().statusText    
          console.log status, data    
  postload: ->      
                 
  init: ->
    # Append a div for ajax requests that don't need to fill content 
    $("body").append("<div id='none' style ='display:none'></div>") 
    if $("#loading").length == 0
      $("body").append("<div id='loading'><div id='loading_text'></div></div>")
    # manage history 
    History.Adapter.bind window, "statechange", -> # Note: We are using statechange instead of popstate
      state = History.getState() # Note: We are using History.getState() instead of event.state
      target = state.target || "#{window.Railx.default_target}"    
      console.log(target)
      Railx.ajax
        url: state.url
        target: target
    # ajaxify links
    $(@link_selector).live "click", (e) ->
      e.preventDefault()
      url = $(this).attr("href").replace(location.protocol + "//" + location.host, "")
      target = (if @dataset.target then ("#" + @dataset.target) else @default_target)
      s = History.getState()
      if s.url == document.location.origin + url
        Railx.ajax
          url: url
          target: target
      else  
        History.pushState
          target: target
        , document.title, url   
    @_postload()                
}

