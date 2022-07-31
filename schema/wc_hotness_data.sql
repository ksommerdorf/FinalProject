-- Creating table to load HPI_WakeCounty into
create table hpi_wc(
	date_recorded date not null,
	wake_county_hpi float not null,
	primary key(date_recorded)
);

-- Creating table to load NCSTHPI into
create table hpi_nc(
	date_recorded date not null,
	nc_hpi float not null,
	primary key(date_recorded)
);

-- Joining the tables on recorded date
select nc.date_recorded,
	nc.nc_hpi,
	wc.wake_county_hpi
into hpi_table
from hpi_nc as nc
LEFT JOIN hpi_wc as wc
on nc.date_recorded = wc.date_recorded;

-- Creating table to load ListingViewsPerProperty into
create table listing_views(
	date_recorded date not null,
	number_of_listing_views_per_property float not null,
	primary key(date_recorded)
);

-- Creating table to load MarketHotness into
create table hotness_score(
	date_recorded date not null,
	market_hotness_score float not null,
	primary key(date_recorded)
);

-- Creating table to load MedDayonMarket into
create table medDay_market(
	date_recorded date not null,
	median_number_of_days_on_market float not null,
	primary key(date_recorded)
);

--Joining ListingViewsPerProperty, MarketHotness, and MedDayonMarket on recorded date
select h.date_recorded,
	h.market_hotness_score,
	l.number_of_listing_views_per_property,
	med.median_number_of_days_on_market
into wc_hotness
from hotness_score as h
inner join listing_views as l
on (h.date_recorded = l.date_recorded)
inner join medday_market as med
on (l.date_recorded = med.date_recorded);

--Creating table for NC_Hotness cleaned and exported in nc_data_cleaning
create table nc_hotness(
	date_recorded date not null,
	county varchar(100) not null,
	county_fips float not null,
	median_listing_price float not null,
	active_listing_count float not null,
	median_days_on_market float not null,
	new_listing_count float not null,
	price_increased_count float not null,
	price_reduced_count float not null,
	median_sq_ft float not null,
	average_listing_price float not null,
	total_listing_count float not null
);