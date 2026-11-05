# Assumptions

## Duplicates

In 01_data_quality.ipynb you can see each dataset has a duplicate problem. I would prefer to do more research on best way to select the best record for duplicates, but for now going on some quick way to rank based of assuming I understand the data correctly.

Each data source, I set up a staging table to clean up some fields, provide clean and normalized company name & address, and calculate a duplicate record rank (`dupe_record_rank`). 

This rank field allows me to quickly filter to `dupe_record_rank=1` to remove the more obvious duplicates. 

Each one is partitioned the same:
``` sql
    partition by 
        company_name_clean,
        street_address_clean,
        city_clean,
        state_clean,
        zip_code
```
How the sort happened varied per dataset, which can be seen below:

### card_list
``` sql
    rank() over (
        partition by 
            lower(trim(dba_name)),
            lower(trim(addr1)),
            lower(trim(city)),
            lower(trim(state)),
            zip_code
        order by 
            merchant_outlet_number desc
    )
```
This one I'm making the assumption that `merchant_outlet_number` is added in numerical order (larger the id value, it's more recent addition) and you want the more recent one.

### purchased_list
``` sql
    rank() over (
        partition by 
            lower(trim("name")),
            lower(trim(street)),
            lower(trim(city)),
            lower(trim(state)),
            postal_code
        order by 
            speedeonid desc
    )
```
This one I'm making the assumption that `speedeonid` is added in numerical order (larger the id value, it's more recent addition) and you want the more recent one.

### salesforce_list
``` sql
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
    )
```
For this one, I figured that you wouldn't want to look at Disqualified accounts, prefer ones that have an opportunity value, complete address, meta data is there, and finally use the id like above.


### snap
``` sql
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
    )
```
I ranked the active accounts higher then use the id field like others above.

### website_list
``` sql
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
    )
```
This dataset does not have an unique id. So if going to production, would definitely work on creating unique rows and an ID, but for now some ranking. The ranking looked for complete address, industry data is field, more specific industry value, the lead id, and then industry subcategory has a value. 

## Joining datasets

Since shared ID between the datasets, I am using slightly cleaner versions of business is name + street + 5-digit ZIP. Then exact matching only, so this is probably the smallest amount of connections that will happen (floor). 

I would prefer to clean the address better and possibly work with fuzzy name matching, but given time restraints starting with the cleanest matches.
