module OmniRegion
  class ApiDocsController < ApplicationController
    def index
      @openapi_spec_path = openapi_spec_path
    end

    def openapi
      send_file(
        openapi_root_dir.join("openapi.json"),
        type: "application/json; charset=utf-8",
        disposition: "inline"
      )
    end

    def openapi_file
      file_path = allowed_openapi_files[requested_openapi_relative_path]
      return head :not_found unless file_path

      send_file file_path, type: detect_content_type(file_path), disposition: "inline"
    end

    private

      def openapi_root_dir
        OmniRegion::Engine.root.join("config/openapi")
      end

      def detect_content_type(file_path)
        case File.extname(file_path.to_s)
        when ".json"
          "application/json; charset=utf-8"
        when ".yaml", ".yml"
          "application/yaml; charset=utf-8"
        else
          "text/plain; charset=utf-8"
        end
      end

      def requested_openapi_relative_path
        relative_path = params[:path].to_s
        if params[:format].present? && File.extname(relative_path).blank?
          relative_path = "#{relative_path}.#{params[:format]}"
        end

        relative_path = Pathname.new(relative_path).cleanpath.to_s
        relative_path = relative_path.delete_prefix("openapi/")
        return if relative_path.blank? || relative_path.start_with?("..") || relative_path.include?("\\")

        relative_path
      end

      def allowed_openapi_files
        @allowed_openapi_files ||= Dir.glob(openapi_root_dir.join("**", "*")).filter_map do |path|
          next unless File.file?(path)

          pathname = Pathname.new(path)
          [pathname.relative_path_from(openapi_root_dir).to_s, pathname]
        end.to_h
      end
  end
end
