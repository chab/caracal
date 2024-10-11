require 'caracal/core/models/base_model'


module Caracal
  module Core
    module Models

      # This class handles block options passed to the page size
      # method.
      #
      class PageSizeModel < BaseModel

        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------

        # constants
        const_set(:DEFAULT_PAGE_WIDTH,                        12240)  # 8.5in  in twips
        const_set(:DEFAULT_PAGE_HEIGHT,                       15840)  # 11.0in in twips
        const_set(:DEFAULT_PAGE_ORIENTATION,                  'portrait')
        const_set(:DEFAULT_PAGE_HEADER_FOOTER_ON_FIRST_PAGE,  true)

        # accessors
        attr_reader :page_width
        attr_reader :page_height
        attr_reader :page_orientation
        attr_reader :page_header_footer_on_first_page

        # initialization
        def initialize(options={}, &block)
          @page_width                       = DEFAULT_PAGE_WIDTH
          @page_height                      = DEFAULT_PAGE_HEIGHT
          @page_orientation                 = DEFAULT_PAGE_ORIENTATION
          @page_header_footer_on_first_page = DEFAULT_PAGE_HEADER_FOOTER_ON_FIRST_PAGE

          super options, &block
        end


        #-------------------------------------------------------------
        # Public Methods
        #-------------------------------------------------------------

        #=============== SETTERS ==============================

        def height(value)
          @page_height = value.to_i
        end

        def orientation(value)
          allowed = ['landscape','portrait']
          given   = value.to_s.downcase
          @page_orientation = allowed.include?(given) ? given : 'portrait'
        end

        def width(value)
          @page_width = value.to_i
        end

        def header_footer_on_first_page(value)
          @page_header_footer_on_first_page = value
        end


        #=============== VALIDATION ==============================

        def valid?
          dims = [page_width, page_height]
          dims.all? { |d| d > 0 }
        end


        #-------------------------------------------------------------
        # Private Instance Methods
        #-------------------------------------------------------------
        private

        def option_keys
          [:width, :height, :orientation, :header_footer_on_first_page]
        end

      end

    end
  end
end
