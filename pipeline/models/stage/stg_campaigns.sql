{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  raw: "raw_campaigns"
derived_columns:
  SOURCE: FILE_NAME
  EFFECTIVE_FROM: DATE(REGEXP_EXTRACT(FILE_NAME, ".*campaigns_([0-9]{4}-[0-9]{2}-[0-9]{2}).csv"))
  EFFECTIVE_TO: "date('9999-12-31')"
  LOAD_DATETIME: "CURRENT_DATE"
hashed_columns:
  CAMPAIGN_HK: "campaign_id"
  CAMPAIGN_HASHDIFF:
    is_hashdiff: true
    columns:
        - "campaign_id"
        - "campaign_name"
        - "campaign_start_date"
        - "campaign_end_date"
        - "campaign_duration"
        - "campaign_budget"
        - "campaign_target_state"




{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  null_columns=none,
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}