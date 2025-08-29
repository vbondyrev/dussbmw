CREATE EXTENSION postgis;


-- ONLY Dusseldorp
SELECT case when p.company_name like 'Dusseldorp%' then 'DussBMW'
	when p.company_name like 'Ekris%' then 'Ekris'
	when p.company_name like 'De Maassche%' then 'De Maassche'
	when p.company_name like 'Hedin Automotive%' then 'Hedin Automotive'
	when p.company_name like 'De Maassche%' then 'De Maassche'
	when p.company_name like 'Van Poelgeest%' then 'Van Poelgeest'	
	when p.company_name like 'Story%' then 'Story'	
	when p.company_name like 'Oostland%' then 'Oostland' else 	p.company_name end as company_name,
case when p.company_name like 'Dusseldorp%' then ''
	when p.company_name like 'Ekris%' then 'High'
	when p.company_name like 'Van Poelgeest%' then 'High'
	when p.company_name like 'Hedin Automotive%' then 'High'
else 'Low' end as affects,	
	count(*) FROM public.parsed_dealers AS p
group by 1,2
order by count(*) desc;

-- ONLY Dusseldorp
SELECT company_name, address, city,
(regexp_matches(address, '(\d+[\w-]*)$'))[1] AS extracted_number,
    SPLIT_PART(city, ' ', 1) || SPLIT_PART(city, ' ', 2) AS extracted_postcode
FROM public.parsed_dealers AS p
where p.company_name like 'Dusseldorp%';


-- Matrix table  All DussNMW with All other
with duss as 
	(SELECT company_name, address, city,
	LOWER((regexp_matches(address, '(\d+[\w-]*)$'))[1]) AS extracted_number,
	    SPLIT_PART(city, ' ', 1) || SPLIT_PART(city, ' ', 2) AS extracted_postcode
	FROM public.parsed_dealers AS p
	 where p.company_name like 'Dusseldorp%'
	),
all_deal as 
	(SELECT company_name, address, city,
	SPLIT_PART(LOWER((regexp_matches(address, '(\d+[\w-]*)$'))[1]), '-', 1) AS extracted_number,
	    SPLIT_PART(city, ' ', 1) || SPLIT_PART(city, ' ', 2) AS extracted_postcode
	FROM public.parsed_dealers AS p
	),
all_geo as
	(select *
	from public.pcodes AS p 
		where exists 
			(select * from all_deal where p.postcode=extracted_postcode and extracted_number=concat(p.huisnummer,p.huisletter))
	),
matrix as 
	(select d.company_name as dussbmw_name, d.extracted_number as dussbmw_number, d.extracted_postcode as dussbmw_postcode,
		a.company_name as forign_name, a.extracted_number as forign_number, a.extracted_postcode as forign_postcode
	from duss d 
		cross join all_deal a --ON d.extracted_postcode = a.extracted_postcode;
	where  a.company_name not like 'Dusseldorp%'
	order by d.company_name, a.company_name
	)
select m.*,
p1.id as dussbmw_id, p1.lon as dussbmw_lon, p1.lat as dussbmw_lat,
p2.id as forign_id, p2.lon as forign_lon, p2.lat as forign_lat,
 ST_Distance(
    ST_MakePoint(p1.lon, p1.lat)::geography,
    ST_MakePoint(p2.lon, p2.lat)::geography
  ) / 1000 AS distance_in_km,
case when m.forign_name like 'Dusseldorp%' then 'DussBMW'
	when m.forign_name like 'Ekris%' then 'Ekris'
	when m.forign_name like 'De Maassche%' then 'De Maassche'
	when m.forign_name like 'Hedin Automotive%' then 'Hedin Automotive'
	when m.forign_name like 'De Maassche%' then 'De Maassche'
	when m.forign_name like 'Van Poelgeest%' then 'Van Poelgeest'	
	when m.forign_name like 'Story%' then 'Story'	
	when m.forign_name like 'Oostland%' then 'Oostland' else m.forign_name end as company_name,
case when m.forign_name like 'Dusseldorp%' then ''
	when m.forign_name like 'Ekris%' then 'High'
	when m.forign_name like 'Van Poelgeest%' then 'High'
	when m.forign_name like 'Hedin Automotive%' then 'High'
else 'Low' end as affects
from matrix m
	left join all_geo p1 on m.dussbmw_postcode=p1.postcode and m.dussbmw_number=concat(p1.huisnummer,p1.huisletter)
	left join all_geo p2 on m.forign_postcode=p2.postcode and m.forign_number=concat(p2.huisnummer,p2.huisletter);	
	
