# Redeploy Restaurant Picker

A community-driven restaurant discovery app for Redeploy offices. Search, submit, vote on, and randomly pick lunch spots — all within a ~50 km radius of your office.

**Live:** [Redeploy Restaurant Picker](https://orange-dune-0d7cdfc03.2.azurestaticapps.net) 
## What It Does

- **Search** — Type a restaurant name, get live suggestions from Google Places filtered by distance
- **Submit** — Add new restaurants; AI auto-classifies the cuisine type
- **Vote** — Upvote or downvote suggestions; +3 net votes promotes a restaurant to the main pool
- **Randomize** — Pick a random promoted restaurant within your chosen distance range
- **Wall of Shame** — Restaurants with too many downvotes get moved here

Supports three office locations: Gothenburg, Jönköping, and Stockholm.

## Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   React     │────▶│   FastAPI   │────▶│ PostgreSQL  │
│  Frontend   │     │   Backend   │     │     17      │
└─────────────┘     └──────┬──────┘     └─────────────┘
                          │
              ┌───────────┼───────────┐
              ▼           ▼           ▼
         ┌────────┐ ┌──────────┐ ┌─────────┐
         │ Redis  │ │  Google  │ │  Azure  │
         │ Cache  │ │  Places  │ │ OpenAI  │
         └────────┘ └──────────┘ └─────────┘
```

| Component | Tech | Purpose |
|-----------|------|---------|
| Frontend | React 18 | SPA hosted on Azure Static Web Apps |
| Backend | FastAPI + Uvicorn | REST API with auto-generated docs at `/docs` |
| Database | PostgreSQL 17 | Stores restaurants, votes, comments |
| Cache | Redis 7 | Caches API responses (TTL 1 hour) |
| Enrichment | Google Places API | Restaurant search and distance calculation |
| AI | Azure OpenAI | Cuisine classification |

## Deployment

This project uses **push-to-deploy** via GitHub Actions.

### How It Works

- **Frontend:** Push to `main` → automatically deploys to Azure Static Web Apps
- **Backend:** Changes to `app/`, `requirements.txt`, or `Dockerfile` → rebuilds container and deploys to Azure Container Apps

Infrastructure is managed with Terraform in the `terraform/` directory.

### Required Secrets (GitHub Actions)

The following secrets must be configured in the GitHub repository:

- `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID` — Azure OIDC auth
- `AZURE_STATIC_WEB_APPS_API_TOKEN_ORANGE_DUNE_0D7CDFC03` — Static Web Apps deployment

Backend environment variables are configured in Terraform (`terraform/container_app.tf`).

## API Overview

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/offices` | List available office locations |
| GET | `/api/search-restaurants?query=...` | Search restaurants near office |
| POST | `/api/submit-restaurant` | Submit a new restaurant |
| POST | `/api/vote-restaurant/{id}` | Vote on a suggestion |
| GET | `/api/suggestions` | List non-promoted restaurants |
| POST | `/api/random-restaurant` | Get a random promoted restaurant |
| GET | `/api/cuisine-tags` | Get cuisine type counts |
| GET | `/api/wall-of-shame` | List shamed restaurants |

Full API documentation available at `/docs` on the deployed backend.

## Contributing

### Pull Request Workflow

1. Fork the repository
2. Create a feature branch: `git switch -c feature/your-feature`
3. Make your changes
4. Push and open a PR against `main`
5. Once merged, changes deploy automatically

### Areas for Contribution

- **UI/UX improvements** — The frontend could use polish
- **New features** — Filtering by cuisine, user accounts, favorites
- **Bug fixes** — Check the issues tab
- **Documentation** — Always welcome

## Project Structure

```
├── app/                    # FastAPI backend
│   ├── api/endpoints.py    # All API routes
│   ├── crud.py             # Database operations
│   ├── models.py           # SQLAlchemy models
│   └── schemas.py          # Pydantic schemas
├── frontend/               # React frontend
│   └── src/
│       ├── RestaurantPicker.js   # Main component
│       ├── AutocompleteInput.js  # Search input
│       ├── RestaurantModal.js    # Restaurant details
│       └── AdminConsole.js       # Admin panel
├── terraform/              # Infrastructure as code
├── .github/workflows/      # CI/CD pipelines
└── Dockerfile              # Backend container
```
