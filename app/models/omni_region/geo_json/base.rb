module OmniRegion
  module GeoJson
    class Base
      class << self
        def find_by(longitude:, latitude:)
          detected = "#{name}::Scope".constantize.find do |feature|
            point = RGeo::Cartesian.preferred_factory.point(longitude, latitude)
            feature.contains?(point)
          rescue StandardError => e
            Rails.logger.error "#{name} find #{e.class}: #{e.message}"
            nil
          end
          Rails.logger.info "#{name} detected(#{longitude},#{latitude}): #{detected&.properties.to_json}"

          return {} if detected.blank?

          { name.demodulize.underscore.to_sym => detected[:name], division_code: detected[:gb]&.sub(/^156/, "") }.compact_blank
        end
      end
    end
  end
end
