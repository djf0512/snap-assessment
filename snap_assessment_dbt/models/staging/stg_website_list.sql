select
    form_name,
    lead_id,
    business_name as company_name_raw,
    lower(trim(business_name)) as company_name_clean,
    street_address as street_address_raw,
    lower(trim(street_address)) as street_address_clean,
    city as city_raw,
    lower(trim(city)) as city_clean,
    state as state_raw,
    lower(trim(state)) as state_clean,
    zip_code as zip_code_raw,
    CASE
        WHEN REGEXP_MATCHES(TRIM(zip_code), '^[0-9]{5}(-[0-9]{4}|[0-9]{4})?$')
            THEN LEFT(TRIM(zip_code), 5)
        ELSE NULL
    END AS zip_code_5_digit,  
    industry_name,
    industry_desc,
    industry_subcategory,
    industry_subcategory_desc,
    rank() over (
        partition by 
            lower(trim(business_name)),
            lower(trim(street_address)),
            lower(trim(city)), 
            lower(trim(state)),
            zip_code
        order by 
            street_address_raw is not null desc, 
            industry_name is not null desc, 
            industry_subcategory!='OTHER' desc, 
            lead_id desc, 
            industry_subcategory
    ) as dupe_record_rank,
    _loaded_at as loaded_at
from {{ source('raw', 'website_list') }}