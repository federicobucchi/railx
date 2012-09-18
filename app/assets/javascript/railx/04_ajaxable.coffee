(($) ->
  $.fn.ajax_link = ->
    @each ->
      options = @dataset
      options.url = $(this).attr("href")
      ajaxLoader(options)
) jQuery      

(($) ->
  $.fn.ajax_form = ->
    @each ->
      target = @dataset.target || Railx.default_target
      console.log(target)
      opt =
        headers:
          TARGET: target
        target: $(target)
        type: @dataset.method || "POST"
        
        # TODO fix jquery.form.js 165 -182            
        iframe: false 
        success: (response, status, xhr, form) ->  
          console.log("status", xhr.getAllResponseHeaders())                       
          Railx._postload()
        complete: (response, status, xhr, form) ->
          
        beforeSubmit: (data, form, options) ->          
      $(this).ajaxForm opt 
) jQuery      

window.ajaxLoader = (options) ->
  $.ajax
    url: options.url
    type: options.method
    success: (data) ->
      target = options.target     
      #console.log($(target))
      $(target).html(data) 
      Railx._postload()
    complete: (data, status) -> 
      if status == "error"
        Railx.raise
          type: "error"
          text: data.error().statusText    
        console.log status, data      