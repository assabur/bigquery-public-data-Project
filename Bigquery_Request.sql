-- count the name with doublon and unique
SELECT
 count (distinct name) as nom_unique,
 count (name) as nom_doublon,
--distinct name,
--year as anne,
FROM `bigquery-public-data.usa_names.usa_1910_current` LIMIT 1000 ;

--
SELECT
 name,
 year as anne,
 number
--distinct name,
--year as anne,
FROM `bigquery-public-data.usa_names.usa_1910_2013` 
WHERE name ='Elsie'
AND state = 'FL'
ORDER BY number;

--agregation functions
SELECT
    name,
    year,
    sum(number) as total_noms
from `bigquery-public-data.usa_names.usa_1910_2013` 
where name = "Elsie"
group by 1, 2
order by sum (number) DESC;

--print the number of times where the firstname marie was given in 1914

select 
   name,
    year as anne,
    state,
    sum (number) as total_noms,
from `bigquery-public-data.usa_names.usa_1910_2013` 
WHERE name = "Marie" AND year = 1914
group by 1 ,2 ,3 
order by sum (number) DESC;

--print the three years where the name was the most given
select 
    name,
    year as anne,    
    sum (number) as total_noms,
from `bigquery-public-data.usa_names.usa_1910_2013` 
WHERE name = "Marie" 
group by 1 ,2 
order by sum (number) DESC  Limit 3;

--On the all years make the sum with male and female
select  
    if (gender= 'F',"Femme","Homme") as genre,
    sum (number) as total,            
from `bigquery-public-data.usa_names.usa_1910_2013` 
where name = "Marie"
group by 1;
-- test Ifnull function

select 
ifnull (clearance_status, 'Non renseigné'),
if (clearance_status is null,"Non renseigné",clearance_status),
from `bigquery-public-data.austin_crime.crime` 
order by  clearance_date desc ;
 
--use of case function
SELECT
case
 when clearance_status = "Not cleared" then "Valeur 1"
 when clearance_status = "Cleared by Arrest" then "Valeur 2"
 when clearance_status = "Cleared by Exception" then "Valeur 2"
 Else "valeur 3"
 End as colone_modifie

from `bigquery-public-data.austin_crime.crime` ;

--use Coalesce function
select *
from `bigquery-public-data.utility_us.country_code_iso` limit 1000;

-- type of crime
select 
count (distinct description)
from `bigquery-public-data.austin_crime.crime` ;

--select all crime on 2016 year
select *
from `bigquery-public-data.austin_crime.crime` 
where year = 2016 ;
-- use if function to designed output
select 
if (clearance_status ="Not cleared" ,"non resolue","résolue") as status_crime
from `bigquery-public-data.austin_crime.crime` ;
--use case function to designed output
select 
case
    when clearance_status ="Not cleared"  then  "Non resolue"
    when clearance_status ="Cleared by Exception"  then  "resolue"   
    when clearance_status ="Cleared by Arrest"  then  "resolue"
    ELSE  "pas d'information"
End as statut_crime
from `bigquery-public-data.austin_crime.crime` ;
-- count the number of cases by crime type
select 
    description as typologie_crime,
    count (unique_key) as nombre_daffaire
 from `bigquery-public-data.austin_crime.crime` 
 group by description
 order by count (unique_key) DESC;
--number of cases treat or not
select 
case
    when clearance_status ="Not cleared"  then  "Non resolue"
    when clearance_status ="Cleared by Exception"  then  "resolue"   
    when clearance_status ="Cleared by Arrest"  then  "resolue"
    ELSE  "pas d'information"
End as Etat_avancement,
count (distinct unique_key) as nombre_daffaire,
from `bigquery-public-data.austin_crime.crime` 
where year = 2016
group by 1 ;

--all the crime before 2016
select * 
from `bigquery-public-data.austin_crime.crime`
where year >= 2016 ;

--make select use key word
select * 
from `bigquery-public-data.austin_crime.crime`
where description like '%THEFT%' AND year = 2016 ;

--use regex use pipe (|) as or, use ^33 to specify adress begin with
select 
    address,
  from `bigquery-public-data.austin_crime.crime`
  where  REGEXP_CONTAINS(address, r"BLOCK.*COURT") = false ;
-- use like function
select * 
from `bigquery-public-data.new_york.citibike_stations`
where station_id > 3500
AND is_installed != true 
AND name like 'Pacific%' ;

--use REGEXP_CONTAINS $ use to specify terminate with Ave

select * 
from `bigquery-public-data.new_york.citibike_stations`
where station_id > 3000
AND is_installed = false
AND REGEXP_CONTAINS(name,r"^Montgomery|Ave$") ;


--Make jointure with Big Query
select 
    station_info.region_id,
    bikeshare_regions.name,
    count(distinct station_id)
From `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info` as station_info
JOIN `bigquery-public-data.san_francisco_bikeshare.bikeshare_regions` as bikeshare_regions
on station_info.region_id = bikeshare_regions.region_id
group by 1,2;

