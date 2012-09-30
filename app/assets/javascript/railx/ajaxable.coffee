(($) ->
  $.fn.ajax_form = ->
    @each ->
      target = @dataset.target || Railx.default_target
      #console.log(target)
      opt =
        headers:
          TARGET: target
        target: $(target)
        type: @method || "POST"        
        # TODO fix jquery.form.js 165 -182            
        iframe: false 
        success: (response, status, xhr, form) ->  
          console.log("status", status)                       
          Railx._postload()
        complete: (response, status, xhr, form) ->
          Railx.stop_loading()
          if response.status != 200
            Railx.raise
              type: "error"
              text: response.statusText
          
        beforeSubmit: (data, form, options) ->  
          Railx.start_loading()        
      $(@).ajaxForm opt 
) jQuery 

  