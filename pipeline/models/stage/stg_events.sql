{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  raw: "raw_events"
derived_columns:
  SOURCE: "!1"
  LOAD_DATETIME: "CURRENT_DATE"
  EFFECTIVE_FROM: "event_date"
  EFFECTIVE_TO: "date('9999-12-31')"
hashed_columns:
  EVENT_HK: "event_id"
  DEVICE_HK: "device_id"
  CAMPAIGN_HK: "campaign_id"
  EVENT_DEVICE_HK: ["event_id", "device_id"]
  EVENT_CAMPAIGN_HK: ["event_id", "campaign_id"]
  EVENT_HASHDIFF:
    is_hashdiff: true
    columns:
      - "event_id"
      - "event_date"
      - "event_type"
      - "campaign_id"
      - "url"
      - "device_id"
      - "state"

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  null_columns=none,
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}