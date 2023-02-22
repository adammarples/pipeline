"""
Generate data for project.

Event level data: receive daily
    - event_id
    - event_date
    - event_type (impressions, clicks, conversions.
    - campaign_id
    - url
    - device_id
    - state

Static table:
Device level data:
    - device_id
    - device_type
    - device_model

Campaign level data: receive daily
    - campaign_id
    - campaign_name
    - campaign_start_date
    - campaign_end_date
    - campaign_duration
    - campaign_budget
    - campaign_target_state

Model will be Campaign Hub, Event Hub, Device Hub

"""
import hashlib
import random
from datetime import datetime, timedelta
from pathlib import Path

import polars as pl
from faker import Faker

fake = Faker()

Faker.seed(0)
random.seed(0)

start = datetime(2020, 1, 1)
end = datetime(2020, 12, 31)


def create_hash_id_from_name(name):
    return hashlib.sha256(name.encode("utf-8")).hexdigest()


def _generate_campaigns():
    dt = start
    while dt <= end:
        # 1 - 10 new campaigns per day
        n = random.randint(1, 10)
        for i in range(n):
            campaign_name = fake.company()
            # campaigns start today
            campaign_start_date = dt.date()
            campaign_duration = random.choice((30, 60, 90, 120))
            campaign_end_date = fake.date_between(
                start_date=campaign_start_date,
                end_date=campaign_start_date + timedelta(campaign_duration),
            )
            yield {
                "campaign_id": create_hash_id_from_name(
                    campaign_name + str(i) + str(dt)
                ),
                "campaign_name": campaign_name,
                "campaign_start_date": campaign_start_date,
                "campaign_end_date": campaign_end_date,
                "campaign_duration": campaign_duration,
                "campaign_budget": random.choice((1_000, 10_000, 2_000, 20_000)),
                "campaign_target_state": fake.state_abbr(),
            }
        dt += timedelta(days=1)


def generate_campaigns():
    return pl.DataFrame(_generate_campaigns())


def _generate_devices():

    for device_model in ("pc", "mac"):
        device_type = "desktop"
        device_id = create_hash_id_from_name(device_type + device_model)
        yield {
            "device_id": device_id,
            "device_type": device_type,
            "device_model": device_model,
        }
    for device_model in ("iphone", "android"):
        device_type = "mobile"
        device_id = create_hash_id_from_name(device_type + device_model)
        yield {
            "device_id": device_id,
            "device_type": device_type,
            "device_model": device_model,
        }
    for device_model in ("pixel", "ipad"):
        device_type = "tablet"
        device_id = create_hash_id_from_name(device_type + device_model)
        yield {
            "device_id": device_id,
            "device_type": device_type,
            "device_model": device_model,
        }


def generate_devices():
    return pl.DataFrame(_generate_devices())


def _generate_events_for_dt(devices, allowed_campaigns, dt):
    """
    Event level data: receive daily
    - event_id
    - event_date
    - event_type (impressions, clicks, conversions.
    - campaign_id
    - user_id
    - url
    - device_id
    - state
    - region

    """
    n = random.randint(1_000, 10_000)
    for i in range(n):
        yield {
            "event_id": fake.uuid4(),
            "event_date": fake.date_time_between(
                start_date=dt, end_date=dt + timedelta(days=1)
            ),
            "event_type": random.choice(("impression", "click", "conversion")),
            "campaign_id": random.choice(allowed_campaigns),
            "url": fake.url(),
            "device_id": random.choice(list(devices["device_id"])),
            "state": fake.state_abbr(),
        }


if __name__ == "__main__":
    raw_dir = Path(__file__).parent.joinpath("raw")
    # raw_dir.unlink(missing_ok=True)
    raw_dir.mkdir(exist_ok=True)
    campaign_dir = raw_dir / "campaigns"
    campaign_dir.mkdir(parents=True, exist_ok=True)
    events_dir = raw_dir / "events"
    events_dir.mkdir(parents=True, exist_ok=True)
    devices_dir = raw_dir / "devices"
    devices_dir.mkdir(parents=True, exist_ok=True)
    campaigns = generate_campaigns()
    devices = generate_devices()
    devices.write_csv(devices_dir / "devices.csv")
    dt = start
    while dt <= end:
        print(dt)
        allowed_campaigns = list(
            campaigns.filter(
                (pl.col("campaign_start_date") <= dt)
                & (pl.col("campaign_end_date") >= dt)
            )["campaign_id"]
        )
        new_campaigns = campaigns.filter(pl.col("campaign_start_date") == dt)
        events = pl.DataFrame(_generate_events_for_dt(devices, allowed_campaigns, dt))
        events.write_csv(
            events_dir / f"events_{dt.strftime('%Y-%m-%d')}.csv", has_header=False
        )
        new_campaigns.write_csv(
            campaign_dir / f"campaigns_{dt.strftime('%Y-%m-%d')}.csv", has_header=False
        )
        dt += timedelta(days=1)
