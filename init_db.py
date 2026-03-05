# init_db.py (schema adjustments only - no destructive cleanup)
from sqlalchemy import text
from app.db.session import Base, engine
from app.models import *

Base.metadata.create_all(bind=engine, checkfirst=True)

# Add columns if not exists
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

    conn.execute(text("""
        DO $$
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                           WHERE table_name = 'shame_restaurants' AND column_name = 'office_name') THEN
                ALTER TABLE shame_restaurants ADD COLUMN office_name VARCHAR;
            END IF;
        END $$;
    """))

    conn.execute(text("""
        DO $$
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                           WHERE table_name = 'shame_restaurants' AND column_name = 'google_id') THEN
                ALTER TABLE shame_restaurants ADD COLUMN google_id VARCHAR;
            END IF;
        END $$;
    """))

    conn.execute(text("UPDATE restaurants SET office_name = 'Gbg-office' WHERE office_name IS NULL;"))
    conn.execute(text("UPDATE shame_restaurants SET office_name = 'Gbg-office' WHERE office_name IS NULL;"))

    # De-duplicate vote tables before adding unique indexes.
    conn.execute(text("""
        DELETE FROM votes v
        USING votes v2
        WHERE v.restaurant_id = v2.restaurant_id
          AND v.client_uuid = v2.client_uuid
          AND v.id > v2.id;
    """))
    conn.execute(text("""
        DELETE FROM comment_votes cv
        USING comment_votes cv2
        WHERE cv.comment_id = cv2.comment_id
          AND cv.client_uuid = cv2.client_uuid
          AND cv.id > cv2.id;
    """))

    conn.execute(text("""
        CREATE UNIQUE INDEX IF NOT EXISTS uq_votes_restaurant_client
        ON votes (restaurant_id, client_uuid);
    """))
    conn.execute(text("""
        CREATE UNIQUE INDEX IF NOT EXISTS uq_comment_votes_comment_client
        ON comment_votes (comment_id, client_uuid);
    """))
    conn.commit()
