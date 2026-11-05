-- One row per card outlet per MCC code.
-- In the card list, mcc_id_list can hold several codes separated by ';', so this model splits them
-- and looks up each code's description and (where I have mapped it) the closest Snap industry.

with split_codes as (

    select
        merchant_outlet_number,
        unnest(string_split(mcc_id_list, ';')) as mcc_raw
    from {{ ref('stg_card_list') }}
    where dupe_record_rank = 1
      and mcc_id_list is not null

)

, cleaned as (

    select
        merchant_outlet_number,
        trim(mcc_raw) as mcc_id
    from split_codes
    where trim(mcc_raw) <> ''

)

select
    c.merchant_outlet_number,
    c.mcc_id,
    m.description   as mcc_description
from cleaned c
left join {{ ref('mcc_codes') }} m 
    on c.mcc_id = m.mcc_id