

/*------------------------------------------------------------------------------
							Processing.do
							Group 39
							10/19/23
 -----------------------------------------------------------------------------*/


//import first data set
import delimited "/Users/tm/Desktop/UVA Materials/Semester 6 (Fall 2023)/Metrics/owid-co2-data.csv", clear 
//select only 2020 data to be in line with other data set
	keep if year==2020
//drop uneccessary year variable, year= 2020 for all observations
	drop year
//save in stata readable dormat
	save owid, replace

//import second data set 	
import delimited "/Users/tm/Desktop/UVA Materials/Semester 6 (Fall 2023)/Metrics/WEO_Data.xls",clear
	save WEO,replace
//drop duplicate varibale that will cause errors in merge, keep Inflation by Index 
	drop if subjectdescriptor=="Inflation, average consumer prices"&units=="Percent change"
//drop excess observation
	drop in 2745/2745
//create numeric variable for economic indicators to prepare for merge
	encode subjectdescriptor, gen(question_num)
//drop unecessary varibles 
	drop subjectdescriptor
	drop units
	drop scale
	drop countryseriesspecificnotes
	drop estimatesstartafter
	drop v8
//rename v6 to response for clarity 
	rename v6 response
//rotate to group by country and make question_num a varibale
	reshape wide response, i(country) j(question_num) 
//merge one:one on country 
merge 1:1 country using "/Users/tm/Documents/Stata/owid.dta"
//drop extraneous (non-country) observations from second data set
	drop if _merge ==2
	save base,replace
