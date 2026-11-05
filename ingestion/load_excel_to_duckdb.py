"""
Load the Snap Assessment source Excel file into the raw schema of the local DuckDB warehouse.

Run it from anywhere:   python ingestion/load_excel_to_duckdb.py

Every raw table gets two audit columns:
  _loaded_at      UTC time this load ran
"""
import re
import sys
from pathlib import Path
from datetime import datetime, timezone

import duckdb
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
RAW_DIR = ROOT / "data" / "raw" 
DB_PATH = ROOT / "warehouse" / "snap-assessment.duckdb"

def find_excel_file() -> Path:
    """Find the Excel file in the raw data directory."""
    excel_files = list(RAW_DIR.glob("*.xlsx"))
    if not excel_files:
        print(f"No Excel files found in {RAW_DIR}. Please place the source Excel file there.")
        sys.exit(1)
    if len(excel_files) > 1:
        print(f"Multiple Excel files found in {RAW_DIR}. Please keep only one.")
        sys.exit(1)
    return excel_files[0]

def main() -> None:
    # Load each sheet of the Excel file into a DuckDB table in the raw schema
    excel_path = find_excel_file()
    con = duckdb.connect(str(DB_PATH))
    con.execute("create schema if not exists raw")
    for sheet_name in pd.ExcelFile(excel_path).sheet_names:
        df = pd.read_excel(excel_path, sheet_name=sheet_name, dtype=str)
        df["_loaded_at"] = datetime.now(timezone.utc)
        table_name = re.sub(r"\W+", "_", sheet_name.lower())
        con.execute(f"""
                     create or replace table raw.{table_name} as 
                     select * from df
                """)
        print(f" {sheet_name!r:>20} -> raw.{table_name:<24} {len(df):>8,} rows {len(df.columns)} cols")
    print(f"Done loading {len(pd.ExcelFile(excel_path).sheet_names)} sheets from {excel_path}")
    con.close()
    print(f"Done. DuckDB database: {DB_PATH}")

if __name__ == "__main__":
    main()