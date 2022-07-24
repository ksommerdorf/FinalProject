create table thirty_rates(
    date_YYYYMM date not null,
    rates float not null
);

select z.countyname,
    p.count_open_parks
into county_park
from zip_to_county as z
inner join park_count as p
on (z.zip = p.zip_code);

select countyname, sum(count_open_parks)
into county_park_count
from county_park
group by countyname
order by countyname;

select * 
into joining_parks
from new_nc_hotness as n
left join updated_park_counts as p
on (n.county = p.county);

create table joined_parks(
    yyyymm varchar(7) not null,
    year float not null,
    county varchar(50) not null,
    median_listing_price float not null,
    active_listing_count float not null,
    median_days_on_market float not null,
    new_listing_count float not null,
    price_increased_count float not null,
    price_reduced_count float not null,
    median_sqaure_feet float not null,
    average_listing_price float not null,
    total_listing_price float not null,
    number_of_public_parks float not null,
    primary key(median_listing_price)

)