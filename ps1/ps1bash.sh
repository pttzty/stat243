##Problem1
##Part A
##Download the compressed data file to the local directory
wget --output-document data.zip "http://data.un.org/Handlers/DownloadHandler.ashx?DataFilter=itemCode:526&DataMartId=FAO&Format=csv&c=2,3,4,5,6,7&s=countryName:asc,elementCode:asc,year:desc"
##uncompress the file 
unzip data.zip
git mv -k UNdata_Export_20150902_062742765.csv data.csv
##Countries into one file, world to the other.
grep "+" data.csv > regions.csv
grep -v "+" data.csv > countries.csv

##Aviod the comma in the countries names for the convience of splits of different columns in future
sed "s/, /-/g" countries.csv > countries_aprictos.csv

## Find five most land-used countries in 2005
grep -i "Area" countries_aprictos.csv | grep "\"2005\"" | sed 's/"//g' | sort -t',' -k6 -n | tail -5

## Automate the analysis for other years, the default interval of years is 10.
function automate(){
for ((i=1965;i<=2015;i=i+10))
do
    grep -i "Area" countries_aprictos.csv | grep "\"$i\"" | sed 's/"//g' | sort -t',' -k6 -n | tail -5
done
}
automate

##Part B, and x should be the input code
function httpcode(){
	echo -n "what is your code for the Agriculture Product?" 
	read x
	wget --output-document data$x.zip "http://data.un.org/Handlers/DownloadHandler.ashx?DataFilter=itemCode:$x&DataMartId=FAO&Format=csv&c=2,3,4,5,6,7&s=countryName:asc,elementCode:asc,year:desc" | unzip 
	unzip -c data$x.zip | less 
}
##Call the function
httpcode

##Part C Input the product name instead of inputing the product code.
#Download the html file
wget --output-document codename.html "http://faostat.fao.org/site/384/default.aspx"
#

##Problem2
#First to download the html file, and find all txt file names from that html file.
wget --output-document climate.html "http://www1.ncdc.noaa.gov/pub/data/ghcn/daily/" 

