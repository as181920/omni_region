# OmniRegion
通用区划信息(Rails engine)

## Installation

Install dependencies make sure RGeo::Geos.capi_supported?

```bash
apt install libgeos++-dev libgeos3.10.2 libgeos-c1v5
```

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

### Load https://github.com/dr5hn/countries-states-cities-database
```ruby
require "yaml"
require "active_support/all"
data = YAML.load_file "/home/andersen/public_projects/countries-states-cities-database/yml/countries+states+cities.yml"

data["country_state_city"].each do |c_data|
  country = OmniRegion::Country.find_or_create_by!(name: c_data["name"], code: c_data["iso2"])

  c_data["states"].each do |p_data|
    province = country.provinces.find_or_create_by!(name: p_data["name"], code: [country.code, p_data["state_code"]].join("-"))

    p_data["cities"].each do |city_data|
      city = province.cities.find_or_create_by!(name: city_data["name"], code: city_data["id"])
    end
  end
end;puts
```

### Load https://github.com/zepc007/GlobalCityData/blob/main/data_region.json
```ruby
require "json"
require "active_support/all"
data = JSON.load_file "/home/andersen/Nextcloud/Documents/OpenData/GlobalCityData/data_region.json"

data.each do |country_name, c_data|
  country = OmniRegion::Country.find_or_create_by!(name: country_name, code: country_name)

  Array(c_data["children"]).compact_blank.each do |p_data|
    province = country.provinces.find_or_create_by!(name: p_data["label_en"], code: [country_name, p_data["label_en"]].join("-"))

    Array(p_data["children_en"]).compact_blank.each do |city_name|
      city = province.cities.find_or_create_by!(name: city_name, code: [country_name, p_data["label_en"], city_name].join("-"))
    rescue => e
      puts country.name
      puts province.name
      puts city_name
      raise
    end
  end
end
```

### Load maxmind geolite-city data, Not recommended yet!!
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

OmniRegion::Country.find_by(name: "Taiwan")&.update(name: "Taiwan, China")
OmniRegion::Country.find_by(name: "Hong Kong")&.update(name: "Hong Kong, China")
OmniRegion::Country.find_by(name: "Macao")&.update(name: "Macao, China")

# Standalone geo pickup link

https://lbs.qq.com/getPoint/

# Standalone geo locate link

https://lbsyun.baidu.com/jsdemo/demo/yLngLatLocation.htm
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
