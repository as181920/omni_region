# OmniRegion
通用区划信息(Rails engine)

## Usage
source data: https://github.com/modood/Administrative-divisions-of-China

Load data:
require 'csv' 
data_file_path = "/home/andersen/public_projects/Administrative-divisions-of-China/dist" 
country = OmniRegion::Country.find_or_create_by code: 156, name: '中国'

x=CSV.read "#{data_file_path}/provinces.csv" 
x[1..-1].each{|code,name| country.provinces.create code: code, name: name}

x=CSV.read "#{data_file_path}/cities.csv" 
x[1..-1].each{|code,name, pcode| OmniRegion::City.find_or_create_by! code: code, name: name, province: OmniRegion::Province.find_by(code: pcode)}

x=CSV.read "#{data_file_path}/areas.csv" 
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
