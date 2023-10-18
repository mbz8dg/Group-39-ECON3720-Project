	import delimited "/Users/tm/Desktop/UVA Materials/Semester 6 (Fall 2023)/Metrics/owid-co2-data.csv", clear
	keep if year==2020
	drop year
	save owid-co2-data.csv, replace
	
	import delimited "/Users/tm/Desktop/UVA Materials/Semester 6 (Fall 2023)/Metrics/WEO_Data.xls",clear
	drop if subjectdescriptor=="Inflation, average consumer prices"&units=="Percent change"
	drop in 2745/2745
	encode subjectdescriptor, gen(question_num)
	drop subjectdescriptor
	drop units
	drop scale
	drop countryseriesspecificnotes
	drop estimatesstartafter
	drop v8
	rename v6 response
	reshape wide response, i(country) j(question_num) 
	
	merge 1:1 country using "/Users/tm/Documents/Stata/owid-co2-data.csv"
	drop if _merge ==2
	save country_data,replace
