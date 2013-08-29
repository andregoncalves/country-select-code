# = CountrySelectCode
#
# View helper for displaying select list with countries and country codes:
#
module ActionView
  module Helpers
    module FormOptionsHelper
      # Return select and option tags for the given object and method, using country_options_for_select to generate the list of option tags.
      def country_select_code(object, method, priority_countries = nil, options = {}, html_options = {})

        if defined?(ActionView::Helpers::InstanceTag) && ActionView::Helpers::InstanceTag.instance_method(:initialize).arity != 0
          tag = InstanceTag.new(object, method, self, options.delete(:object))
        else
          tag = CountrySelectCode.new(object, method, self, options)
        end

         tag.to_country_select_code_tag(priority_countries, options, html_options)
      end

      # Returns a string of option tags for pretty much any country in the world. Supply a country name as +selected+ to
      # have it marked as the selected option tag. You can also supply an array of countries as +priority_countries+, so
      # that they will be listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
      def country_options_for_select(selected = nil, priority_countries = nil, options = nil)
        country_options = ""

        countries = options[:with_country_code].nil? ? COUNTRIES : COUNTRIES_WITH_CODE

        if priority_countries
          if (unlisted = priority_countries - countries).any?
            raise RuntimeError.new("Supplied priority countries are not in the main list: #{unlisted}")
          end
          country_options += options_for_select(priority_countries, selected)
          country_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"

          # prevents selected from being included twice in the HTML which causes
          # some browsers to select the second selected option (not priority)
          # which makes it harder to select an alternative priority country
          selected = nil if priority_countries.include?(selected)
        end

        country_options = country_options.html_safe if country_options.respond_to?(:html_safe)

        return country_options + options_for_select(countries, selected)
      end

      # All the countries included in the country_options output.
      COUNTRIES = ["Afghanistan", "Aland Islands", "Albania", "Algeria", "American Samoa", "Andorra", "Angola",
        "Anguilla", "Antarctica", "Antigua And Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria",
        "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin",
        "Bermuda", "Bhutan", "Bolivia, Plurinational State of", "Bonaire, Sint Eustatius and Saba", "Bosnia and Herzegovina",
				"Botswana", "Bouvet Island", "Brazil",
        "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia",
        "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China",
        "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo",
        "Congo, the Democratic Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba",
        "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt",
        "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)",
        "Faroe Islands", "Fiji", "Finland", "France", "French Guiana", "French Polynesia",
        "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece",
				"Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea",
        "Guinea-Bissau", "Guyana", "Haiti", "Heard Island and McDonald Islands", "Holy See (Vatican City State)",
        "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran, Islamic Republic of", "Iraq",
        "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya",
        "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan",
        "Lao People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya",
        "Liechtenstein", "Lithuania", "Luxembourg", "Macao", "Macedonia, The Former Yugoslav Republic Of",
        "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique",
        "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of",
        "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru",
        "Nepal", "Netherlands", "New Caledonia", "New Zealand", "Nicaragua", "Niger",
        "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau",
        "Palestinian Territory, Occupied", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines",
        "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation",
        "Rwanda", "Saint Barthelemy", "Saint Helena, Ascension and Tristan da Cunha", "Saint Kitts and Nevis", "Saint Lucia",
        "Saint Martin (French Part)", "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Samoa", "San Marino",
        "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore",
        "Sint Maarten (Dutch Part)", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa",
        "South Georgia and the South Sandwich Islands", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname",
        "Svalbard and Jan Mayen", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic",
        "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Timor-Leste",
        "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan",
        "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom",
        "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu",
				"Venezuela, Bolivarian Republic of", "Viet Nam", "Virgin Islands, British", "Virgin Islands, U.S.",
				"Wallis and Futuna", "Western Sahara", "Yemen", "Zambia", "Zimbabwe"] unless const_defined?("COUNTRIES")

      # All the countries included in the country_options output with the code.
    	COUNTRIES_WITH_CODE =  [["Afghanistan", "AF"], ["Albania", "AL"], ["Algeria", "DZ"], ["American Samoa", "AS"], ["Andorra", "AD"], ["Angola", "AO"],
    		["Anguilla", "AI"], ["Antarctica", "AQ"], ["Antigua and Barbuda", "AG"], ["Argentina", "AR"], ["Armenia", "AM"], ["Aruba", "AW"],
    		["Australia", "AU"], ["Austria", "AT"], ["Azerbaidjan", "AZ"], ["Bahamas", "BS"], ["Bahrain", "BH"], ["Bangladesh", "BD"], ["Barbados", "BB"],
    		["Belarus", "BY"], ["Belgium", "BE"], ["Belize", "BZ"], ["Benin", "BJ"], ["Bermuda", "BM"], ["Bolivia", "BO"], ["Bosnia-Herzegovina", "BA"],
    		["Botswana", "BW"], ["Bouvet Island", "BV"], ["Brazil", "BR"], ["British Indian O. Terr.", "IO"], ["Brunei Darussalam", "BN"], ["Bulgaria", "BG"],
    		["Burkina Faso", "BF"], ["Burundi", "BI"], ["Buthan", "BT"], ["Cambodia", "KH"], ["Cameroon", "CM"], ["Canada", "CA"], ["Cape Verde", "CV"],
    		["Cayman Islands", "KY"], ["Central African Rep.", "CF"], ["Chad", "TD"], ["Chile", "CL"], ["China", "CN"], ["Christmas Island", "CX"],
    		["Cocos (Keeling) Isl.", "CC"], ["Colombia", "CO"], ["Comoros", "KM"], ["Congo", "CG"], ["Cook Islands", "CK"], ["Costa Rica", "CR"],
    		["Croatia", "HR"], ["Cuba", "CU"], ["Cyprus", "CY"], ["Czech Republic", "CZ"], ["Czechoslovakia", "CS"], ["Denmark", "DK"], ["Djibouti", "DJ"],
    		["Dominica", "DM"], ["Dominican Republic", "DO"], ["East Timor", "TP"], ["Ecuador", "EC"], ["Egypt", "EG"], ["El Salvador", "SV"],
    		["Equatorial Guinea", "GQ"], ["Estonia", "EE"], ["Ethiopia", "ET"], ["Falkland Isl.(UK)", "FK"], ["Faroe Islands", "FO"], ["Fiji", "FJ"],
    		["Finland", "FI"], ["France", "FR"], ["France (European Ter.)", "FX"], ["French Southern Terr.", "TF"], ["Gabon", "GA"], ["Gambia", "GM"],
    		["Georgia", "GE"], ["Germany", "DE"], ["Ghana", "GH"], ["Gibraltar", "GI"], ["Great Britain (UK)", "GB"], ["Greece", "GR"], ["Greenland", "GL"],
    		["Grenada", "GD"], ["Guadeloupe (Fr.)", "GP"], ["Guam (US)", "GU"], ["Guatemala", "GT"], ["Guinea", "GN"], ["Guinea Bissau", "GW"],
    		["Guyana", "GY"], ["Guyana (Fr.)", "GF"], ["Haiti", "HT"], ["Heard & McDonald Isl.", "HM"], ["Honduras", "HN"], ["Hong Kong", "HK"],
    		["Hungary", "HU"], ["Iceland", "IS"], ["India", "IN"], ["Indonesia", "ID"], ["Iran", "IR"], ["Iraq", "IQ"], ["Ireland", "IE"], ["Israel", "IL"],
    		["Italy", "IT"], ["Ivory Coast", "CI"], ["Jamaica", "JM"], ["Japan", "JP"], ["Jordan", "JO"], ["Kazachstan", "KZ"], ["Kenya", "KE"],
    		["Kirgistan", "KG"], ["Kiribati", "KI"], ["Korea (North)", "KP"], ["Korea (South)", "KR"], ["Kuwait", "KW"], ["Laos", "LA"], ["Latvia", "LV"],
    		["Lebanon", "LB"], ["Lesotho", "LS"], ["Liberia", "LR"], ["Libya", "LY"], ["Liechtenstein", "LI"], ["Lithuania", "LT"], ["Luxembourg", "LU"],
    		["Macau", "MO"], ["Madagascar", "MG"], ["Malawi", "MW"], ["Malaysia", "MY"], ["Maldives", "MV"], ["Mali", "ML"], ["Malta", "MT"],
    		["Marshall Islands", "MH"], ["Martinique (Fr.)", "MQ"], ["Mauritania", "MR"], ["Mauritius", "MU"], ["Mexico", "MX"], ["Micronesia", "FM"],
    		["Moldavia", "MD"], ["Monaco", "MC"], ["Mongolia", "MN"], ["Montserrat", "MS"], ["Morocco", "MA"], ["Mozambique", "MZ"], ["Myanmar", "MM"],
    		["Namibia", "NA"], ["Nauru", "NR"], ["Nepal", "NP"], ["Netherland Antilles", "AN"], ["Netherlands", "NL"], ["Neutral Zone", "NT"],
    		["New Caledonia (Fr.)", "NC"], ["New Zealand", "NZ"], ["Nicaragua", "NI"], ["Niger", "NE"], ["Nigeria", "NG"], ["Niue", "NU"],
    		["Norfolk Island", "NF"], ["Northern Mariana Isl.", "MP"], ["Norway", "NO"], ["Oman", "OM"], ["Pakistan", "PK"], ["Palau", "PW"],
    		["Panama", "PA"], ["Papua New", "PG"], ["Paraguay", "PY"], ["Peru", "PE"], ["Philippines", "PH"], ["Pitcairn", "PN"], ["Poland", "PL"],
    		["Polynesia (Fr.)", "PF"], ["Portugal", "PT"], ["Puerto Rico (US)", "PR"], ["Qatar", "QA"], ["Reunion (Fr.)", "RE"], ["Romania", "RO"],
    		["Russian Federation", "RU"], ["Rwanda", "RW"], ["Saint Lucia", "LC"], ["Samoa", "WS"], ["San Marino", "SM"], ["Saudi Arabia", "SA"],
    		["Senegal", "SN"], ["Seychelles", "SC"], ["Sierra Leone", "SL"], ["Singapore", "SG"], ["Slovak Republic", "SK"], ["Slovenia", "SI"],
    		["Solomon Islands", "SB"], ["Somalia", "SO"], ["South Africa", "ZA"], ["Spain", "ES"], ["Sri Lanka", "LK"],
    		["St. Helena", "SH"], ["St. Pierre & Miquelon", "PM"], ["St. Tome and Principe", "ST"], ["St.Kitts Nevis Anguilla", "KN"],
    		["St.Vincent & Grenadines", "VC"], ["Sudan", "SD"], ["Suriname", "SR"], ["Svalbard & Jan Mayen Is", "SJ"], ["Swaziland", "SZ"], ["Sweden", "SE"],
    		["Switzerland", "CH"], ["Syria", "SY"], ["Tadjikistan", "TJ"], ["Taiwan", "TW"], ["Tanzania", "TZ"], ["Thailand", "TH"], ["Togo", "TG"],
    		["Tokelau", "TK"], ["Tonga", "TO"], ["Trinidad & Tobago", "TT"], ["Tunisia", "TN"], ["Turkey", "TR"], ["Turkmenistan", "TM"],
    		["Turks & Caicos Islands", "TC"], ["Tuvalu", "TV"], ["Uganda", "UG"], ["Ukraine", "UA"], ["United Arab Emirates", "AE"], ["United Kingdom", "GB"],
    		["United States", "US"], ["Uruguay", "UY"], ["US Minor outlying Isl.", "UM"], ["Uzbekistan", "UZ"], ["Vanuatu", "VU"], ["Vatican City State", "VA"],
    		["Venezuela", "VE"], ["Vietnam", "VN"], ["Virgin Islands (British)", "VG"], ["Virgin Islands (US)", "VI"], ["Wallis & Futuna Islands", "WF"],
    		["Western Sahara", "EH"], ["Yemen", "YE"], ["Yugoslavia", "YU"], ["Zaire", "ZR"], ["Zambia", "ZM"], ["Zimbabwe", "ZW"]] unless const_defined?("COUNTRIES_WITH_CODE")

    end


    module ToCountrySelectCodeTag
      def to_country_select_code_tag(priority_countries, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            country_options_for_select(value, priority_countries, options),
            options, value
          ), html_options
        )
      end
    end

    # Rails 4 compatibility code
    if defined?(ActionView::Helpers::InstanceTag) && ActionView::Helpers::InstanceTag.instance_method(:initialize).arity != 0
      class InstanceTag
        include ToCountrySelectCodeTag
      end
    else
      class CountrySelectCode < Tags::Base
        include ToCountrySelectCodeTag
      end
    end


    class FormBuilder
      def country_select_code(method, priority_countries = nil, options = {}, html_options = {})
        @template.country_select_code(@object_name, method, priority_countries, options.merge(:object => @object), html_options)
      end
    end
  end
end
