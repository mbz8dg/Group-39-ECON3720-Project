/*------------------------------------------------------------------------------
							construction.do
							Group 39
							11/16/23
 -----------------------------------------------------------------------------*/
cd "/Users/tm/Desktop/UVA Materials/Semester 6 (Fall 2023)/Metrics/"

drop if missing(consumption_co2)
/*cast string responses from original data set to numeric and create descrptive 
varibale names*/
destring response6, gen(gdp_per_cap) ignore(",")
//keep varibles used for regression
keep gdp_per_cap population primary_energy_consumption consumption_co2
//create quadratic and interaction terms
gen gdp_per_cap2 = gdp_per_cap^2
gen gdp_per_cap3 = gdp_per_cap^3
gen gdp_per_cap_energy = gdp_per_cap*primary_energy_consumption
gen gdp_per_cap2_energy= gdp_per_cap2*primary_energy_consumption
gen gdp_per_cap3_energy = gdp_per_cap3*primary_energy_consumption
//save as analysis.do
save analysis,replace
