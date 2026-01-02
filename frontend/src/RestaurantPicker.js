// frontend/src/RestaurantPicker.js
import {
  useState,
  useEffect,
  useCallback,
  useMemo,
} from "react";
import AutocompleteInput from "./AutocompleteInput";
import AdminConsole from "./AdminConsole";
import RestaurantModal from "./RestaurantModal";

const API_BASE = process.env.REACT_APP_API_BASE || '';

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

async function reverseGeocode(coords) {
  var lat = coords.lat;
  var lng = coords.lng;
  var url = "https://nominatim.openstreetmap.org/reverse?lat=" + lat + "&lon=" + lng + "&format=json";
  try {
    var res = await fetch(url, {
      headers: { "User-Agent": "restaurant-picker-demo/1.0" },
    });
    if (!res.ok) throw new Error();
    var data = await res.json();
    var address = data.address || {};
    var label = address.suburb || address.neighbourhood || address.city_district || address.village || address.town || address.city || lat.toFixed(3) + ", " + lng.toFixed(3);
    return "around " + label;
  } catch (e) {
    return "around " + lat.toFixed(3) + ", " + lng.toFixed(3);
  }
}

// Distance presets in km
var DISTANCE_PRESETS = [
  { label: "300m", value: 0.3 },
  { label: "500m", value: 0.5 },
  { label: "1km", value: 1 },
  { label: "2km", value: 2 },
  { label: "5km", value: 5 }
];

// Range "from" presets (no 0 - use Radius mode for that)
var RANGE_FROM_PRESETS = [
  { label: "300m", value: 0.3 },
  { label: "500m", value: 0.5 },
  { label: "1km", value: 1 },
  { label: "2km", value: 2 },
  { label: "3km", value: 3 }
];

// Parse distance input - REQUIRES unit (m or km)
function parseDistanceInput(input) {
  var trimmed = input.trim().toLowerCase();
  var val;
  
  if (trimmed.endsWith("km")) {
    val = parseFloat(trimmed.replace("km", ""));
  } else if (trimmed.endsWith("m")) {
    val = parseFloat(trimmed.replace("m", "")) / 1000;
  } else {
    // No unit provided - reject
    return null;
  }
  
  if (isNaN(val) || val < 0) {
    return null;
  }
  return val;
}

// Format distance for display
function formatDistance(km) {
  if (km === 0) {
    return "0m";
  }
  if (km < 1) {
    return Math.round(km * 1000) + "m";
  }
  return km + "km";
}

export default function RestaurantPicker() {
  const clientId = useClientId();
  const [adminToken, setAdminToken] = useState(
    localStorage.getItem("admin_token") || ""
  );
  const [showAdminConsole, setShowAdminConsole] = useState(false);
  const [titleClicks, setTitleClicks] = useState(0);

  const officeNames = ["Gbg", "Jkpg", "Sthlm"];

  const [offices, setOffices] = useState([]);
  const [selectedOffice, setSelectedOffice] = useState("");
  const [userCoords, setUserCoords] = useState(null);
  const [currentBase, setCurrentBase] = useState("");
  const [isUsingGeo, setIsUsingGeo] = useState(false);
  
  // Distance mode: "radius" or "range"
  const [distanceMode, setDistanceMode] = useState("radius");
  
  // Radius mode state
  const [maxDistance, setMaxDistance] = useState(1);
  const [customDistance, setCustomDistance] = useState("");
  
  // Range mode state
  const [minDistance, setMinDistance] = useState(0.3);
  const [maxRangeDistance, setMaxRangeDistance] = useState(0.5);
  const [customMinDistance, setCustomMinDistance] = useState("");
  const [customMaxDistance, setCustomMaxDistance] = useState("");

  const [suggestedRestaurants, setSuggestedRestaurants] = useState([]);
  const [selectedRestaurantToSubmit, setSelectedRestaurantToSubmit] = useState(null);
  const [selectedRestaurant, setSelectedRestaurant] = useState(null);
  const [cuisineTags, setCuisineTags] = useState([]);
  const [shamedRestaurants, setShamedRestaurants] = useState([]);
  const [restaurantCounts, setRestaurantCounts] = useState(officeNames.map(function(name) { return {office: name, count: 0}; }));
  const [noRecommendationsMessage, setNoRecommendationsMessage] = useState(null);

  const [expandedCuisine, setExpandedCuisine] = useState(null);
  const [cuisineRestaurants, setCuisineRestaurants] = useState([]);
  const [selectedRestaurantForModal, setSelectedRestaurantForModal] = useState(null);
  const [loadingCuisine, setLoadingCuisine] = useState(false);

  const [loadingAction, setLoadingAction] = useState("");
  const [messages, setMessages] = useState([]);
  const [votedIds, setVotedIds] = useState([]);

  const addMessage = function(text, type) {
    if (!type) type = "info";
    setMessages(function(prev) { return prev.concat([{ text: text, type: type }]); });
    setTimeout(function() { setMessages(function(prev) { return prev.slice(1); }); }, 3000);
  };

  const truncate = function(tag) { return tag.split(" ").slice(0, 3).join(" "); };

  const fetchSuggestions = useCallback(async function() {
    var params = new URLSearchParams({office_name: selectedOffice});
    if (userCoords) {
      params.append("user_lat", userCoords.lat);
      params.append("user_lng", userCoords.lng);
    }
    var r = await fetch(API_BASE + "/api/suggestions?" + params.toString());
    if (!r.ok) {
      var detail = "HTTP " + r.status;
      try {
        var errJson = await r.json();
        detail = errJson.detail || detail;
      } catch (e) {}
      addMessage("Error loading suggestions: " + detail, "error");
      return;
    }
    setSuggestedRestaurants(await r.json());
  }, [selectedOffice, userCoords]);

  const fetchCuisineTags = useCallback(async function() {
    var r = await fetch(API_BASE + "/api/cuisine-tags?office_name=" + selectedOffice);
    if (!r.ok) {
      var detail = "HTTP " + r.status;
      try {
        var errJson = await r.json();
        detail = errJson.detail || detail;
      } catch (e) {}
      addMessage("Error loading cuisine tags: " + detail, "error");
      return;
    }
    setCuisineTags(await r.json());
  }, [selectedOffice]);

  const fetchShamed = useCallback(async function() {
    var r = await fetch(API_BASE + "/api/wall-of-shame?office_name=" + selectedOffice);
    if (!r.ok) {
      var detail = "HTTP " + r.status;
      try {
        var errJson = await r.json();
        detail = errJson.detail || detail;
      } catch (e) {}
      addMessage("Error loading wall of shame: " + detail, "error");
      return;
    }
    setShamedRestaurants(await r.json());
  }, [selectedOffice]);

  const fetchRestaurantCounts = useCallback(async function() {
    var r = await fetch(API_BASE + "/api/restaurant-counts");
    if (!r.ok) {
      var detail = "HTTP " + r.status;
      try {
        var errJson = await r.json();
        detail = errJson.detail || detail;
      } catch (e) {}
      addMessage("Error loading restaurant counts: " + detail, "error");
      return;
    }
    var data = await r.json();
    var updatedCounts = officeNames.map(function(name) {
      var found = data.find(function(d) { return d.office === name + "-office"; });
      return {office: name, count: found ? found.count : 0};
    });
    setRestaurantCounts(updatedCounts);
  }, []);

  const fetchRestaurantsByCuisine = async function(cuisine) {
    if (expandedCuisine === cuisine) {
      setExpandedCuisine(null);
      setCuisineRestaurants([]);
      return;
    }
    setLoadingCuisine(true);
    try {
      var params = new URLSearchParams({ cuisine: cuisine, office_name: selectedOffice });
      var r = await fetch(API_BASE + "/api/restaurants/by-cuisine?" + params);
      if (r.ok) {
        setCuisineRestaurants(await r.json());
        setExpandedCuisine(cuisine);
      }
    } catch (e) {
      console.error(e);
    } finally {
      setLoadingCuisine(false);
    }
  };

  useEffect(function() {
    fetch(API_BASE + "/api/offices")
      .then(function(r) {
        if (!r.ok) throw new Error("HTTP " + r.status);
        return r.json();
      })
      .then(setOffices)
      .catch(function(e) { addMessage("Error loading offices: " + e.message, "error"); });
  }, []);

  useEffect(function() {
    if (offices.length > 0 && !selectedOffice) {
      var savedOffice = localStorage.getItem("selected_office");
      var office = offices.find(function(o) { return o.name === savedOffice; }) || offices[0];
      setSelectedOffice(office.name);
      setUserCoords({ lat: office.lat, lng: office.lng });
      setCurrentBase(office.name);
    }
  }, [offices, selectedOffice]);

  useEffect(function() {
    if (selectedOffice) {
      fetchSuggestions();
      fetchCuisineTags();
      fetchShamed();
      fetchRestaurantCounts();
      setExpandedCuisine(null);
      setCuisineRestaurants([]);
    }
  }, [selectedOffice, fetchSuggestions, fetchCuisineTags, fetchShamed, fetchRestaurantCounts]);

  const enableGeolocation = function() {
    if (!navigator.geolocation) {
      return addMessage("Geolocation not supported", "error");
    }
    navigator.geolocation.getCurrentPosition(
      async function(position) {
        var lat = position.coords.latitude;
        var lng = position.coords.longitude;
        setUserCoords({ lat: lat, lng: lng });
        var address = await reverseGeocode({ lat: lat, lng: lng });
        setCurrentBase(address);
        setIsUsingGeo(true);
        addMessage("Using your device location", "success");
      },
      function() { addMessage("Location permission denied", "error"); }
    );
  };

  const handleOfficeChange = function(name) {
    var office = offices.find(function(o) { return o.name === name; });
    if (office) {
      setSelectedOffice(name);
      setUserCoords({ lat: office.lat, lng: office.lng });
      setCurrentBase(name);
      setIsUsingGeo(false);
      localStorage.setItem("selected_office", name);
    }
  };

  const submitRestaurant = async function() {
    if (!selectedRestaurantToSubmit) {
      return addMessage("Select a restaurant first", "warning");
    }

    setLoadingAction("submit");
    try {
      var payload = {
        google_id: selectedRestaurantToSubmit.google_id,
        office_name: selectedOffice,
      };
      if (userCoords) {
        payload.user_lat = userCoords.lat;
        payload.user_lng = userCoords.lng;
      }
      var r = await fetch(API_BASE + "/api/submit-restaurant", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      var resJson;
      try {
        resJson = await r.json();
      } catch (e) {
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
      addMessage("Submission failed: " + e.message, "error");
    } finally {
      setLoadingAction("");
    }
  };

  const voteRestaurant = async function(id, up) {
    if (up === undefined) up = true;
    if (votedIds.includes(id) && !adminToken) return;

    setLoadingAction("vote-" + id);
    try {
      var headers = { 
        "Content-Type": "application/json",
        "X-Client-ID": clientId 
      };
      if (adminToken) headers["X-Admin-Token"] = adminToken;

      var r = await fetch(API_BASE + "/api/vote-restaurant/" + id, {
        method: "POST",
        headers: headers,
        body: JSON.stringify({ up: up }),
      });
      var resJson;
      try {
        resJson = await r.json();
      } catch (e) {
        resJson = {};
      }
      if (!r.ok) {
        addMessage(resJson.detail || "Vote failed", "error");
        return;
      }
      addMessage(resJson.message || "Voted successfully", resJson.success ? "success" : "error");
      setVotedIds(function(p) { return p.concat([id]); });
      fetchSuggestions();
      fetchCuisineTags();
      fetchShamed();
      fetchRestaurantCounts();
    } catch (e) {
      addMessage("Vote failed: " + e.message, "error");
    } finally {
      setLoadingAction("");
    }
  };

  const randomizeRestaurant = async function() {
    var payload = { 
      office_name: selectedOffice 
    };
    
    // Set distance parameters based on mode
    if (distanceMode === "radius") {
      payload.max_distance_km = maxDistance;
    } else {
      payload.min_distance_km = minDistance;
      payload.max_distance_km = maxRangeDistance;
    }
    
    if (userCoords) payload.userLocation = userCoords;

    setLoadingAction("randomize");
    setNoRecommendationsMessage(null);
    setSelectedRestaurant(null);
    try {
      var r = await fetch(API_BASE + "/api/random-restaurant", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      if (r.status === 404) {
        var detail = "";
        try {
          var errJson = await r.json();
          detail = errJson.detail || "";
        } catch (e) {}
        var locationDesc;
        if (isUsingGeo) {
          locationDesc = "your location of " + currentBase;
        } else {
          var shortName = selectedOffice.replace("-office", "");
          locationDesc = "the " + shortName + " office area";
        }
        setNoRecommendationsMessage(detail || "There are no recommendations within " + locationDesc);
        return;
      }
      if (!r.ok) {
        var detail2 = "Search failed";
        try {
          var errJson2 = await r.json();
          detail2 = errJson2.detail || detail2;
        } catch (e) {}
        addMessage(detail2, "error");
        return;
      }
      setSelectedRestaurant(await r.json());
      fetchCuisineTags();
      fetchShamed();
    } catch (e) {
      addMessage("Search failed: " + e.message, "error");
    } finally {
      setLoadingAction("");
    }
  };

  const removeShameRestaurant = async function(id) {
    if (!adminToken) return;

    setLoadingAction("remove-shame-" + id);
    try {
      var headers = { "X-Admin-Token": adminToken };
      var r = await fetch(API_BASE + "/api/shame-restaurant/" + id, {
        method: "DELETE",
        headers: headers,
      });
      var resJson;
      try {
        resJson = await r.json();
      } catch (e) {
        resJson = {};
      }
      if (!r.ok) {
        addMessage(resJson.detail || "Removal failed", "error");
        return;
      }
      addMessage(resJson.message || "Removed successfully", resJson.success ? "success" : "error");
      fetchShamed();
    } catch (e) {
      addMessage("Removal failed: " + e.message, "error");
    } finally {
      setLoadingAction("");
    }
  };

  const handleAdminLogin = function() {
    var tok = prompt("Enter admin token");
    if (tok) {
      localStorage.setItem("admin_token", tok);
      setAdminToken(tok);
      addMessage("Admin mode enabled", "success");
    }
  };

  const handleAdminLogout = function() {
    localStorage.removeItem("admin_token");
    setAdminToken("");
    addMessage("Admin mode disabled", "info");
  };

  function handleCloseAdminConsole() {
    setShowAdminConsole(false);
    fetchSuggestions();
    fetchCuisineTags();
    fetchShamed();
    fetchRestaurantCounts();
  }

  function handleOfficeSelect(e) {
    handleOfficeChange(e.target.value);
  }

  // Radius mode handlers
  function handleRadiusPreset(value) {
    setMaxDistance(value);
    setCustomDistance("");
  }

  function handleCustomDistanceChange(e) {
    setCustomDistance(e.target.value);
  }

  function handleCustomDistanceApply() {
    var val = parseDistanceInput(customDistance);
    if (val === null) {
      addMessage("Please enter a valid distance with unit (e.g. 500m or 1.5km)", "error");
      return;
    }
    setMaxDistance(val);
    setCustomDistance("");
  }

  function handleCustomDistanceKeyPress(e) {
    if (e.key === "Enter") {
      handleCustomDistanceApply();
    }
  }

  // Range mode handlers
  function handleMinPreset(value) {
    if (value >= maxRangeDistance) {
      addMessage("Min distance must be less than max distance", "error");
      return;
    }
    setMinDistance(value);
    setCustomMinDistance("");
  }

  function handleMaxRangePreset(value) {
    if (value <= minDistance) {
      addMessage("Max distance must be greater than min distance", "error");
      return;
    }
    setMaxRangeDistance(value);
    setCustomMaxDistance("");
  }

  function handleCustomMinChange(e) {
    setCustomMinDistance(e.target.value);
  }

  function handleCustomMaxChange(e) {
    setCustomMaxDistance(e.target.value);
  }

  function handleCustomRangeApply() {
    var minVal = customMinDistance ? parseDistanceInput(customMinDistance) : null;
    var maxVal = customMaxDistance ? parseDistanceInput(customMaxDistance) : null;
    
    // If neither field has input, nothing to apply
    if (minVal === null && maxVal === null) {
      addMessage("Please enter at least one distance with unit (e.g. 0m, 500m, or 1.5km)", "error");
      return;
    }
    
    // Use current values if custom field is empty
    var newMin = minVal !== null ? minVal : minDistance;
    var newMax = maxVal !== null ? maxVal : maxRangeDistance;
    
    if (newMin >= newMax) {
      addMessage("Min distance must be less than max distance", "error");
      return;
    }
    
    setMinDistance(newMin);
    setMaxRangeDistance(newMax);
    setCustomMinDistance("");
    setCustomMaxDistance("");
  }

  function handleCustomRangeKeyPress(e) {
    if (e.key === "Enter") {
      handleCustomRangeApply();
    }
  }

  function handleTitleClick() {
    var newCount = titleClicks + 1;
    setTitleClicks(newCount);
    
    if (newCount >= 3) {
      setTitleClicks(0);
      if (adminToken) {
        setShowAdminConsole(true);
      } else {
        handleAdminLogin();
      }
    }
    
    setTimeout(function() {
      setTitleClicks(0);
    }, 1000);
  }

  function handleCloseModal() {
    setSelectedRestaurantForModal(null);
  }

  function getMessageBg(type) {
    if (type === "error") return "#ffcdd2";
    if (type === "success") return "#c8e6c9";
    return "#e3f2fd";
  }

  function getMapsUrl(address) {
    return "https://www.google.com/maps/search/?api=1&query=" + encodeURIComponent(address || "");
  }

  // Render distance summary based on mode
  function renderDistanceSummary() {
    if (distanceMode === "radius") {
      return "Max distance: " + formatDistance(maxDistance);
    } else {
      return "Distance: " + formatDistance(minDistance) + " - " + formatDistance(maxRangeDistance);
    }
  }

  return (
    <div style={{ display: "flex", flexWrap: "wrap", maxWidth: 900, margin: "2rem auto", padding: "0 1rem" }}>
      <div style={{ position: "fixed", top: 10, left: "calc(50% - 20px)", transform: "translateX(-50%)" }}>
        <select value={selectedOffice} onChange={handleOfficeSelect}>
          {offices.map(function(office) {
            return <option key={office.name} value={office.name}>{office.address}</option>;
          })}
        </select>
      </div>

      {showAdminConsole && adminToken && (
        <AdminConsole adminToken={adminToken} onClose={handleCloseAdminConsole} />
      )}

      <main style={{ flex: 1, padding: "1rem", border: "1px solid #ccc" }}>
        <h1 style={{ cursor: "pointer" }} onClick={handleTitleClick}>
          Redeploy Restaurant Picker
          {adminToken && <span style={{ fontSize: "0.7rem", color: "#888", marginLeft: "0.5rem" }}>(admin)</span>}
        </h1>

        {adminToken && (
          <div style={{ marginBottom: "1rem" }}>
            <button onClick={handleAdminLogout} style={{ padding: "0.25rem 0.5rem", fontSize: "0.8rem" }}>
              Logout Admin
            </button>
          </div>
        )}

        {messages.map(function(m, i) {
          return (
            <div key={i} style={{ padding: ".5rem", margin: ".25rem 0", background: getMessageBg(m.type) }}>
              {m.text}
            </div>
          );
        })}

        <section style={{ marginBottom: "2rem" }}>
          <h2>Enter a Restaurant</h2>
          <AutocompleteInput
            onSelect={setSelectedRestaurantToSubmit}
            disabled={loadingAction === "submit"}
            userCoords={userCoords}
          />
          <button
            onClick={submitRestaurant}
            disabled={loadingAction === "submit" || !selectedRestaurantToSubmit}
            style={{ padding: ".5rem 1rem" }}
          >
            {loadingAction === "submit" ? "Submitting..." : "Submit Restaurant"}
          </button>
        </section>

        <section style={{ marginBottom: "2rem" }}>
          <h2>Vote on Suggested Restaurants</h2>
          {suggestedRestaurants.length === 0 ? (
            <p>No suggestions currently available.</p>
          ) : (
            suggestedRestaurants.map(function(r) {
              var net = r.up_votes - r.down_votes;
              var voting = loadingAction === "vote-" + r.id;
              var already = votedIds.includes(r.id);
              var disabled = (!adminToken && already) || r.promoted || voting;
              var location = r.address ? r.address.split(',')[0].trim() : '';

              return (
                <div key={r.id} style={{ marginBottom: "1rem", borderBottom: "1px solid #eee", paddingBottom: ".5rem" }}>
                  <p>
                    <strong>{r.name} at {location}</strong>
                    {r.promoted && <span style={{ marginLeft: 8, color: "green" }}>[Validated]</span>}
                  </p>
                  <p>Up: {r.up_votes} | Down: {r.down_votes} | Net: {net}</p>
                  {!r.promoted && (
                    <span>
                      <button
                        onClick={function() { voteRestaurant(r.id, true); }}
                        disabled={disabled}
                        style={{ padding: ".25rem .75rem", marginRight: ".5rem" }}
                      >
                        {voting ? "Voting..." : (already && !adminToken) ? "Voted" : "Upvote"}
                      </button>
                      <button
                        onClick={function() { voteRestaurant(r.id, false); }}
                        disabled={disabled}
                        style={{ padding: ".25rem .75rem", background: "#ffdddd" }}
                      >
                        {voting ? "Voting..." : (already && !adminToken) ? "Voted" : "Downvote"}
                      </button>
                    </span>
                  )}
                </div>
              );
            })
          )}
        </section>

        <section style={{ marginBottom: "2rem" }}>
          <h2>Find a Restaurant</h2>
          
          {/* Distance mode toggle */}
          <div style={{ marginBottom: "1rem" }}>
            <span style={{ fontSize: "0.9rem", color: "#555", marginRight: "0.75rem" }}>Distance mode:</span>
            <button
              onClick={function() { setDistanceMode("radius"); }}
              style={{
                padding: "0.4rem 0.75rem",
                marginRight: "0.5rem",
                background: distanceMode === "radius" ? "#007bff" : "#f0f0f0",
                color: distanceMode === "radius" ? "white" : "#333",
                border: "1px solid " + (distanceMode === "radius" ? "#007bff" : "#ccc"),
                borderRadius: 4,
                cursor: "pointer"
              }}
            >
              Radius
            </button>
            <button
              onClick={function() { setDistanceMode("range"); }}
              style={{
                padding: "0.4rem 0.75rem",
                background: distanceMode === "range" ? "#007bff" : "#f0f0f0",
                color: distanceMode === "range" ? "white" : "#333",
                border: "1px solid " + (distanceMode === "range" ? "#007bff" : "#ccc"),
                borderRadius: 4,
                cursor: "pointer"
              }}
            >
              Range
            </button>
          </div>

          {/* Distance summary */}
          <div style={{ marginBottom: "0.75rem" }}>
            <strong>{renderDistanceSummary()}</strong>
          </div>

          {/* Radius mode UI */}
          {distanceMode === "radius" && (
            <div>
              <div style={{ display: "flex", flexWrap: "wrap", gap: "0.5rem", marginBottom: "0.75rem" }}>
                {DISTANCE_PRESETS.map(function(preset) {
                  var isSelected = maxDistance === preset.value;
                  return (
                    <button
                      key={preset.value}
                      onClick={function() { handleRadiusPreset(preset.value); }}
                      style={{
                        padding: "0.4rem 0.75rem",
                        background: isSelected ? "#007bff" : "#f0f0f0",
                        color: isSelected ? "white" : "#333",
                        border: "1px solid " + (isSelected ? "#007bff" : "#ccc"),
                        borderRadius: 4,
                        cursor: "pointer"
                      }}
                    >
                      {preset.label}
                    </button>
                  );
                })}
              </div>

              <div style={{ display: "flex", alignItems: "center", gap: "0.5rem", marginBottom: "0.75rem" }}>
                <span style={{ fontSize: "0.9rem", color: "#555" }}>Custom:</span>
                <input
                  type="text"
                  placeholder="e.g. 350m or 1.5km"
                  value={customDistance}
                  onChange={handleCustomDistanceChange}
                  onKeyPress={handleCustomDistanceKeyPress}
                  style={{ padding: "0.4rem", width: "140px", boxSizing: "border-box" }}
                />
                <button
                  onClick={handleCustomDistanceApply}
                  style={{ padding: "0.4rem 0.75rem" }}
                >
                  Apply
                </button>
              </div>
            </div>
          )}

          {/* Range mode UI */}
          {distanceMode === "range" && (
            <div>
              {/* From presets */}
              <div style={{ marginBottom: "0.75rem" }}>
                <span style={{ fontSize: "0.9rem", color: "#555", marginRight: "0.5rem" }}>From:</span>
                <div style={{ display: "inline-flex", flexWrap: "wrap", gap: "0.5rem" }}>
                  {RANGE_FROM_PRESETS.map(function(preset) {
                    var isSelected = minDistance === preset.value;
                    return (
                      <button
                        key={preset.value}
                        onClick={function() { handleMinPreset(preset.value); }}
                        style={{
                          padding: "0.4rem 0.75rem",
                          background: isSelected ? "#28a745" : "#f0f0f0",
                          color: isSelected ? "white" : "#333",
                          border: "1px solid " + (isSelected ? "#28a745" : "#ccc"),
                          borderRadius: 4,
                          cursor: "pointer"
                        }}
                      >
                        {preset.label}
                      </button>
                    );
                  })}
                </div>
              </div>

              {/* To presets */}
              <div style={{ marginBottom: "0.75rem" }}>
                <span style={{ fontSize: "0.9rem", color: "#555", marginRight: "0.75rem" }}>To:</span>
                <div style={{ display: "inline-flex", flexWrap: "wrap", gap: "0.5rem" }}>
                  {DISTANCE_PRESETS.map(function(preset) {
                    var isSelected = maxRangeDistance === preset.value;
                    return (
                      <button
                        key={preset.value}
                        onClick={function() { handleMaxRangePreset(preset.value); }}
                        style={{
                          padding: "0.4rem 0.75rem",
                          background: isSelected ? "#dc3545" : "#f0f0f0",
                          color: isSelected ? "white" : "#333",
                          border: "1px solid " + (isSelected ? "#dc3545" : "#ccc"),
                          borderRadius: 4,
                          cursor: "pointer"
                        }}
                      >
                        {preset.label}
                      </button>
                    );
                  })}
                </div>
              </div>

              {/* Custom range inputs */}
              <div style={{ display: "flex", alignItems: "center", gap: "0.5rem", marginBottom: "0.75rem", flexWrap: "wrap" }}>
                <span style={{ fontSize: "0.9rem", color: "#555" }}>Custom:</span>
                <input
                  type="text"
                  placeholder="e.g. 0m or 800m"
                  value={customMinDistance}
                  onChange={handleCustomMinChange}
                  onKeyPress={handleCustomRangeKeyPress}
                  style={{ padding: "0.4rem", width: "110px", boxSizing: "border-box" }}
                />
                <span style={{ fontSize: "0.9rem", color: "#555" }}>to</span>
                <input
                  type="text"
                  placeholder="e.g. 2km or 500m"
                  value={customMaxDistance}
                  onChange={handleCustomMaxChange}
                  onKeyPress={handleCustomRangeKeyPress}
                  style={{ padding: "0.4rem", width: "110px", boxSizing: "border-box" }}
                />
                <button
                  onClick={handleCustomRangeApply}
                  style={{ padding: "0.4rem 0.75rem" }}
                >
                  Apply
                </button>
              </div>
            </div>
          )}

          <p style={{ margin: 0, fontSize: ".9rem", color: "#555" }}>
            Current base: {currentBase}
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
            {loadingAction === "randomize" ? "Searching..." : "Randomize Restaurant"}
          </button>
        </section>

        {noRecommendationsMessage && <p style={{ color: "#888" }}>{noRecommendationsMessage}</p>}
        
        {selectedRestaurant && (
          <section style={{ borderTop: "1px solid #eee", paddingTop: "1rem" }}>
            <h2>Recommended Restaurant</h2>
            <p><strong>Name:</strong> {selectedRestaurant.name} at {selectedRestaurant.address ? selectedRestaurant.address.split(',')[0].trim() : ''}</p>
            <p><strong>Type:</strong> {selectedRestaurant.type} <em>(AI classification)</em></p>
            <p><strong>Distance:</strong> {selectedRestaurant.distance} km</p>
            <a href={getMapsUrl(selectedRestaurant.address)} target="_blank" rel="noopener noreferrer" style={{ color: "#007bff" }}>View on Google Maps</a>
          </section>
        )}
      </main>

      <aside style={{ width: 200, marginLeft: "1rem" }}>
        <h3 style={{ marginTop: 0 }}>Good Restaurants</h3>
        <ul style={{ listStyle: "none", padding: 0 }}>
          {restaurantCounts.map(function(rc, i) {
            return <li key={i} style={{ padding: ".25rem 0" }}>{rc.office}: {rc.count}</li>;
          })}
        </ul>

        <h3>Restaurant Types</h3>
        <ul style={{ listStyle: "none", padding: 0 }}>
          {cuisineTags.map(function(t, i) {
            var arrow = expandedCuisine === t.cuisine ? " v" : " >";
            return (
              <li key={i} style={{ padding: ".25rem 0" }}>
                <span
                  onClick={function() { fetchRestaurantsByCuisine(t.cuisine); }}
                  style={{ cursor: "pointer", color: "#007bff" }}
                >
                  {truncate(t.cuisine)} ({t.count}){arrow}
                </span>
                {expandedCuisine === t.cuisine && (
                  <ul style={{ listStyle: "none", padding: "0.25rem 0 0 1rem", margin: 0 }}>
                    {loadingCuisine ? (
                      <li style={{ color: "#888" }}>Loading...</li>
                    ) : (
                      cuisineRestaurants.map(function(r) {
                        return (
                          <li
                            key={r.id}
                            onClick={function() { setSelectedRestaurantForModal(r); }}
                            style={{ padding: "0.25rem 0", cursor: "pointer", color: "#333" }}
                          >
                            {r.name}
                          </li>
                        );
                      })
                    )}
                  </ul>
                )}
              </li>
            );
          })}
        </ul>

        <h3>Wall of Shame</h3>
        <ul style={{ listStyle: "none", padding: 0 }}>
          {shamedRestaurants.map(function(r) {
            var shameUrl = getMapsUrl(r.name + " " + (r.address || ""));
            return (
              <li key={r.id} style={{ padding: ".25rem 0", display: "flex", alignItems: "center" }}>
                <a href={shameUrl} target="_blank" rel="noopener noreferrer" style={{ color: "#007bff", textDecoration: "none", flex: 1 }}>{r.name}</a>
                {adminToken && (
                  <button
                    onClick={function() { removeShameRestaurant(r.id); }}
                    disabled={loadingAction === "remove-shame-" + r.id}
                    style={{ marginLeft: "auto", padding: ".25rem .5rem", background: "#ffdddd" }}
                  >
                    {loadingAction === "remove-shame-" + r.id ? "..." : "-"}
                  </button>
                )}
              </li>
            );
          })}
        </ul>
      </aside>

      {selectedRestaurantForModal && (
        <RestaurantModal restaurant={selectedRestaurantForModal} onClose={handleCloseModal} adminToken={adminToken} />
      )}
    </div>
  );
}