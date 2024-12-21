module OmniRegion
  module GeoJson
    class Base
      class << self
        def find_by(longitude:, latitude:)
          detected = "#{self.name}::Scope".constantize.find do |feature|
            point = RGeo::Cartesian.preferred_factory.point(longitude, latitude)
            feature.contains?(point)
          rescue StandardError => e
            Rails.logger.error "#{self.name} find #{e.class}: #{e.message}"
            nil
          end
          Rails.logger.info "#{self.name} detected(#{longitude},#{latitude}): #{detected[:name]} #{detected[:gb]}"

          return {} if detected.blank?

          { self.name.demodulize.underscore.to_sym => detected[:name], division_code: detected[:gb].sub(/^156/, "") }.compact_blank
        end
      end
    end
  end
end
