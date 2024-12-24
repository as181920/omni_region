module OmniRegion
  module GeoJson
    class Base
      class << self
        def find_by(longitude:, latitude:) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          detected = "#{name}::Scope".constantize.find do |feature|
            feature.contains? RGeo::Cartesian.preferred_factory.point(longitude.to_f, latitude.to_f)
          rescue RGeo::Error::InvalidGeometry => e
            Rails.logger.error "#{name} find #{e.class}: #{e.message}, retry by make_valid"
            feature.make_valid.contains? RGeo::Cartesian.preferred_factory.point(longitude.to_f, latitude.to_f)
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
