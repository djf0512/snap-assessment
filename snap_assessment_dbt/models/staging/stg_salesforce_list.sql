select
    id,
    company as company_name_raw,
    lower(trim(company)) as company_name_clean,
    street as street_address_raw,
    lower(trim(street)) as street_address_clean,
    city as city_raw,
    lower(trim(city)) as city_clean,
    state as state_raw,
    lower(trim(state)) as state_clean,
    zip5__c as zip_code_raw,
    CASE
        WHEN REGEXP_MATCHES(TRIM(zip5__c), '^[0-9]{5}(-[0-9]{4}|[0-9]{4})?$')
            THEN LEFT(TRIM(zip5__c), 5)
        ELSE NULL
    END AS zip_code_5_digit, 
    industry_vertical__c,
    total_snap_opportunity_tso__c::float as total_snap_opportunity_tso__c,
    status,
    disqualified_reason__c,
    age_of_lead__c::int as age_of_lead__c,
    competitor_1_pll__c,
    rank() over (
        partition by 
            lower(trim(company)),
            lower(trim(street)),
            lower(trim(city)),
            lower(trim(state)),
            zip5__c
        order by 
            status!='Disqualified' desc, 
            total_snap_opportunity_tso__c is not null desc, 
            zip_code_raw is not null desc, 
            industry_vertical__c is not null desc, 
            id desc
    ) as dupe_record_rank,
    _loaded_at as loaded_at
from {{ source('raw', 'salesforce_list') }}