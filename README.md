# create app myself and test for a while to ensure it works well. then open to public?
# https://console.cloud.google.com/billing/0147C5-9F78FB-C1A42B/reports;timeRange=YEAR_TO_DATE;grouping=GROUP_BY_SKU;projects=gen-lang-client-0700994690?project=gen-lang-client-0700994690

# also set restrictions to my endpoint??
# https://console.cloud.google.com/apis/credentials/key/1ca2b0d8-aad0-4b31-adc1-a5f47834b6b9?project=gen-lang-client-0700994690

### Project Overview: Restaurant Discovery and Voting Application *(July 2025 edition)*

#### High-Level Abstraction

This web application lets Gothenburg residents **search, submit, vote on, and randomly pick restaurants** while keeping all data local to a \~50 km radius around the city centre. Users type a name, the backend validates and enriches it through Google Maps and Azure OpenAI, then stores every submission immediately. Community voting (net +3 up-votes) promotes a place from “limbo” to the main list, making it eligible for the random-picker. A React frontend handles all interactions; a FastAPI backend manages enrichment, storage, and rate-limited access to third-party APIs. Caching with Redis minimises duplicate external calls, and everything runs in Docker for painless local dev and cloud deployment.

The goal: **collaborative, real-time lunch decisions with zero redundant API hits** and full traceability of every suggestion, even those that never get traction.

---

#### Important Details

The system is split into a React frontend, a FastAPI backend, a PostgreSQL 17 database, and several external services for enrichment.

* **Frontend (User Interface)**
  Built with React 18. The main component (`RestaurantPicker.js`) lets users

  * search live via the new **`/api/search-restaurants`** endpoint,
  * submit a selected result,
  * up-vote suggestions, and
  * request a random promoted restaurant.
    Toast-style messages show success, warnings, or errors. Votes are tracked in-session to avoid double-voting and can be migrated to real user accounts later. The UI is 100 % client-side and can be hosted anywhere (e.g. Azure Static Web Apps).

* **Backend (API Layer)**
  Written in FastAPI 0.116 and documented automatically at `/docs`. Key routes:

  | Method   | Path                              | Purpose                                                     |
  | -------- | --------------------------------- | ----------------------------------------------------------- |
  | **GET**  | `/api/search-restaurants?query=…` | Google Text Search + Distance Matrix (5 nearest hits).      |
  | **POST** | `/api/submit-restaurant`          | Persist selection, add first up-vote, classify cuisine.     |
  | **POST** | `/api/vote-restaurant/{id}`       | Increment up-votes; promotion triggers at +3.               |
  | **GET**  | `/api/suggestions`                | All non-promoted entries with vote counts.                  |
  | **POST** | `/api/random-restaurant`          | Return a random promoted spot (name, cuisine, km, address). |
  | **GET**  | `/api/top-cuisines`               | Three most frequent cuisine tags.                           |
  | **GET**  | `/api/cuisine-tags`               | Full histogram for sidebar tag cloud.                       |

  *Caching* (via Redis, default **TTL 3600 s**) guards repeat Google/OpenAI calls.
  *Rate limiting* (SlowAPI, default **5 requests/min/IP**) protects quotas.
  Errors follow standard HTTP status codes with JSON details.

* **Database** (PostgreSQL 17)
  Table **`restaurants`** stores: `google_id`, `name`, `address`, `lat`, `lng`, `distance_from_office (km)`, `cuisine`, raw Google JSON, `up_votes`, `down_votes`, `promoted`, and timestamps. SQLAlchemy 2.0 handles ORM mapping; tables auto-create at startup in dev.

* **External APIs & Enrichment**

  * **Google Places API (v1)** – text search restricted to a 50 km bias circle centred on the office.
  * **Google Distance Matrix** – batched driving-distance lookup for each candidate (km).
  * **Azure OpenAI GPT-4.1-nano** – single-shot prompt returns a 1-3-word cuisine label.
    All calls first check Redis; failures fall back gracefully (e.g., cuisine `"Unknown"`).

* **Containerisation & Deployment**
  *Docker Compose* spins up PostgreSQL, Redis, and the API locally with one command.
  The API image (Python 3.12-slim) is built by the included **Dockerfile** and is ready for **Azure Container Apps**; push to Azure Container Registry and deploy with external ingress. Environment variables come from `.env` (never commit real keys).

* **Workflow Overview**

  1. **Search** – Autocomplete hits `/api/search-restaurants`; results show name, address, km.
  2. **Submit** – Selected item -> `/api/submit-restaurant`; stored + first up-vote, cuisine tagged.
  3. **Vote** – Users up-vote via `/api/vote-restaurant/{id}`; at net +3 the row is flagged `promoted=true`.
  4. **Random Pick** – `/api/random-restaurant` returns a random promoted record.
     All steps are cached and rate-limited.

---

#### Technologies Used

| Tier             | Stack                                                      | Reason                                    |
| ---------------- | ---------------------------------------------------------- | ----------------------------------------- |
| **Backend**      | FastAPI + Uvicorn                                          | Async performance, auto OpenAPI docs.     |
| **Database**     | PostgreSQL 17 + SQLAlchemy 2.0                             | Strong relational model, ORM convenience. |
| **Cache / Rate** | Redis 7 (TTL) / SlowAPI                                    | API-quota safety & latency savings.       |
| **Enrichment**   | Google Places & Distance Matrix, Azure OpenAI GPT-4.1-nano | Accurate local data, low-cost AI tagging. |
| **Containers**   | Docker Compose / Azure Container Apps                      | One-command dev, effortless scaling.      |
| **Frontend**     | React 18 (CRA)                                             | Fast client-side UX, easy hosting.        |

---

This 2025 iteration delivers a **community-driven, AI-augmented restaurant platform** that stays fast, frugal, and focused on Gothenburg cuisine from the very first keystroke.
