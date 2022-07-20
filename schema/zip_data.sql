-- Creating tables to load csv files: data_nona and zip_lat_data_nona
create table data_nona(
	month_date_yyyymm varchar(150) not null,
	postal_code float not null,
	city_state varchar(150) not null,
	median_listing_price float not null,
	median_listing_price_mm float not null,
	median_listing_price_yy float not null,
	active_listing_count float not null,
	active_listing_count_mm float not null,
	active_listing_count_yy float not null,
	median_days_on_market float not null,
	median_days_on_market_mm float not null,
	median_days_on_market_yy float not null,
	new_listing_count float not null,
	new_listing_count_mm float not null,
	new_listing_count_yy float not null,
	price_increased_count float not null,
	price_increased_count_mm float not null,
	price_increased_count_yy float not null,
	price_reduced_count float not null,
	price_reduced_count_mm float not null,
	price_reduced_count_yy float not null,
	pending_listing_count float not null,
	pending_listing_count_mm float not null,
	pending_listing_count_yy float not null,
	median_listing_price_per_square_foot float not null,
	median_listing_price_per_square_foot_mm float not null,
	median_listing_price_per_square_foot_yy float not null,
	median_square_feet float not null,
	median_square_feet_mm float not null,
	median_square_feet_yy float not null,
	average_listing_price float not null,
	average_listing_price_mm float not null,
	average_listing_price_yy float not null,
	total_listing_count float not null,
	total_listing_count_mm float not null,
	total_listing_count_yy float not null,
	pending_ratio float not null,
	pending_ratio_mm float not null,
	pending_ratio_yy float not null,
	quality_flag float not null,
	year_month date not null);

create table zip_nona(
	postal_code float not null,
	city varchar(150) not null,
	state_ varchar(2) not null,
	county varchar(150) not null,
	latitude float not null,
	longitude float not null,
	primary key(postal_code)
);

-- Joining tables on zip codes
select * 
into us_data
from zip_nona
left join data_nona
using (postal_code);
