{% snapshot snap_subscriptions %}

{{
    config(
      target_schema='main',
      unique_key='subscription_id',
      strategy='timestamp',
      updated_at='updated_at'
    )
}}

SELECT * FROM {{ source('clouddesk_raw', 'mp2_subscriptions') }}

{% endsnapshot %}
