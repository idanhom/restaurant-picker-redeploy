// frontend/src/RestaurantPicker.js
import {
  useState,
  useEffect,
  useCallback,
  useMemo,
} from "react";
import AutocompleteInput from "./AutocompleteInput";

const API_BASE = process.env.REACT_APP_API_BASE || '';

/* ------------------------------------------------------------------ */
/* Helpers                                                            */
/* ------------------------------------------------------------------ */

/** Stable client UUID kept in localStorage (vote dedup) */
const useClientId = () => {
  return useMemo(() => {
    let id = localStorage.getItem("client_id");
    if (!id) {
      id = crypto.randomUUID();
      localStorage.setItem("client_id", id);
    }
    return id;
  }, []);
};

/** Reverse-geocode coordinates → friendly “around …” label */
async function reverseGeocode({ lat, lng }) {
  const url = `https://nominatim.openstreetmap.org/reverse?lat=${lat}&lon=${lng}&format=json`;
  try {
    const res = await fetch(url, {
      headers: { "User-Agent": "restaurant-picker-demo/1.0" },
    });
    if (!res.ok) throw new Error();
    const { address = {}, display_name } = await res.json();
    const label =
      address.suburb ??
      address.neighbourhood ??
      address.city_district ??
      address.village ??
      address.town ??
      address.city ??
      display_name?.split(",")[0]?.trim() ??
      `${lat.toFixed(3)}, ${lng.toFixed(3)}`;
    return `around ${label}`;
  } catch {
    return `around ${lat.toFixed(3)}, ${lng.toFixed(3)}`;
  }
}

/* ------------------------------------------------------------------ */
/* Component                                                          */
/* ------------------------------------------------------------------ */
export default function RestaurantPicker() {
  const clientId = useClientId();
  const [adminToken, setAdminToken] = useState(
    localStorage.getItem("admin_token") || ""
  );

  const officeNames = ["Gbg", "Jkpg", "Sthlm"];

  /* ---- Location & distance ---- */
  const [offices, setOffices] = useState([]);
  const [selectedOffice, setSelectedOffice] = useState("");
  const [userCoords, setUserCoords] = useState(null);
  const [currentBase, setCurrentBase] = useState("");
  const [isUsingGeo, setIsUsingGeo] = useState(false);
  const [maxDistance, setMaxDistance] = useState(10); // km slider

  /* ---- Data ---- */
  const [suggestedRestaurants, setSuggestedRestaurants] = useState([]);
  const [selectedRestaurantToSubmit, setSelectedRestaurantToSubmit] =
    useState(null);
  const [selectedRestaurant, setSelectedRestaurant] = useState(null);
  const [cuisineTags, setCuisineTags] = useState([]);
  const [shamedRestaurants, setShamedRestaurants] = useState([]);
  const [restaurantCounts, setRestaurantCounts] = useState(officeNames.map(name => ({office: name, count: 0})));
  const [noRecommendationsMessage, setNoRecommendationsMessage] = useState(null);

  /* ---- UI state ---- */
  const [loadingAction, setLoadingAction] = useState("");
  const [messages, setMessages] = useState([]);
  const [votedIds, setVotedIds] = useState([]);

  /* ---------------------------------------------------------------- */
  /* Messaging                                                        */
  /* ---------------------------------------------------------------- */
  const addMessage = (text, type = "info") => {
    setMessages((prev) => [...prev, { text, type }]);
    setTimeout(() => setMessages((prev) => prev.slice(1)), 3000);
  };

  const truncate = (tag) => tag.split(" ").slice(0, 3).join(" ");

  /* ---------------------------------------------------------------- */
  /* Data fetch                                                       */
  /* ---------------------------------------------------------------- */
  const fetchSuggestions = useCallback(async () => {
    const params = new URLSearchParams({office_name: selectedOffice});
    if (userCoords) {
      params.append("user_lat", userCoords.lat);
      params.append("user_lng", userCoords.lng);
    }
    const r = await fetch(`${API_BASE}/api/suggestions?${params.toString()}`);
    if (!r.ok) {
      let detail = `HTTP ${r.status}`;
      try {
        const errJson = await r.json();
        detail = errJson.detail || detail;
      } catch {}
      addMessage(`Error loading suggestions: ${detail}`, "error");
      return;
    }
    setSuggestedRestaurants(await r.json());
  }, [selectedOffice, userCoords]);

  const fetchCuisineTags = useCallback(async () => {
    const r = await fetch(`${API_BASE}/api/cuisine-tags?office_name=${selectedOffice}`);
    if (!r.ok) {
      let detail = `HTTP ${r.status}`;
      try {
        const errJson = await r.json();
        detail = errJson.detail || detail;
      } catch {}
      addMessage(`Error loading cuisine tags: ${detail}`, "error");
      return;
    }
    setCuisineTags(await r.json());
  }, [selectedOffice]);

  const fetchShamed = useCallback(async () => {
    const r = await fetch(`${API_BASE}/api/wall-of-shame?office_name=${selectedOffice}`);
    if (!r.ok) {
      let detail = `HTTP ${r.status}`;
      try {
        const errJson = await r.json();
        detail = errJson.detail || detail;
      } catch {}
      addMessage(`Error loading wall of shame: ${detail}`, "error");
      return;
    }
    setShamedRestaurants(await r.json());
  }, [selectedOffice]);

  const fetchRestaurantCounts = useCallback(async () => {
    const r = await fetch(`${API_BASE}/api/restaurant-counts`);
    if (!r.ok) {
      let detail = `HTTP ${r.status}`;
      try {
        const errJson = await r.json();
        detail = errJson.detail || detail;
      } catch {}
      addMessage(`Error loading restaurant counts: ${detail}`, "error");
      return;
    }
    const data = await r.json();
    const updatedCounts = officeNames.map(name => {
      const found = data.find(d => d.office === `${name}-office`);
      return {office: name, count: found ? found.count : 0};
    });
    setRestaurantCounts(updatedCounts);
  }, []);

  useEffect(() => {
    fetch(`${API_BASE}/api/offices`)
      .then((r) => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        return r.json();
      })
      .then(setOffices)
      .catch((e) => addMessage(`Error loading offices: ${e.message}`, "error"));
  }, []);

  useEffect(() => {
    if (offices.length > 0 && !selectedOffice) {
      const defaultOffice = offices[0];
      setSelectedOffice(defaultOffice.name);
      setUserCoords({ lat: defaultOffice.lat, lng: defaultOffice.lng });
      setCurrentBase(defaultOffice.name);
    }
  }, [offices, selectedOffice]);

  useEffect(() => {
    if (selectedOffice) {
      fetchSuggestions();
      fetchCuisineTags();
      fetchShamed();
      fetchRestaurantCounts();
    }
  }, [selectedOffice, fetchSuggestions, fetchCuisineTags, fetchShamed, fetchRestaurantCounts]);

  /* ---------------------------------------------------------------- */
  /* Geolocation                                                      */
  /* ---------------------------------------------------------------- */
  const enableGeolocation = () => {
    if (!navigator.geolocation) {
      return addMessage("Geolocation not supported", "error");
    }
    navigator.geolocation.getCurrentPosition(
      async ({ coords }) => {
        const { latitude: lat, longitude: lng } = coords;
        setUserCoords({ lat, lng });
        const address = await reverseGeocode({ lat, lng });
        setCurrentBase(address);
        setIsUsingGeo(true);
        addMessage("Using your device location", "success");
      },
      () => addMessage("Location permission denied", "error")
    );
  };

  /* ---------------------------------------------------------------- */
  /* Office selection                                                 */
  /* ---------------------------------------------------------------- */
  const handleOfficeChange = (name) => {
    const office = offices.find((o) => o.name === name);
    if (office) {
      setSelectedOffice(name);
      setUserCoords({ lat: office.lat, lng: office.lng });
      setCurrentBase(name);
      setIsUsingGeo(false);
    }
  };

  /* ---------------------------------------------------------------- */
  /* Actions                                                          */
  /* ---------------------------------------------------------------- */
  const submitRestaurant = async () => {
    if (!selectedRestaurantToSubmit)
      return addMessage("Select a restaurant first", "warning");

    setLoadingAction("submit");
    try {
      const payload = {
        google_id: selectedRestaurantToSubmit.google_id,
        office_name: selectedOffice,
      };
      if (userCoords) {
        payload.user_lat = userCoords.lat;
        payload.user_lng = userCoords.lng;
      }
      const r = await fetch(`${API_BASE}/api/submit-restaurant`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      let resJson;
      try {
        resJson = await r.json();
      } catch {
        resJson = {};
      }
      if (!r.ok) {
        addMessage(resJson.detail || "Submission failed", "error");
        return;
      }
      addMessage(resJson.message || "Submitted successfully", resJson.success ? "success" : "error");
      setSelectedRestaurantToSubmit(null);
      fetchSuggestions();
      fetchCuisineTags();
      fetchShamed();
      fetchRestaurantCounts();
    } catch (e) {
      addMessage(`Submission failed: ${e.message}`, "error");
    } finally {
      setLoadingAction("");
    }
  };

  const voteRestaurant = async (id, up = true) => {
    if (votedIds.includes(id) && !adminToken) return;

    setLoadingAction(`vote-${id}`);
    try {
      const headers = { 
        "Content-Type": "application/json",
        "X-Client-ID": clientId 
      };
      if (adminToken) headers["X-Admin-Token"] = adminToken;

      const r = await fetch(`${API_BASE}/api/vote-restaurant/${id}`, {
        method: "POST",
        headers,
        body: JSON.stringify({ up }),
      });
      let resJson;
      try {
        resJson = await r.json();
      } catch {
        resJson = {};
      }
      if (!r.ok) {
        addMessage(resJson.detail || "Vote failed", "error");
        return;
      }
      addMessage(resJson.message || "Voted successfully", resJson.success ? "success" : "error");
      setVotedIds((p) => [...p, id]);
      fetchSuggestions();
      fetchCuisineTags();
      fetchShamed();
      fetchRestaurantCounts();
    } catch (e) {
      addMessage(`Vote failed: ${e.message}`, "error");
    } finally {
      setLoadingAction("");
    }
  };

  const randomizeRestaurant = async () => {
    const payload = { 
      max_distance_km: maxDistance,
      office_name: selectedOffice 
    };
    if (userCoords) payload.userLocation = userCoords;

    setLoadingAction("randomize");
    setNoRecommendationsMessage(null);
    setSelectedRestaurant(null);
    try {
      const r = await fetch(`${API_BASE}/api/random-restaurant`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      if (r.status === 404) {
        let detail = "";
        try {
          const errJson = await r.json();
          detail = errJson.detail || "";
        } catch {}
        let locationDesc;
        if (isUsingGeo) {
          locationDesc = `your location of ${currentBase}`;
        } else {
          const shortName = selectedOffice.replace("-office", "");
          locationDesc = `the ${shortName} office area`;
        }
        setNoRecommendationsMessage(detail || `There are no recommendations within ${locationDesc}`);
        return;
      }
      if (!r.ok) {
        let detail = "Search failed";
        try {
          const errJson = await r.json();
          detail = errJson.detail || detail;
        } catch {}
        addMessage(detail, "error");
        return;
      }
      setSelectedRestaurant(await r.json());
      fetchCuisineTags();
      fetchShamed();
    } catch (e) {
      addMessage(`Search failed: ${e.message}`, "error");
    } finally {
      setLoadingAction("");
    }
  };

  const removeShameRestaurant = async (id) => {
    if (!adminToken) return;

    setLoadingAction(`remove-shame-${id}`);
    try {
      const headers = { "X-Admin-Token": adminToken };
      const r = await fetch(`${API_BASE}/api/shame-restaurant/${id}`, {
        method: "DELETE",
        headers,
      });
      let resJson;
      try {
        resJson = await r.json();
      } catch {
        resJson = {};
      }
      if (!r.ok) {
        addMessage(resJson.detail || "Removal failed", "error");
        return;
      }
      addMessage(resJson.message || "Removed successfully", resJson.success ? "success" : "error");
      fetchShamed();
    } catch (e) {
      addMessage(`Removal failed: ${e.message}`, "error");
    } finally {
      setLoadingAction("");
    }
  };

  /* ---------------------------------------------------------------- */
  /* Admin login / logout                                             */
  /* ---------------------------------------------------------------- */
  const handleAdminLogin = () => {
    const tok = prompt("Enter admin token");
    if (tok) {
      localStorage.setItem("admin_token", tok);
      setAdminToken(tok);
      addMessage("Admin mode enabled", "success");
    }
  };

  const handleAdminLogout = () => {
    localStorage.removeItem("admin_token");
    setAdminToken("");
    addMessage("Admin mode disabled", "info");
  };

  /* ---------------------------------------------------------------- */
  /* Render                                                           */
  /* ---------------------------------------------------------------- */
  return (
    <div style={{ display: "flex", maxWidth: 900, margin: "2rem auto" }}>
      {/* Dropdown for offices */}
      <div style={{ position: "fixed", top: 10, left: "calc(50% - 20px)", transform: "translateX(-50%)" }}>
        <select
          value={selectedOffice}
          onChange={(e) => handleOfficeChange(e.target.value)}
        >
          {offices.map((office) => (
            <option key={office.name} value={office.name}>
              {office.address}
            </option>
          ))}
        </select>
      </div>

      {/* Admin button */}
      <div style={{ position: "fixed", top: 10, right: 10 }}>
        {adminToken ? (
          <button onClick={handleAdminLogout}>Admin Logout</button>
        ) : (
          <button onClick={handleAdminLogin}>Admin Login</button>
        )}
      </div>

      {/* MAIN COLUMN */}
      <main style={{ flex: 1, padding: "1rem", border: "1px solid #ccc" }}>
        <h1>Redeploy Restaurant Chooser</h1>

        {messages.map((m, i) => (
          <div
            key={i}
            style={{
              padding: ".5rem",
              margin: ".25rem 0",
              background:
                m.type === "error"
                  ? "#ffcdd2"
                  : m.type === "success"
                  ? "#c8e6c9"
                  : "#e3f2fd",
            }}
          >
            {m.text}
          </div>
        ))}

        {/* Submit ----------------------------------------------------- */}
        <section style={{ marginBottom: "2rem" }}>
          <h2>Enter a Restaurant</h2>

          {/* Autocomplete now uses userCoords for distance calc */}
          <AutocompleteInput
            onSelect={setSelectedRestaurantToSubmit}
            disabled={loadingAction === "submit"}
            userCoords={userCoords}
          />

          <button
            onClick={submitRestaurant}
            disabled={
              loadingAction === "submit" || !selectedRestaurantToSubmit
            }
            style={{ padding: ".5rem 1rem" }}
          >
            {loadingAction === "submit" ? "Submitting…" : "Submit Restaurant"}
          </button>
        </section>

        {/* Vote ------------------------------------------------------- */}
        <section style={{ marginBottom: "2rem" }}>
          <h2>Vote on Suggested Restaurants</h2>
          {suggestedRestaurants.length === 0 ? (
            <p>No suggestions currently available.</p>
          ) : (
            suggestedRestaurants.map((r) => {
              const net = r.up_votes - r.down_votes;
              const voting = loadingAction === `vote-${r.id}`;
              const already = votedIds.includes(r.id);
              const disabled = (!adminToken && already) || r.promoted || voting;
              const location = r.address ? r.address.split(',')[0].trim() : '';

              return (
                <div
                  key={r.id}
                  style={{
                    marginBottom: "1rem",
                    borderBottom: "1px solid #eee",
                    paddingBottom: ".5rem",
                  }}
                >
                  <p>
                    <strong>{r.name} at {location}</strong>
                    {r.promoted && (
                      <span style={{ marginLeft: 8, color: "green" }}>[Validated]</span>
                    )}
                  </p>
                  <p>Up: {r.up_votes} | Down: {r.down_votes} | Net: {net}</p>
                  {!r.promoted && (
                    <>
                      <button
                        onClick={() => voteRestaurant(r.id, true)}
                        disabled={disabled}
                        style={{ padding: ".25rem .75rem", marginRight: ".5rem" }}
                      >
                        {voting ? "Voting…" : already && !adminToken ? "Voted" : "Upvote"}
                      </button>
                      <button
                        onClick={() => voteRestaurant(r.id, false)}
                        disabled={disabled}
                        style={{ padding: ".25rem .75rem", background: "#ffdddd" }}
                      >
                        {voting ? "Voting…" : already && !adminToken ? "Voted" : "Downvote"}
                      </button>
                    </>
                  )}
                </div>
              );
            })
          )}
        </section>

        {/* Randomize --------------------------------------------------- */}
        <section style={{ marginBottom: "2rem" }}>
          <h2>Find a Restaurant</h2>

          <label style={{ display: "block", marginBottom: ".5rem" }}>
            Max distance: {maxDistance} km
            <input
              type="range"
              min="1"
              max="25"
              value={maxDistance}
              onChange={(e) => setMaxDistance(Number(e.target.value))}
              style={{ width: "80%" }}
            />
          </label>

          <p style={{ margin: 0, fontSize: ".9rem", color: "#555" }}>
            Current base:&nbsp;
            {isUsingGeo ? currentBase : currentBase}
            <button
              type="button"
              onClick={enableGeolocation}
              style={{ marginLeft: 8, padding: ".25rem .5rem", fontSize: ".8rem" }}
            >
              Use my geo-location
            </button>
          </p>

          <button
            onClick={randomizeRestaurant}
            disabled={loadingAction === "randomize"}
            style={{ padding: ".5rem 1rem", marginTop: ".5rem" }}
          >
            {loadingAction === "randomize" ? "Searching…" : "Randomize Restaurant"}
          </button>
        </section>

        {/* Recommended ---------------------------------------------- */}
        {noRecommendationsMessage && (
          <p style={{ color: "#888" }}>{noRecommendationsMessage}</p>
        )}
        {selectedRestaurant && (
          <section style={{ borderTop: "1px solid #eee", paddingTop: "1rem" }}>
            <h2>Recommended Restaurant</h2>
            <p>
              <strong>Name:</strong> {selectedRestaurant.name} at {selectedRestaurant.address ? selectedRestaurant.address.split(',')[0].trim() : ''}
            </p>
            <p>
              <strong>Type:</strong> {selectedRestaurant.type}{" "}
              <em>(AI classification)</em>
            </p>
            <p>
              <strong>Distance:</strong> {selectedRestaurant.distance} km
            </p>
            <a
              href={`https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(
                selectedRestaurant.address
              )}`}
              target="_blank"
              rel="noopener noreferrer"
              style={{ color: "#007bff" }}
            >
              View on Google Maps
            </a>
          </section>
        )}
      </main>

      {/* Sidebar */}
      <aside style={{ width: 200, marginLeft: "1rem" }}>
        <h3 style={{ marginTop: 0 }}>Good Restaurants</h3>
        <ul style={{ listStyle: "none", padding: 0 }}>
          {restaurantCounts.map((rc, i) => (
            <li key={i} style={{ padding: ".25rem 0" }}>
              {rc.office}: {rc.count}
            </li>
          ))}
        </ul>

        <h3>Restaurant Types</h3>
        <ul style={{ listStyle: "none", padding: 0 }}>
          {cuisineTags.map((t, i) => (
            <li key={i} style={{ padding: ".25rem 0" }}>
              {truncate(t.cuisine)} ({t.count})
            </li>
          ))}
        </ul>

      <h3>Wall of Shame</h3>
      <ul style={{ listStyle: "none", padding: 0 }}>
        {shamedRestaurants.map((r) => (
          <li key={r.id} style={{ padding: ".25rem 0", display: "flex", alignItems: "center" }}>
            <a
              href={`https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(`${r.name} ${r.address || ''}`)}`}
              target="_blank"
              rel="noopener noreferrer"
              style={{ color: "#007bff", textDecoration: "none", flex: 1 }}
            >
              {r.name}
            </a>
            {r.address && ` (${r.address})`}
            {adminToken && (
              <button
                onClick={() => removeShameRestaurant(r.id)}
                disabled={loadingAction === `remove-shame-${r.id}`}
                style={{ marginLeft: "auto", padding: ".25rem .5rem", background: "#ffdddd" }}
              >
                {loadingAction === `remove-shame-${r.id}` ? "Removing..." : "-"}
              </button>
            )}
          </li>
        ))}
      </ul>
      </aside>
    </div>
  );
}