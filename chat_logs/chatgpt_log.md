snap tech assessment

 Instructions provided:
Setup / Purpose
Sales has acquired five business datasets that may help identify new merchant acquisition opportunities. The datasets vary in quality, coverage, and business relevance. Leadership believes there may be value in the data but has not determined how it should be operationalized.

You have been asked to evaluate the datasets and recommend how they should be incorporated into the merchant acquisition strategy.

Examples of questions to answer could include, but are not limited to:
- What is the quality of the data?
- Which datasets provide the greatest business value?
- How should Sales operationalize the information?
  - I.E. which businesses should sales prioritize
- What risks or limitations should be considered before deployment?
- How success should be measured if the recommendation is implemented?
We encourage you to be creative in how you approach this problem. Our goal is not necessarily to see a fully completed analysis, but rather to understand how you think through ambiguous business challenges and turn data into actionable recommendations.

Use the data to uncover any insights you find meaningful and develop a recommendation for how Sales could leverage the information. We are equally interested in your analytical process as we are in your conclusions.

Given the time constraints, we do not expect every avenue of analysis to be explored. Instead, focus on identifying the most impactful opportunities, clearly communicating your assumptions, and outlining how you would continue the investigation if given additional time and resources.

You are welcome to use any tool at your disposal including AI to address this, and we expect to get a copy of the chat log for any AI assistance that was used.

i have started on my local machine a folder for this project. organized:

## Layout

```

analysis/           Jupyter notebooks analyzing data

chat_logs/          requested export of AI conversations

data/raw/           Snap Excel file (git-ignored)

docs/               notes

ingestion/          python loader to raw layer

warehouse/          local database (git-ignored)

```

that is from the README.txt. i have also a requirement.txt. 

i have loaded the data into a duckdb, using the taskmaster repo as an example. i'm not going to do the dbt part right now as that doesn't seem important for presentation in the time limit.















This is a good starting point. I actually agree with your decision to skip dbt for this assessment. You have limited time, and the objective is to demonstrate your ability to take ambiguous business data, investigate it, identify opportunities, and translate findings into a recommendation. A dbt project would add engineering overhead without necessarily improving the quality of the deliverable.

I'd approach this as a small analytics engineering + business intelligence project, with the emphasis on actionable business recommendations.
1. Project structure
Your existing structure is sensible. I'd keep it largely as-is:
snap-assessment/
│
├── analysis/
│   ├── 01_data_exploration.ipynb
│   ├── 02_data_quality.ipynb
│   └── 03_opportunity_analysis.ipynb
│
├── chat_logs/
│
├── data/
│   └── raw/
│
├── docs/
│   ├── findings.md
│   └── methodology.md
│
├── ingestion/
│   └── load_data.py
│
├── warehouse/
│
├── README.md
└── requirements.txt


You don't necessarily need three notebooks. Depending on the size and complexity of the datasets, I'd probably consolidate this into two:
- Exploration and data quality: Understand the five datasets, their structure, coverage, completeness, and reliability.
- Business analysis: Identify merchant acquisition opportunities, prioritize businesses, and develop recommendations.
Keep the final presentation separate from the exploratory work.
2. How I'd approach the actual assessment
I would organize the analysis around five questions.
01
What data do we actually have?

Understand the five sources, their purpose, granularity, coverage, and potential overlap.

02
Can we trust the data?

Assess completeness, duplicates, validity, consistency, freshness, and potential matching issues.

03
Which data has business value?

Look for signals that suggest a business is a promising merchant acquisition prospect. Consider what each dataset contributes individually and collectively.

04
What should Sales do with it?

Develop a prioritization strategy, potentially including tiers, qualification criteria, and a recommended sales workflow.

05
How do we know it works?

Define measurable outcomes, establish a baseline, and propose a pilot to validate the opportunity.

One thing I'd emphasize: data quality and business value aren't necessarily the same thing.

A dataset might have excellent coverage and completeness but provide very little useful information for merchant acquisition. Another might have limited coverage but contain a particularly valuable signal for identifying businesses likely to become customers.

That distinction could make for a particularly good discussion in your assessment.
3. Technical approach
Since you've already loaded everything into DuckDB, I'd continue with that.

I would build a few logical layers using SQL views or tables rather than introducing dbt:
Layer	Purpose
Raw	Original data as received
Staging	Standardized columns, types, and formats
Analysis	Joined datasets, calculated attributes, quality metrics
Reporting	Prioritized prospects and summary metrics

This demonstrates that you understand data architecture and reproducibility without overengineering the solution.

I'd also make sure you can explain:
- How you ingested the original Excel workbook.
- How you handled different source structures.
- How you matched businesses across datasets.
- How you identified and handled duplicate records.
- How you derived any prioritization metrics.
4. What I want to do next
Before we start writing SQL or deciding what metrics to calculate, I'd like to see the actual data.

Next step
 Upload the original Excel workbook.
Upload a file

I'd like to inspect:
1. The five datasets and their individual schemas.
2. Row counts and general coverage.
3. What fields overlap between datasets.
4. What information might indicate merchant acquisition potential.
5. Any obvious data quality problems.
Then we can develop an analysis plan based on what the data actually contains, rather than deciding upfront what we think should be interesting.
5. One strategic consideration
Remember what Snap is evaluating here. This is for a Lead BI Analytics Engineer position, not simply a data analyst position.

I want the finished work to demonstrate three things:
- Technical execution: You can ingest, structure, query, and validate disparate datasets.
- Analytical judgment: You can distinguish meaningful signals from noise and recognize limitations.
- Business communication: You can turn the analysis into a recommendation that Sales leadership could actually act on.
I would prioritize those three things over the volume of SQL, number of charts, or complexity of the architecture.

And I would make the final recommendation the centerpiece, not the notebook. The notebook should provide the evidence supporting your conclusions.












This might also interest you.


Ad
Ad options



Learn more
















can i not download the chat in a file to upload to project?













Yes! You can download this ChatGPT conversation and put it in your project's chat_logs/ folder.

There are a couple of options:

Option 1: Copy this conversation
1. Select the conversation text.
2. Copy it into a text or Markdown file.
3. Save it as chat_logs/snap_assessment_chat.md.
Option 2: Export your ChatGPT data
1. Open Settings → Data Controls.
2. Select Export Data.
3. Confirm the export.
4. You'll receive an email with a download link to a ZIP containing your ChatGPT conversation history.
5. Extract the relevant conversation.
I'd recommend Option 1 for this assessment. It's simpler, and you only need to provide the AI conversations relevant to the project.

One suggestion: Keep the chat logs as Markdown rather than PDF. They're easier to read, search, and review in GitHub. You can also include a short note in your README explaining how AI was used.














Ad
Ad options



Learn more















if i'm going to do staging, maybe i should set up dbt.













Honestly, I think that's a reasonable point to reconsider. If you're going to create staging models, dbt starts making more sense, particularly because you already have experience with it and have used it in your Taskmaster portfolio project.

I'd lean toward setting up a lightweight dbt project, but keeping the scope deliberately small.

The benefit isn't just cleaner SQL. It gives you an opportunity to demonstrate the analytics engineering workflow alongside the business analysis.
Suggested architecture
I'd use DuckDB + dbt, similar to Taskmaster.
snap-assessment/
│
├── analysis/
│   └── opportunity_analysis.ipynb
│
├── chat_logs/
│
├── data/
│   └── raw/
│
├── docs/
│   ├── findings.md
│   └── methodology.md
│
├── ingestion/
│   └── load_data.py
│
├── snap_dbt/
│   ├── models/
│   │   ├── staging/
│   │   ├── intermediate/
│   │   └── marts/
│   ├── tests/
│   ├── dbt_project.yml
│   └── profiles.yml
│
├── warehouse/
│
└── requirements.txt


What I'd build in dbt
Layer	Responsibility	Example
Staging	Clean and standardize individual sources	stg_dataset_01
Intermediate	Combine sources and derive attributes	int_merchant_enrichment
Marts	Business-facing outputs	mart_merchant_opportunities

I'd also add a few basic tests:
- Unique business identifiers where appropriate.
- Not-null checks on essential fields.
- Accepted values for categorical fields.
- Relationship checks where appropriate.
- Source row counts and reconciliation.
Don't overdo testing before understanding the data.
Where I'd draw the line
I would NOT spend time on:
- Complex macros.
- Elaborate documentation generation.
- Multiple environments.
- CI/CD.
- Sophisticated incremental models.
- Overly abstract model structures.
You have a technical assessment with a business objective. The architecture should support the analysis, not become the project.
My recommendation
I'd aim for this balance:
Assessment effort allocation
Data exploration and quality
25%



dbt modeling and validation
20%



Business opportunity analysis
35%



Presentation and recommendations
20%



Suggested allocation of your remaining assessment time, not a requirement.
One other thing: I would avoid building your merchant opportunity scoring model until you've explored the datasets. Let the available data determine which signals are meaningful.

I think dbt is worth including here. It reinforces your analytics engineering experience without distracting from what Snap actually wants you to demonstrate.












This might also interest you.


Ad
Ad options



Learn more
















in one of the tables (card_list), the zip code have Contains 5-digit and ZIP+4 formats with out the hyphen, examples:

85376
099387672
468671822

i want to clean this field to get the 5-digit zip code













I'd handle this in your dbt staging model, preserving the ZIP code as a string (important because ZIP codes can start with zero).

Since your ZIP+4 values have nine digits without a hyphen, you can simply take the first five characters.

DuckDB SQL:
LEFT(TRIM(CAST(zip_code AS VARCHAR)), 5) AS zip_code


Examples:
Original	Cleaned
85376	85376
099387672	09938
468671822	46867

I'd also consider handling invalid or incomplete ZIP codes:
CASE
    WHEN REGEXP_MATCHES(TRIM(CAST(zip_code AS VARCHAR)), '^[0-9]{5}([0-9]{4})?$')
    THEN LEFT(TRIM(CAST(zip_code AS VARCHAR)), 5)
    ELSE NULL
END AS zip_code


This:
- Accepts standard five-digit ZIP codes.
- Accepts nine-digit ZIP+4 values without a hyphen.
- Rejects malformed values rather than silently creating potentially misleading ZIP codes.
- Preserves leading zeros.
My recommendation: Use the second approach in staging. You want to standardize the data while making data quality issues visible rather than accidentally masking them.

















if has a hyphen use split?













Yes. You can handle both ZIP+4 formats (with and without a hyphen) using SPLIT_PART and a little conditional logic.

In DuckDB:
CASE
    WHEN REGEXP_MATCHES(TRIM(zip_code), '^[0-9]{5}(-[0-9]{4}|[0-9]{4})?$')
    THEN LEFT(TRIM(zip_code), 5)
    ELSE NULL
END AS zip_code


This handles:
Original	Result
85376	85376
099387672	09938
46867-1822	46867
09938-7672	09938

You actually don't need SPLIT_PART here because taking the first five characters works for all three formats.

I'd keep ZIP codes as VARCHAR to preserve leading zeros.












This might also interest you.


Ad
Ad options



Learn more
















how do i make this work?
  CASE
    WHEN REGEXP_MATCHES(TRIM(zip_code), '^[0-9]{5}(-[0-9]{4}|[0-9]{4})?$')
      THEN LEFT(TRIM(zip_code), 5)+RIGHT(TRIM(zip_code), 4)
    ELSE NULL
  END AS zip_code_plus_4,













The issue is that + is arithmetic addition in SQL, not string concatenation.

In DuckDB, use ||:
CASE
    WHEN REGEXP_MATCHES(TRIM(zip_code), '^[0-9]{5}(-[0-9]{4}|[0-9]{4})?$')
        THEN LEFT(TRIM(zip_code), 5) || RIGHT(TRIM(zip_code), 4)
    ELSE NULL
END AS zip_code_plus_4


However, there's one thing I'd change: for standard five-digit ZIP codes, RIGHT(..., 4) would duplicate the last four digits.

If you want to normalize everything to ZIP+4 format where available:
CASE
    WHEN REGEXP_MATCHES(TRIM(zip_code), '^[0-9]{5}-[0-9]{4}$')
        THEN REPLACE(TRIM(zip_code), '-', '')
    WHEN REGEXP_MATCHES(TRIM(zip_code), '^[0-9]{9}$')
        THEN TRIM(zip_code)
    WHEN REGEXP_MATCHES(TRIM(zip_code), '^[0-9]{5}$')
        THEN TRIM(zip_code) || '0000'
    ELSE NULL
END AS zip_code_plus_4


I'd actually keep two fields in staging:
- zip_code: standardized five-digit ZIP.
- zip_code_plus_4: nine-digit ZIP+4 when available, otherwise NULL.
That way, you don't invent ZIP+4 information for records that only have five-digit ZIP codes.





now this one please
select
	mid,
  lower(trim(dba_name)) as company_name_clean,
	industry,
	product_type,
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
  CASE
      WHEN REGEXP_MATCHES(TRIM(merchant_zip_code), '^[0-9]{5}-[0-9]{4}$')
          THEN TRIM(merchant_zip_code)
      WHEN REGEXP_MATCHES(TRIM(merchant_zip_code), '^[0-9]{9}$')
          THEN LEFT(TRIM(merchant_zip_code), 5) || '-' || RIGHT(TRIM(merchant_zip_code), 4)
      ELSE NULL
  END AS zip_code_plus_4,
	is_inactivated::boolean as is_inactivated,
	apps_ytd::int as apps_ytd,
	aprv_ytd::int as aprv_ytd,
	cmpl_ytd::int as cmpl_ytd,
	fund_ytd::numeric as fund_ytd,
	_loaded_at
from "snap-assessment".raw.snap
…
Here's the equivalent missing-value profile for snap, including NULLs and blank strings, in the same vertical format.

WITH source AS (
    SELECT *
    FROM "snap-assessment".raw.snap
),

quality AS (
    SELECT
        COUNT(*) AS total_records,

        COUNT(*) FILTER (
            WHERE mid IS NULL OR TRIM(CAST(mid AS VARCHAR)) = ''
        ) AS mid_missing,

        COUNT(*) FILTER (
            WHERE dba_name IS NULL OR TRIM(dba_name) = ''
        ) AS company_name_missing,

        COUNT(*) FILTER (
            WHERE industry IS NULL OR TRIM(industry) = ''
        ) AS industry_missing,

        COUNT(*) FILTER (
            WHERE product_type IS NULL OR TRIM(product_type) = ''
        ) AS product_type_missing,

        COUNT(*) FILTER (
            WHERE merchant_address IS NULL OR TRIM(merchant_address) = ''
        ) AS street_address_missing,

        COUNT(*) FILTER (
            WHERE merchant_city IS NULL OR TRIM(merchant_city) = ''
        ) AS city_missing,

        COUNT(*) FILTER (
            WHERE merchant_state IS NULL OR TRIM(merchant_state) = ''
        ) AS state_missing,

        COUNT(*) FILTER (
            WHERE merchant_zip_code IS NULL OR TRIM(merchant_zip_code) = ''
        ) AS zip_code_missing,

        COUNT(*) FILTER (
            WHERE is_inactivated IS NULL
        ) AS is_inactivated_missing,

        COUNT(*) FILTER (
            WHERE apps_ytd IS NULL
        ) AS apps_ytd_missing,

        COUNT(*) FILTER (
            WHERE aprv_ytd IS NULL
        ) AS aprv_ytd_missing,

        COUNT(*) FILTER (
            WHERE cmpl_ytd IS NULL
        ) AS cmpl_ytd_missing,

        COUNT(*) FILTER (
            WHERE fund_ytd IS NULL
        ) AS fund_ytd_missing,

        COUNT(*) FILTER (
            WHERE _loaded_at IS NULL
        ) AS loaded_at_missing

    FROM source
),

results AS (
    SELECT 'mid' AS field, mid_missing AS missing_count FROM quality
    UNION ALL
    SELECT 'company_name', company_name_missing FROM quality
    UNION ALL
    SELECT 'industry', industry_missing FROM quality
    UNION ALL
    SELECT 'product_type', product_type_missing FROM quality
    UNION ALL
    SELECT 'street_address', street_address_missing FROM quality
    UNION ALL
    SELECT 'city', city_missing FROM quality
    UNION ALL
    SELECT 'state', state_missing FROM quality
    UNION ALL
    SELECT 'zip_code', zip_code_missing FROM quality
    UNION ALL
    SELECT 'is_inactivated', is_inactivated_missing FROM quality
    UNION ALL
    SELECT 'apps_ytd', apps_ytd_missing FROM quality
    UNION ALL
    SELECT 'aprv_ytd', aprv_ytd_missing FROM quality
    UNION ALL
    SELECT 'cmpl_ytd', cmpl_ytd_missing FROM quality
    UNION ALL
    SELECT 'fund_ytd', fund_ytd_missing FROM quality
    UNION ALL
    SELECT '_loaded_at', loaded_at_missing FROM quality
)

SELECT
    field,
    missing_count,
    ROUND(100.0 * missing_count / total_records, 2) AS missing_percent
FROM results
CROSS JOIN quality
ORDER BY missing_percent DESC;

A few fields I'd pay particular attention to
For the Snap assessment, these are potentially valuable:

industry and product_type: Help identify merchant segments and potential acquisition opportunities.

apps_ytd, aprv_ytd, cmpl_ytd: Could help assess application volume and conversion through the merchant funnel.

fund_ytd: Potential indicator of merchant business volume.

is_inactivated: Important for distinguishing active merchants from inactive ones.

One distinction to preserve in your analysis: a NULL in fund_ytd is not necessarily equivalent to zero funding. Don't automatically replace missing values with zero without understanding the source's semantics.

This might also interest you.



would like to print a better table display of a dataframe
In Jupyter, I'd recommend using Pandas Styler. It makes DataFrames much easier to read without having to build custom visualizations.

1. Basic clean display
display(
    df.style
    .format(precision=2)
    .set_caption("Data Quality Summary")
    .set_properties(**{
        "text-align": "left",
        "padding": "6px"
    })
    .set_table_styles([
        {"selector": "th", "props": [("text-align", "left"),
                                     ("font-weight", "bold")]},
        {"selector": "caption", "props": [("font-size", "16px"),
                                          ("font-weight", "bold"),
                                          ("text-align", "left")]}
    ])
)

2. Highlight missing percentages
For your data quality analysis, I'd go a step further and conditionally highlight missing percentages.

display(
    df.style
    .format({
        "missing_count": "{:,.0f}",
        "missing_percent": "{:.2f}%"
    })
    .background_gradient(
        subset=["missing_percent"],
        cmap="RdYlGn_r"
    )
    .set_caption("Data Quality Summary")
    .hide(axis="index")
)

Assumes your percentage column contains values like 12.5 rather than 0.125.

3. My preferred approach for your assessment
I'd create a reusable function so all five datasets have consistent formatting.

def display_quality(df, title="Data Quality Summary"):
    display(
        df.style
        .format({
            "missing_count": "{:,.0f}",
            "missing_percent": "{:.2f}%"
        })
        .background_gradient(
            subset=["missing_percent"],
            cmap="RdYlGn_r",
            vmin=0,
            vmax=100
        )
        .set_caption(title)
        .set_properties(**{
            "text-align": "left",
            "padding": "6px"
        })
        .hide(axis="index")
    )

Usage:

display_quality(card_list_quality, "Card List - Data Quality")
display_quality(purchased_list_quality, "Purchased List - Data Quality")
display_quality(snap_quality, "Snap - Data Quality")

This will give your notebook a consistent, polished look and make it easier to compare datasets.

I'd use this approach throughout the assessment rather than manually formatting each DataFrame.

i have this function:
def df_profile(df: pd.DataFrame) -> pd.DataFrame:
    """Return a DataFrame with the profile of the input DataFrame."""
    # 1. Get the standard description summary
    description = df.describe(include='all')

    # 2. Calculate explicit null metrics
    null_counts = df.isnull().sum()
    null_percentages = (df.isnull().mean() * 100).round(2)

    # 3. Create a small DataFrame for the new metrics
    null_info = pd.DataFrame([null_counts, null_percentages], 
                            index=['null_count', 'null_percent'], 
                            columns=df.columns)

    # 4. Combine them into one comprehensive summary
    extended_description = pd.concat([description, null_info])
    return extended_description

how do i add the blank/empty string like the sql did?
I'd add a missing metric that combines actual NULLs and blank/whitespace-only strings, while keeping the separate NULL metrics. That way you can distinguish them.

Here's your updated function:

def df_profile(df: pd.DataFrame) -> pd.DataFrame:
    """Return a DataFrame with descriptive statistics and missing-value metrics."""

    # 1. Standard description summary
    description = df.describe(include='all')

    # 2. Calculate NULL and blank metrics
    null_counts = df.isnull().sum()

    blank_counts = df.apply(
        lambda col: col.astype("string").str.strip().eq("").sum()
    )

    missing_counts = null_counts + blank_counts

    null_percentages = (null_counts / len(df) * 100).round(2)
    missing_percentages = (missing_counts / len(df) * 100).round(2)

    # 3. Create metrics DataFrame
    missing_info = pd.DataFrame(
        [
            null_counts,
            blank_counts,
            missing_counts,
            null_percentages,
            missing_percentages
        ],
        index=[
            'null_count',
            'blank_count',
            'missing_count',
            'null_percent',
            'missing_percent'
        ],
        columns=df.columns
    )

    # 4. Combine into comprehensive summary
    extended_description = pd.concat([description, missing_info])

    return extended_description

What the metrics mean
Metric

Meaning

null_count

Actual Pandas NULL/NaN values

blank_count

Empty strings or strings containing only whitespace

missing_count

NULLs + blanks

null_percent

Percentage of records with NULLs

missing_percent

Percentage of records missing a value

One small detail: astype("string") preserves missing values as pd.NA, so they won't accidentally be counted as blank strings. This also works across numeric, string, and mixed-type columns.

I'd use missing_percent as your primary data quality metric when comparing the five datasets.




this data set from purchased list:

speedeonid	company_name_raw	company_name_clean	street_address_raw	street_address_clean	
0	296348196	Aero Auto Repair	aero auto repair	0243 Aero Dr	0243 aero dr
1	597120512	Aero Auto Repair	aero auto repair	0243 Aero Dr	0243 aero dr
2	818597784	Aero Auto Repair	aero auto repair	1134 Lake Murray Blvd	1134 lake murray blvd




i get for street clean i get 3 unique, but raw i get 2 unique... shouldn't both be 2?















Not necessarily, but based on the three rows you've shown, both should have 2 unique values.

Let's look at the values:
Raw	Clean
0243 Aero Dr	0243 aero dr
0243 Aero Dr	0243 aero dr
1134 Lake Murray Blvd	1134 lake murray blvd

Lowercasing and trimming should not change the number of unique values in this example.
What might be happening?
I'd investigate a few possibilities:
1. Whitespace differences: Some values might contain tabs, newlines, or non-breaking spaces.
2. Hidden characters: Two strings that look identical may have different underlying Unicode characters.
3. Your cleaning transformation: Something other than lower(trim()) may be changing the values.
Let's troubleshoot in Pandas
First, compare the unique values:
print("Raw unique:", df["street_address_raw"].nunique())print("Clean unique:", df["street_address_clean"].nunique())



Then inspect their representations to expose hidden characters:
for value in df["street_address_raw"].dropna().unique():    print(repr(value))print("--- CLEAN ---")for value in df["street_address_clean"].dropna().unique():    print(repr(value))



You can also identify which raw values map to multiple cleaned values:
df.groupby("street_address_raw")["street_address_clean"].nunique().sort_values(    ascending=False).head(20)



One other thing
Your current cleaning logic:
LOWER(TRIM(street)) AS street_address_clean


only removes leading/trailing whitespace. It doesn't normalize internal whitespace or special characters.

For a more thorough cleanup, you could eventually use:
LOWER(
    REGEXP_REPLACE(TRIM(street), '\s+', ' ', 'g')
) AS street_address_clean


But I'd investigate the discrepancy before changing the transformation. It's actually a useful data quality finding for your Snap assessment: visually identical business addresses aren't necessarily identical values in the underlying data.

















ugh, i'm realizing in my query i am missing the distinct for street clean count













Ahh, that would explain it! Easy mistake when profiling several columns.

If you're calculating unique counts in SQL, make sure you're comparing:
COUNT(DISTINCT street) AS street_address_raw_unique,

COUNT(DISTINCT LOWER(TRIM(street))) AS street_address_clean_unique


And in Pandas, the equivalent is:
df["street_address_raw"].nunique()df["street_address_clean"].nunique()



No harm done. Actually, this is exactly why it's useful to profile both raw and cleaned fields during staging!












This might also interest you.


Ad
Ad options



Learn more
















ok began looking at what each of the datasets could provide some value. 
with the snap data, which is the internal list. so thinking to look at top active product and industry. i have this query:
select
  product_type,
  industry,
  count(*) as n_active_companies,
  sum(apps_ytd) as apps_ytd,
  sum(aprv_ytd) as aprv_ytd,
  round(sum(aprv_ytd) / sum(apps_ytd) * 100, 2) as approval_rate_ytd,
  sum(cmpl_ytd) as cmpl_ytd,
  round(sum(cmpl_ytd) / sum(apps_ytd) * 100, 2) as completion_rate_ytd,
  sum(fund_ytd) as fund_ytd
from "snap-assessment".staging.stg_snap
where 1=1
  and not is_inactivated
  and dupe_record_rank=1
group by all
order by product_type, fund_ytd desc

where you can quickly see the two products: lease and loan. lease is more popular. i think the fund amount is obviously nice to know what gives the most money, but rates are good right? i just wonder if i should weight it with how many actually companies are part of it.
also wondering about best figures to show in a presentation













I think you're looking at the right metrics. I'd actually make this one of the first substantive analyses in your assessment because it establishes a baseline for what Snap's existing merchant portfolio looks like.

There are a couple of important distinctions I'd make, though.
1. Should you weight by number of companies?
I'd include the company count, but I wouldn't necessarily multiply or weight your rates by it. Your current calculation already does something useful:
SUM(aprv_ytd) / SUM(apps_ytd) * 100


That's a volume-weighted approval rate. A merchant with 10,000 applications contributes more to the overall rate than one with 10 applications.

I'd look at three different dimensions:
Dimension	What it tells you
Number of merchants	How widely adopted is the product/industry?
Application volume	How much demand does it generate?
Funding volume	How much financing activity does it generate?

Then use rates to understand how effectively that activity converts.

For example, an industry with 100 merchants and $10M in funding might be more interesting than one with 5 merchants and $2M, even though the latter has higher funding per merchant.

Neither is automatically better. They represent different opportunities.
2. Metrics I'd include
I'd organize the analysis into four categories.

Merchant coverage
- Active merchant count
- Percentage of active merchants
- Average applications per merchant
Application volume
- Total applications
- Applications per merchant
Conversion
- Approval rate = approvals / applications
- Completion rate = completed / applications
- Approved-to-completed rate = completed / approvals
Funding
- Total funding volume
- Funding per merchant
- Funding per application
- Funding per completed application
One important distinction: your existing completion_rate_ytd measures applications that ultimately completed. I'd also calculate completed / approved to understand how effectively approved applications make it through the remaining funnel.

Also, I'd call fund_ytd funding volume rather than revenue. Those aren't necessarily the same thing.
3. I'd modify your query slightly
I'd add per-merchant metrics and a few additional conversion measures.
WITH merchant_segments AS (
    SELECT
        product_type,
        industry,
        COUNT(DISTINCT mid) AS active_merchants,
        SUM(apps_ytd) AS apps_ytd,
        SUM(aprv_ytd) AS aprv_ytd,
        SUM(cmpl_ytd) AS cmpl_ytd,
        SUM(fund_ytd) AS fund_ytd

    FROM "snap-assessment".staging.stg_snap
    WHERE NOT is_inactivated
      AND dupe_record_rank = 1
    GROUP BY ALL
)

SELECT
    product_type,
    industry,

    -- Merchant coverage
    active_merchants,

    -- Application volume
    apps_ytd,
    ROUND(apps_ytd * 1.0 / NULLIF(active_merchants, 0), 1)
        AS apps_per_merchant,

    -- Conversion
    aprv_ytd,
    ROUND(100.0 * aprv_ytd / NULLIF(apps_ytd, 0), 2)
        AS approval_rate,

    cmpl_ytd,
    ROUND(100.0 * cmpl_ytd / NULLIF(apps_ytd, 0), 2)
        AS application_completion_rate,

    ROUND(100.0 * cmpl_ytd / NULLIF(aprv_ytd, 0), 2)
        AS approved_completion_rate,

    -- Funding
    fund_ytd,
    ROUND(fund_ytd / NULLIF(active_merchants, 0), 2)
        AS funding_per_merchant,

    ROUND(fund_ytd / NULLIF(apps_ytd, 0), 2)
        AS funding_per_application,

    ROUND(fund_ytd / NULLIF(cmpl_ytd, 0), 2)
        AS funding_per_completed_application

FROM merchant_segments
ORDER BY product_type, fund_ytd DESC;


This gives you a much more complete picture.

One caveat: these per-merchant figures are averages. A handful of very large merchants could skew them considerably. I'd eventually investigate the median merchant-level application and funding volumes as well.
4. What I'd show in the presentation
I wouldn't put every metric from that query into a slide. I'd build two visualizations.
Visualization 1: Product performance
Illustrative layout — not actual Snap data
Product comparison
Product A
Lease
Higher volume

Product B
Loan



Compare these metrics side by side:
- Active merchants
- Application volume
- Approval rate
- Completion rate
- Total funding
- Funding per merchant

This establishes which products are driving the business.
Visualization 2: Industry opportunity
I'd use a scatter plot:
- X-axis: Application volume
- Y-axis: Approval rate
- Bubble size: Funding volume
- Color: Product type
This is particularly interesting because it can reveal:
Pattern	Potential interpretation
High applications, high approval	Strong existing market
High applications, low approval	Potential qualification or product-fit issue
Low applications, high approval	Potentially underserved opportunity
High funding, low merchant count	Concentrated business activity

This is more analytically interesting than simply ranking industries by funding.
5. How this connects to merchant acquisition
Here's where I'd be careful about the interpretation.

Your Snap dataset describes existing merchants. It tells you what has worked historically, but it doesn't automatically tell you which new businesses to acquire.

I'd use this analysis to establish an ideal merchant profile.

For example, suppose your analysis finds:
- Lease is responsible for most application volume.
- Certain industries have consistently strong approval and completion rates.
- Some industries generate significantly more funding per merchant.
- Some industries have relatively few active merchants but strong performance.
Those findings become signals you can look for in the external purchased datasets.

You can then ask:
1. Are there businesses in these high-performing industries that aren't already Snap merchants?
2. Are those businesses geographically concentrated?
3. Do they have characteristics similar to Snap's successful existing merchants?
4. Which ones should Sales prioritize?
That last step is the real purpose of the assessment.

My suggested next step
I'd finish this Snap analysis first, then move to the purchased business list and investigate its industry, employee count, square footage, and geographic coverage.

Ultimately, I'd like your assessment to tell a story:

What makes an attractive Snap merchant → Where can we find more of them → Which prospects should Sales contact first → How do we measure whether the strategy works?

That's a much stronger Lead BI Analytics Engineer deliverable than five disconnected dataset summaries.












This might also interest you.


Ad
Ad options



Learn more
















your query has "funding per merchant" but it's really funding per product type and industry













You're right. More precisely, it's average funding per active merchant within each product type + industry combination.

The calculation is correct:
SUM(fund_ytd) / COUNT(DISTINCT mid)


But I'd rename the metric to make the grain explicit:
ROUND(fund_ytd / NULLIF(active_merchants, 0), 2)
    AS avg_funding_per_merchant


And in your presentation, label it:

Average funding per active merchant (by product and industry)

The distinction matters because you're grouping by both product_type and industry. You're not calculating an overall merchant average.

I'd also use the same naming convention for the other metrics:
- avg_apps_per_merchant
- avg_funding_per_merchant
- avg_funding_per_application
- avg_funding_per_completed_application
That makes the aggregation level much clearer when someone reviews your SQL or presentation.












For presenting your dataset insights, here’s one serverless lakehouse option.


Ad
Ad options



Learn more
















but the fund_ytd is the sum of product type and industry, not of a merchant













I think we're actually saying the same thing about the aggregation, but there's an important distinction worth making.

Your fund_ytd in the query is:
SUM(fund_ytd)


That is the total funding across all merchants in a particular product type + industry group.

When you divide that by active_merchants, you get the average funding per merchant within that group.

For example:
Product	Industry	Merchants	Total funding	Avg. funding/merchant
Lease	Furniture	100	$5M	$50K
Lease	Electronics	20	$2M	$100K
Loan	Furniture	50	$1.5M	$30K

So the calculation is mathematically valid, assuming each mid represents one merchant and fund_ytd is the merchant's funding total.

However, I'd make one distinction in your analysis:
- total_funding_by_product_industry: Total funding generated by the segment.
- avg_funding_per_merchant: Average funding generated per merchant in that segment.
Both are useful, but they answer different business questions.

For acquisition strategy, I'd probably show both. Total funding identifies the largest existing opportunities, while average funding per merchant helps identify segments where an individual merchant may be particularly valuable.












For turning warehouse queries into reports, here’s one BI dashboard option.


Ad
Ad options



Learn more
















I get what you are saying, but probably quite a variance.

i want help with this:
Visualization 2: Industry opportunity
I'd use a scatter plot:
- X-axis: Application volume
- Y-axis: Approval rate
- Bubble size: Funding volume
- Color: Product type
This is particularly interesting because it can reveal:



Pattern



Potential interpretation



High applications, high approval



Strong existing market



High applications, low approval



Potential qualification or product-fit issue



Low applications, high approval



Potentially underserved opportunity



High funding, low merchant count



Concentrated business activity

This is more analytically interesting than simply ranking industries by funding.















I think this is a really good direction, especially for connecting the internal Snap data to the external prospecting datasets.

Let's work through how to build this in a way that is analytically sound and doesn't overstate what the data tells us.

First, I agree that merchant-level averages can be misleading because funding is likely highly skewed. For this visualization, I'd keep total funding as bubble size, rather than average funding per merchant. That way, you're showing the economic scale of each industry/product segment without implying that every merchant performs similarly.
1. Build the industry opportunity scatter plot
Your unit of analysis should be:

One point = one product type + industry combination.

Each point represents an aggregated segment of existing Snap merchants.
Visual element	Metric
X-axis	Total applications YTD
Y-axis	Approval rate
Bubble size	Total funding YTD
Color	Product type
Tooltip	Industry, merchant count, applications, approvals, completions, funding

I would also add merchant count to the tooltip. It provides important context for interpreting each segment.
2. SQL to produce the visualization data
I'd use a slightly expanded version of your existing query:
SELECT
    product_type,
    industry,
    COUNT(DISTINCT mid) AS active_merchants,
    SUM(apps_ytd) AS apps_ytd,
    SUM(aprv_ytd) AS aprv_ytd,

    ROUND(
        100.0 * SUM(aprv_ytd) / NULLIF(SUM(apps_ytd), 0), 2
    ) AS approval_rate,

    SUM(cmpl_ytd) AS cmpl_ytd,

    ROUND(
        100.0 * SUM(cmpl_ytd) / NULLIF(SUM(apps_ytd), 0), 2
    ) AS completion_rate,

    SUM(fund_ytd) AS fund_ytd

FROM "snap-assessment".staging.stg_snap
WHERE NOT is_inactivated
  AND dupe_record_rank = 1
GROUP BY ALL
HAVING SUM(apps_ytd) > 0
ORDER BY apps_ytd DESC;


I'd keep this as a separate analysis result rather than modifying your staging model.
3. Create the scatter plot in Jupyter
I'd use Plotly because the interactive tooltips are useful for exploring individual industries.
import plotly.express as pxfig = px.scatter(    industry_performance,    x="apps_ytd",    y="approval_rate",    size="fund_ytd",    color="product_type",    hover_name="industry",    hover_data={        "active_merchants": ":,",        "apps_ytd": ":,",        "aprv_ytd": ":,",        "approval_rate": ":.2f",        "cmpl_ytd": ":,",        "completion_rate": ":.2f",        "fund_ytd": ":$,.0f"    },    size_max=45,    title="Snap Merchant Performance by Industry and Product",    labels={        "apps_ytd": "Applications YTD",        "approval_rate": "Approval Rate (%)",        "product_type": "Product Type",        "fund_ytd": "Funding YTD"    })fig.update_layout(    template="plotly_white",    height=650,    legend_title_text="Product Type")fig.update_yaxes(ticksuffix="%")fig.show()



Replace industry_performance with the name of your query result DataFrame.
4. How I'd interpret the quadrants
I'd add reference lines to divide the chart into four areas. Use the median application volume and the overall weighted approval rate as initial reference points.
Industry opportunity framework
High volume / high approval
Strong market
Established segments with demonstrated application demand and conversion.

Low volume / high approval
Explore growth
Potentially underserved segments worth investigating.

High volume / low approval
Investigate
Demand exists, but approval performance warrants further investigation.

Low volume / low approval
Lower priority
Less demonstrated demand and weaker conversion.


Conceptual framework; actual quadrants depend on your data and chosen reference lines.
One caveat: low approval rates don't necessarily mean an industry is unattractive. They could reflect customer credit profiles, application quality, or differences in Snap's underwriting criteria. I'd avoid treating approval rate as a direct measure of merchant quality.
5. Two things I'd investigate before presenting
Funding distribution: If funding is heavily skewed, a few industries could dominate bubble sizes. Consider a second version with a logarithmic funding scale, or a table ranking the segments by funding.

Merchant concentration: Add merchant count to your interpretation. An industry generating $10M across 100 merchants is a different opportunity from one generating $10M across three merchants.

I'd actually create a companion table:
Product	Industry	Merchants	Applications	Approval	Funding
Lease	Industry A	...	...	...	...
Lease	Industry B	...	...	...	...
Loan	Industry A	...	...	...	...

Sort by total funding or application volume and use the scatter plot to explore the relationships.

My recommendation: Make the scatter plot your exploratory visualization, not necessarily your final presentation slide. Once you see the actual results, identify 3–5 interesting industry segments and explain why they matter.

That will give you a much stronger business story than simply saying Lease is more popular than Loan.












This might also interest you.


Ad
Ad options



Learn more
















getting errors:
--------------------------------------------------------------------------- ValueError                                Traceback (most recent call last) Cell In[4], line 1 ----> 1 fig = px.scatter(       2     df_snap_peformance,       3     x="apps_ytd",       4     y="approval_rate",  File c:\dev\snap-assessment\.venv\Lib\site-packages\plotly\express\_chart_types.py:69, in scatter(data_frame, x, y, color, symbol, size, hover_name, hover_data, custom_data, text, facet_row, facet_col, facet_col_wrap, facet_row_spacing, facet_col_spacing, error_x, error_x_minus, error_y, error_y_minus, animation_frame, animation_group, category_orders, labels, orientation, color_discrete_sequence, color_discrete_map, color_continuous_scale, range_color, color_continuous_midpoint, symbol_sequence, symbol_map, opacity, size_max, marginal_x, marginal_y, trendline, trendline_options, trendline_color_override, trendline_scope, log_x, log_y, range_x, range_y, render_mode, title, subtitle, template, width, height)      14 def scatter(      15     data_frame=None,      16     x=None,    (...)     63     height=None,      64 ) -> go.Figure:      65     """      66     In a scatter plot, each row of `data_frame` is represented by a symbol      67     mark in 2D space.      68     """ ---> 69     return make_figure(args=locals(), constructor=go.Scatter)  File c:\dev\snap-assessment\.venv\Lib\site-packages\plotly\express\_core.py:2724, in make_figure(args, constructor, trace_patch, layout_patch)    2719         group = group.with_columns((nw.col(var) / group_sum) * 100.0)    2721 patch, fit_results = make_trace_kwargs(    2722     args, trace_spec, group, mapping_labels.copy(), sizeref    2723 )
...
        Invalid elements include: [nan]      The 'size' property is a number and may be specified as:       - An int or float in the interval [0, inf]       - A tuple, list, or one-dimensional numpy array of the above
Output is truncated. View as a scrollable element or open in a text editor. Adjust cell output settings...\















The error is coming from the size="fund_ytd" argument. Plotly is finding at least one NaN value in fund_ytd, and bubble sizes must be valid non-negative numbers.

I'd first check how many missing values you have:
df_snap_peformance[["apps_ytd", "approval_rate", "fund_ytd"]].isna().sum()



Also check for negative funding values:
df_snap_peformance["fund_ytd"].describe()



Recommended fix: Since funding is being used only to control bubble size, you can replace missing funding values with zero for plotting. Keep the original data unchanged.
df_plot = df_snap_peformance.copy()df_plot["fund_ytd"] = (    pd.to_numeric(df_plot["fund_ytd"], errors="coerce")    .fillna(0)    .clip(lower=0))



Then use df_plot in your chart:
fig = px.scatter(    df_plot,    x="apps_ytd",    y="approval_rate",    size="fund_ytd",    color="product_type",    hover_name="industry",    hover_data={        "active_merchants": ":,",        "apps_ytd": ":,",        "aprv_ytd": ":,",        "approval_rate": ":.2f",        "cmpl_ytd": ":,",        "completion_rate": ":.2f",        "fund_ytd": ":$,.0f"    },    size_max=45,    title="Snap Merchant Performance by Industry and Product",    labels={        "apps_ytd": "Applications YTD",        "approval_rate": "Approval Rate (%)",        "product_type": "Product Type",        "fund_ytd": "Funding YTD"    })fig.update_layout(template="plotly_white", height=650)fig.update_yaxes(ticksuffix="%")fig.show()



One caveat: a missing funding value isn't necessarily equivalent to zero funding. This replacement is just to make the visualization work; retain the distinction in your underlying data quality analysis.

I'd also check whether any of the other chart fields have missing values, particularly apps_ytd and approval_rate. Those affect where the points appear, rather than just their size.