// frontend/src/AutocompleteInput.js
import { useState, useEffect, useRef, useCallback } from "react";

const API_BASE = process.env.REACT_APP_API_BASE || '';

export default function AutocompleteInput({
  onSelect,
  disabled = false,
  userCoords = null,
}) {
  const [query, setQuery] = useState("");
  const [suggestions, setSuggestions] = useState([]);
  const [loading, setLoading] = useState(false);
  const debounceRef = useRef(null);
  const containerRef = useRef(null);

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (containerRef.current && !containerRef.current.contains(event.target)) {
        setSuggestions([]);
      }
    };

    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const fetchSuggestions = useCallback(async () => {
    const currentQuery = query;
    setLoading(true);

    try {
      const params = new URLSearchParams({ query: currentQuery });
      if (userCoords) {
        params.append("user_lat", userCoords.lat);
        params.append("user_lng", userCoords.lng);
      }
      const res = await fetch(`${API_BASE}/api/search-restaurants?${params.toString()}`);
      if (!res.ok) throw new Error("Search failed");
      const data = await res.json();
      if (query === currentQuery) setSuggestions(data);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }, [query, userCoords]);

  useEffect(() => {
    if (debounceRef.current) clearTimeout(debounceRef.current);
    if (query.length < 2) {
      setSuggestions([]);
      return;
    }
    debounceRef.current = setTimeout(fetchSuggestions, 300);
    return () => clearTimeout(debounceRef.current);
  }, [query, fetchSuggestions]);

  const handleSelect = (item) => {
    onSelect(item);
    setQuery(item.name);
    setSuggestions([]);
  };

  return (
    <div style={{ position: "relative" }} ref={containerRef}>
      <input
        type="text"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        disabled={disabled}
        placeholder="Start typing…"
        style={{ width: "80%", padding: ".5rem" }}
      />

      {loading && <div>Loading...</div>}

      {suggestions.length > 0 && (
        <ul
          style={{
            position: "absolute",
            zIndex: 1,
            background: "white",
            border: "1px solid #ccc",
            listStyle: "none",
            padding: 0,
            margin: 0,
            width: "80%",
          }}
        >
          {suggestions.map((item) => (
            <li
              key={item.google_id}
              onClick={() => handleSelect(item)}
              style={{ padding: ".5rem", cursor: "pointer" }}
            >
              {item.name} ({item.address},{" "}
              {item.distance.toFixed(1)} km from {userCoords ? "you" : "office"})
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}