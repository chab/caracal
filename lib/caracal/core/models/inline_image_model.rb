require 'caracal/core/models/base_model'

module Caracal
  module Core
    module Models
      
      # This class handles inline image options passed to the img method within paragraphs.
      #
      class InlineImageModel < BaseModel
        
        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------
        
        # constants
        const_set(:DEFAULT_IMAGE_PPI,     72)       # pixels per inch
        const_set(:DEFAULT_IMAGE_WIDTH,   0)        # units in pixels. (will cause error)
        const_set(:DEFAULT_IMAGE_HEIGHT,  0)        # units in pixels. (will cause error)
        
        # accessors
        attr_reader :image_url
        attr_reader :image_data
        attr_reader :image_ppi
        attr_reader :image_width
        attr_reader :image_height
        
        # initialization
        def initialize(options={}, &block)
          @image_ppi    = DEFAULT_IMAGE_PPI
          @image_width  = DEFAULT_IMAGE_WIDTH
          @image_height = DEFAULT_IMAGE_HEIGHT
          
          super options, &block
        end
        
        
        #-------------------------------------------------------------
        # Public Methods
        #-------------------------------------------------------------
        
        #=============== GETTERS ==============================
        
        [:width, :height].each do |m|
          define_method "formatted_#{ m }" do
            value = send("image_#{ m }")
            pixels_to_emus(value, image_ppi)
          end
        end
        
        def relationship_target
          image_data || image_url
        end
        
        
        #=============== SETTERS ==============================
        
        # integers
        [:ppi, :width, :height].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@image_#{ m }", value.to_i)
          end
        end
        
        # strings
        [:data, :url].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@image_#{ m }", value.to_s)
          end
        end

        #=============== VALIDATION ==============================
        
        def valid?
          dims = [:ppi, :width, :height].map { |m| send("image_#{ m }") }
          dims.all? { |d| d > 0 } && (image_url.to_s.size > 0 || image_data.to_s.size > 0)
        end
        
        
        #-------------------------------------------------------------
        # Private Methods
        #-------------------------------------------------------------
        private
        
        def option_keys
          [:url, :width, :height, :data]
        end
        
        def pixels_to_emus(value, ppi)
          pixels        = value.to_i
          inches        = pixels / ppi.to_f
          emus_per_inch = 914400
        
          emus = (inches * emus_per_inch).to_i 
        end
        
      end
      
    end
  end
end
