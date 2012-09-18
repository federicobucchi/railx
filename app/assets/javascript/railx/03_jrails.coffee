
$(document).ready ->
  $("body").append("<div id='none' style ='display:none'></div>")

$("a").live "click", (e) ->
  e.preventDefault()
  url = $(this).attr("href").replace(location.protocol + "//" + location.host, "")
  target = (if @dataset.target then ("#" + @dataset.target) else "container")
  s = History.getState()
  console.log s.url    
  console.log document.location.origin + url
  if s.url == document.location.origin + url
    ajaxLoader
      url: url
      target: target
  else  
    History.pushState
      target: target
    , document.title, url
    
History.Adapter.bind window, "statechange", -> # Note: We are using statechange instead of popstate
  state = History.getState() # Note: We are using History.getState() instead of event.state
  target = state.target || "#{window.Railx.default_target}"    
  console.log(target)
  ajaxLoader
    url: state.url
    target: target
  
console.log("montato")
window.Railx = {
  default_target: "body",
  link_selector: "a",
  form_selector: "form",
  postloads: null,
  use_gritter: true,
  _postload: ->
    $("form").ajax_form()
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
  postload: ->    
    
}

