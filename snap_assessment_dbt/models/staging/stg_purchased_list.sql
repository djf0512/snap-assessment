select
    speedeonid,
    "name" as company_name_raw,
    lower(trim("name")) as company_name_clean,
    alternative_name as alternative_name_raw,
    lower(trim(alternative_name)) as alternative_name_clean, 	
    street as street_address_raw,
    lower(trim(street)) as street_address_clean,
    city as city_raw,
    lower(trim(city)) as city_clean,
    state as state_raw,
    lower(trim(state)) as state_clean,
    postal_code as zip_code_raw,
    CASE
        WHEN REGEXP_MATCHES(TRIM(postal_code), '^[0-9]{5}(-[0-9]{4}|[0-9]{4})?$')
            THEN LEFT(TRIM(postal_code), 5)
        ELSE NULL
    END AS zip_code_5_digit,  
    CASE
        WHEN REGEXP_MATCHES(TRIM(postal_code), '^[0-9]{5}-[0-9]{4}$')
            THEN TRIM(postal_code)
        WHEN REGEXP_MATCHES(TRIM(postal_code), '^[0-9]{9}$')
            THEN LEFT(TRIM(postal_code), 5) || '-' || RIGHT(TRIM(postal_code), 4)
        ELSE NULL
    END AS zip_code_plus_4,
    primary_sic_code_id,
    labels_primary_sic_code_id,
    TRY_CAST(TRIM(location_employee_count) AS INTEGER) as location_employee_count,
    labels_square_footage,
    rank() over (
        partition by 
            lower(trim("name")),
            lower(trim(street)),
            lower(trim(city)),
            lower(trim(state)),
            postal_code
        order by 
            speedeonid desc
    ) as dupe_record_rank,
    _loaded_at as loaded_at
from {{ source('raw', 'purchased_list') }}