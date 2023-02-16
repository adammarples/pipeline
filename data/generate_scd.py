"""
Generate slowly changing dimensional data to test how dbt-vault handles it.

Patient level data:
    - id
    - name
    - address_line_1
    - address_line_2
    - city
    - state
    - zip

"""
import hashlib
import random
from pathlib import Path

import polars as pl
from faker import Faker

fake = Faker()

Faker.seed(0)
random.seed(0)


def create_hash_id_from_name(name):
    return hashlib.sha256(name.encode("utf-8")).hexdigest()


def _generate_addresses(n):
    for _ in range(n):
        yield {
            "address_line_1": fake.street_address(),
            "address_line_2": None,
            "city": fake.city(),
            "state": fake.state(),
            "zip": fake.zipcode(),
        }


def _generate_patients(n):
    for i in range(n):
        yield {
            "id": i,
            "name": fake.name(),
        }


if __name__ == "__main__":
    raw_dir = Path(__file__).parent.joinpath("raw")
    # raw_dir.unlink(missing_ok=True)
    # raw_dir.mkdir(exist_ok=True)
    patients_dir = raw_dir / "patients"
    patients_dir.mkdir(parents=True, exist_ok=True)
    events_dir = raw_dir / "events"
    events_dir.mkdir(parents=True, exist_ok=True)
    devices_dir = raw_dir / "devices"
    devices_dir.mkdir(parents=True, exist_ok=True)
    patients = pl.DataFrame(_generate_patients(100))
    addresses = pl.DataFrame(_generate_addresses(100))

    patients_top_5 = patients[:5, :]
    new_addresses_5 = pl.DataFrame(_generate_addresses(5))
    patients1 = pl.concat((patients, addresses), how="horizontal")
    patients2 = pl.concat((patients_top_5, new_addresses_5), how="horizontal")
    patients1.write_csv(patients_dir / "patients_2022-01-01.csv", has_header=False)
    patients2.write_csv(patients_dir / "patients_2022-01-02.csv", has_header=False)
