select
    mid,
    dba_name as company_name_raw,
    lower(trim(dba_name)) as company_name_clean,
    merchant_address as street_address_raw,
    lower(trim(merchant_address)) as street_address_clean,
    merchant_city as city_raw,
    lower(trim(merchant_city)) as city_clean,
    merchant_state as state_raw,
    lower(trim(merchant_state)) as state_clean,
    merchant_zip_code as zip_code_raw,
    CASE
        WHEN REGEXP_MATCHES(TRIM(merchant_zip_code), '^[0-9]{5}(-[0-9]{4}|[0-9]{4})?$')
            THEN LEFT(TRIM(merchant_zip_code), 5)
        ELSE NULL
    END AS zip_code_5_digit, 
    is_inactivated::boolean as is_inactivated,
    industry,
    product_type,
    apps_ytd::int as apps_ytd,
    aprv_ytd::int as aprv_ytd,
    cmpl_ytd::int as cmpl_ytd,
    fund_ytd::numeric as fund_ytd,
    rank() over (
        partition by 
            lower(trim(dba_name)),
            lower(trim(merchant_address)),
            lower(trim(merchant_city)),
            lower(trim(merchant_state)),
            merchant_zip_code
        order by 
            is_inactivated, 
            mid::int desc
    ) as dupe_record_rank,
    _loaded_at as loaded_at
from {{ source('raw', 'snap') }}