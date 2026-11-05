select
    merchant_outlet_number,
    dba_name as company_name_raw,
    lower(trim(dba_name)) as company_name_clean,
    addr1 as street_address_raw,
    lower(trim(addr1)) as street_address_clean,
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
    CASE
        WHEN REGEXP_MATCHES(TRIM(zip_code), '^[0-9]{5}-[0-9]{4}$')
            THEN TRIM(zip_code)
        WHEN REGEXP_MATCHES(TRIM(zip_code), '^[0-9]{9}$')
            THEN LEFT(TRIM(zip_code), 5) || '-' || RIGHT(TRIM(zip_code), 4)
        ELSE NULL
    END AS zip_code_plus_4,
    mcc_id as mcc_id_list,
    last_activity_period,
    rank() over (
        partition by 
            lower(trim(dba_name)),
            lower(trim(addr1)),
            lower(trim(city)),
            lower(trim(state)),
            zip_code
        order by 
            merchant_outlet_number desc
    ) as dupe_record_rank,
    _loaded_at as loaded_at
from {{ source('raw', 'card_list') }}