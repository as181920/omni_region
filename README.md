# OmniRegion
通用区划信息(Rails engine)

## Usage
source data: https://github.com/modood/Administrative-divisions-of-China

Load data:
country = OmniRegion::Country.find_or_create_by code: 156, name: '中国' # country code use ISO 3166

x=CSV.read "path/Administrative-divisions-of-China/dist/provinces.csv" 
x[1..-1].each{|code,name| country.provinces.create code: code, name: name}

x=CSV.read "path/Administrative-divisions-of-China/dist/cities.csv"
x[1..-1].each{|code,name, pcode| OmniRegion::City.find_or_create_by! code: code, name: name, province: OmniRegion::Province.find_by(code: pcode)}

x=CSV.read "path/Administrative-divisions-of-China/dist/areas.csv"
x[1..-1].each{|code,name,ccode, pcode| OmniRegion::District.find_or_create_by! code: code, name: name, city: OmniRegion::City.find_by(code: ccode)}

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'omni_region', git: "git@github.com:as181920/omni_region.git", branch: "master"
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
