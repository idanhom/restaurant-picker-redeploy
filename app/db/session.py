import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Prioritize Azure-injected vars, fallback to local
db_user = os.getenv('AZURE_POSTGRESQL_USERNAME', 'user')
db_pass = os.getenv('AZURE_POSTGRESQL_PASSWORD', 'pass')
db_host = os.getenv('AZURE_POSTGRESQL_HOST', 'db')
db_port = os.getenv('AZURE_POSTGRESQL_PORT', '5432')
db_name = os.getenv('AZURE_POSTGRESQL_DATABASE', 'appdb')

# Use full connection string if available, else construct
DATABASE_URL = os.getenv('AZURE_POSTGRESQL_CONNECTIONSTRING') or f"postgresql://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}?sslmode=require"

engine = create_engine(DATABASE_URL, pool_size=5, max_overflow=0, echo=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()