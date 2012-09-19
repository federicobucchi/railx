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
          console.log("status", status)                       
          Railx._postload()
        complete: (response, status, xhr, form) ->
          Railx.stop_loading()
          console.log "ERROR", response, status, xhr
        beforeSubmit: (data, form, options) ->  
          Railx.start_loading()        
      $(@).ajaxForm opt 
) jQuery 

  