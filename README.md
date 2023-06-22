# OmniRegion
通用区划信息(Rails engine)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'omni_region', git: "git@github.com:as181920/omni_region.git", branch: "master"
```

## Usage
source data: https://github.com/modood/Administrative-divisions-of-China

### Load china administrative divisions data:

```ruby
require "csv"
data_file_path = "/home/andersen/public_projects/Administrative-divisions-of-China/dist"
country = OmniRegion::Country.find_or_create_by code: 156, name: '中国'

x=CSV.read "#{data_file_path}/provinces.csv"
x[1..-1].each{|code,name| country.provinces.find_or_create_by code: code, name: name}

x=CSV.read "#{data_file_path}/cities.csv"
x[1..-1].each{|code,name, pcode| OmniRegion::City.find_or_create_by! code: code, name: name, province: OmniRegion::Province.find_by(code: pcode)}

x=CSV.read "#{data_file_path}/areas.csv"
x[1..-1].each{|code,name,ccode, pcode| OmniRegion::District.find_or_initialize_by(code: code).update!(name: name, city: OmniRegion::City.find_by(code: ccode)) }
```

### Load maxmind geolite-city data
```ruby
require "csv"
require "active_support/all"
data_file_path = "/home/andersen/Nextcloud/Documents/OpenData/GeoLite2-City-CSV_20230620/GeoLite2-City-Locations-en.csv"
rows=CSV.foreach(data_file_path, headers: true)

# load countries data
rows.each do |row|
  next if row["country_name"].blank?

  OmniRegion::Country.find_or_create_by! name: row["country_name"], code: row["country_iso_code"]
rescue
  pp row
  raise
end

# load subdivisions data
rows.each do |row|
  next if row["subdivision_1_name"].blank?

  OmniRegion::Province.find_or_create_by! \
  name: row["subdivision_1_name"],
  code: [row["country_iso_code"], row["subdivision_1_iso_code"]].join("-"),
  country: OmniRegion::Country.find_by(code: row["country_iso_code"])
rescue
  pp row
  raise
end

# load city data
rows.each do |row|
  next if row["city_name"].blank?

  province = OmniRegion::Province.find_by(code: [row["country_iso_code"], row["subdivision_1_iso_code"]].join("-"))
  next if province.blank?

  # OmniRegion::Division.find_by(code: row["geoname_id"])&.destroy

  OmniRegion::City.find_or_create_by! \
  name: row["city_name"],
  code: row["geoname_id"],
  province:
rescue
  pp row
  raise
end
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
