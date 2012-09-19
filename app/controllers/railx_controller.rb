module RailxController
  @ajax_render_filters = []
  def updatediv id, partial, args = {}
    puts id
    puts partial
    if request.xhr?
      
      session[:railx] = {} unless session[:railx].present?
      session[:railx][:update] = [] unless session[:railx][:update].present?
      session[:railx][:update] << {
        :target => "##{id}", 
        :html => (render_to_string({
          :partial => partial , :layout => false, :locals => args 
        }))
      }    
    end  
  end
        
  def redirect_to(options = {}, response_status = {})
    puts "called redirect #{response_status}"
    if request.xhr?
      session[:railx] = {} unless session[:railx].present?
      session[:railx][:redirect] = {
        :target => request.headers["TARGET"],
        :url => _compute_redirect_to_location(options)
      } 
      flash.keep
      puts "rendering nothing"
      render :nothing => true
     #return false
    else 
      super(options, response_status)
    end    
  end
      
  def render(options = {}, extra_options = {}, &block)
    puts "************* railx *************************"
    #y session    
    # render also popstloads
    if request.xhr?
      flash.discard unless response.status == :found      
      options = options.class == Hash ? options : {}
      new_options = {:layout => "ajax_railx"}.merge(options) 
      super(new_options, extra_options, &block)
    else
      super(new_options, extra_options, &block)
    end
  end
    
end  