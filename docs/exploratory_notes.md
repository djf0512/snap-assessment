# Exploring the Data
First thing I like to do is actually look at the data, begin with simple queries to get a feel of what the data, any questions that arise, or any problems I can see right away. Usually, after getting a list of problems, I try to figure out how big of a problem. This could % of the data, and/or having to talk with business as how they view the problem.

Technically with this project, I had to first work on a space to load the data first, but after that begin exploring.

## questions / to dos
- on salesforce_list, status = converted
    - does that already mean in snap list? active? so no longer need to persue? 
        - if so, can look to see top industries
- compare of the industry fields across the different lists

## data quality

### card_list
- zip code looks like it's Contains 5-digit and ZIP+4 formats without hypen


### purchased_list
- cleanest addresses yet
- some business names with same address, but that could just be a building right?
- same business name, diff address, and diff sic code id
    - example: lower("name")='bosch auto service', `speedeonid in ('835919433','181103430')`


### salesforce_list
- duplicate problem
    - id example
        - `99QUR99999CBbJu7AL` and `99QUR99999CBbJv7AL` have the same name, address, but one has more meta data filled out over the other


### snap
- street_address seems to have problem like website_list, but not as often


### website_list
- street_address
    - sometimes has the whole address and appears when it does the state in the address doesn't match the one in the state field
        - example:
        ```
        business_name   street_address  city    state   zip_code
        Mynors Auto Repair	8835 e baseline st	San Bernardino	VA	07589
        J & J Car Care	3982 Harford Rd, Baltimore MD 78785	Baltimore	NM	78785
        ADVANCE MUFFLER AND AUTO REPAIR	1154 W 1 Mile Rd, Detroit MI 51778	Detroit	NH	51778
        Power Lube Express Auto Care	104 S Broadway St, Blackfoot ID 16778	Blackfoot	RI	16778
        PURRFECT AUTO SERVICE 99	1496 Whittier Blvd Ste B8, Pico Rivera CA 09339	Pico Rivera	VA	09339
        ```
    - also noticed the zip code doesn't match either state in most cases, but need to remeber: 
    >The addresses in all of these datasets are synthetic addresses, but they are consistent between files for matching
- name duplicates
    - lead_id
        - `424072f4-bf29-5036-0ccd-7f1c72ee9e87` and `906e6113-0dc7-5373-a3f8-52cb60a87a22` both have name: Home Town  Automotive Services LLC
            - and similar address but diff zip codes


## ideas for criteria of higher priority merchants
- card_list, the last_activity_period helps look at merchants with recent activity
- salesforce_list, status 
    - remove disqualified ones
