# init_db.py (updated with optional clean)
from sqlalchemy import text
from app.db.session import Base, engine
from app.models import *

Base.metadata.create_all(bind=engine, checkfirst=True)

# Add office_name column to restaurants if not exists
with engine.connect() as conn:
    conn.execute(text("""
        DO $$
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                           WHERE table_name = 'restaurants' AND column_name = 'office_name') THEN
                ALTER TABLE restaurants ADD COLUMN office_name VARCHAR;
            END IF;
        END $$;
    """))

    # Add office_name column to shame_restaurants if not exists
    conn.execute(text("""
        DO $$
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                           WHERE table_name = 'shame_restaurants' AND column_name = 'office_name') THEN
                ALTER TABLE shame_restaurants ADD COLUMN office_name VARCHAR;
            END IF;
        END $$;
    """))

    # Add google_id column to shame_restaurants if not exists
    conn.execute(text("""
        DO $$
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                           WHERE table_name = 'shame_restaurants' AND column_name = 'google_id') THEN
                ALTER TABLE shame_restaurants ADD COLUMN google_id VARCHAR;
            END IF;
        END $$;
    """))

    # Optional: Assign default office_name to existing records (e.g., 'Gbg-office')
    conn.execute(text("UPDATE restaurants SET office_name = 'Gbg-office' WHERE office_name IS NULL;"))
    conn.execute(text("UPDATE shame_restaurants SET office_name = 'Gbg-office' WHERE office_name IS NULL;"))
    conn.commit()

# Optional: Clean non-promoted entries (run once manually if needed)
# from sqlalchemy.orm import Session
# session = Session(bind=engine)
# session.execute(text("DELETE FROM restaurants WHERE promoted = False;"))
# session.commit()
# session.close()