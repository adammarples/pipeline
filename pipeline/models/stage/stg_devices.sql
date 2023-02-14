{{ dbtvault.stage(include_source_columns=true,
                  source_model=source_model,
                  derived_columns=derived_columns,
                  null_columns=null_columns,
                  hashed_columns=hashed_columns,
                  ranked_columns=ranked_columns) }}