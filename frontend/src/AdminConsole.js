import { useState, useEffect, useCallback } from "react";

const API_BASE = process.env.REACT_APP_API_BASE || '';

export default function AdminConsole({ adminToken, onClose }) {
  const [restaurants, setRestaurants] = useState([]);
  const [shamedRestaurants, setShamedRestaurants] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState({ office: "", promoted: "" });
  const [editingId, setEditingId] = useState(null);
  const [editValues, setEditValues] = useState({});
  const [message, setMessage] = useState(null);
  const [activeTab, setActiveTab] = useState("restaurants");

  const showMessage = (text, type = "info") => {
    setMessage({ text, type });
    setTimeout(() => setMessage(null), 3000);
  };

  const fetchRestaurants = useCallback(async () => {
    setLoading(true);
    try {
      const params = new URLSearchParams();
      if (filter.office) params.append("office_name", filter.office);
      if (filter.promoted !== "") params.append("promoted", filter.promoted);

      const r = await fetch(`${API_BASE}/api/admin/restaurants?${params}`, {
        headers: { "X-Admin-Token": adminToken },
      });
      if (!r.ok) throw new Error("Failed to fetch");
      setRestaurants(await r.json());
    } catch (e) {
      showMessage(e.message, "error");
    } finally {
      setLoading(false);
    }
  }, [adminToken, filter]);

  const fetchShamed = useCallback(async () => {
    try {
      const r = await fetch(`${API_BASE}/api/wall-of-shame`, {
        headers: { "X-Admin-Token": adminToken },
      });
      if (r.ok) setShamedRestaurants(await r.json());
    } catch (e) {
      console.error(e);
    }
  }, [adminToken]);

  useEffect(() => {
    fetchRestaurants();
    fetchShamed();
  }, [fetchRestaurants, fetchShamed]);

  const startEdit = (restaurant) => {
    setEditingId(restaurant.id);
    setEditValues({
      cuisine: restaurant.cuisine || "",
      name: restaurant.name,
      promoted: restaurant.promoted,
      office_name: restaurant.office_name || "",
    });
  };

  const cancelEdit = () => {
    setEditingId(null);
    setEditValues({});
  };

  const saveEdit = async (id) => {
    try {
      const r = await fetch(`${API_BASE}/api/admin/restaurant/${id}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-Admin-Token": adminToken,
        },
        body: JSON.stringify(editValues),
      });
      if (!r.ok) throw new Error("Failed to update");
      showMessage("Updated successfully", "success");
      setEditingId(null);
      fetchRestaurants();
    } catch (e) {
      showMessage(e.message, "error");
    }
  };

  const deleteRestaurant = async (id, name) => {
    if (!window.confirm(`Delete "${name}"? This cannot be undone.`)) return;

    try {
      const r = await fetch(`${API_BASE}/api/admin/restaurant/${id}`, {
        method: "DELETE",
        headers: { "X-Admin-Token": adminToken },
      });
      if (!r.ok) throw new Error("Failed to delete");
      showMessage("Deleted successfully", "success");
      fetchRestaurants();
    } catch (e) {
      showMessage(e.message, "error");
    }
  };

  const deleteShamed = async (id, name) => {
    if (!window.confirm(`Remove "${name}" from wall of shame?`)) return;

    try {
      const r = await fetch(`${API_BASE}/api/shame-restaurant/${id}`, {
        method: "DELETE",
        headers: { "X-Admin-Token": adminToken },
      });
      if (!r.ok) throw new Error("Failed to delete");
      showMessage("Removed from wall of shame", "success");
      fetchShamed();
    } catch (e) {
      showMessage(e.message, "error");
    }
  };

  return (
    <div
      style={{
        position: "fixed",
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        background: "rgba(0,0,0,0.5)",
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        zIndex: 1000,
      }}
    >
      <div
        style={{
          background: "white",
          borderRadius: 8,
          width: "90%",
          maxWidth: 900,
          maxHeight: "90vh",
          overflow: "hidden",
          display: "flex",
          flexDirection: "column",
        }}
      >
        {/* Header */}
        <div
          style={{
            padding: "1rem",
            borderBottom: "1px solid #eee",
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
          }}
        >
          <h2 style={{ margin: 0 }}>Admin Console</h2>
          <button onClick={onClose} style={{ padding: "0.5rem 1rem" }}>
            Close
          </button>
        </div>

        {/* Message */}
        {message && (
          <div
            style={{
              padding: "0.5rem 1rem",
              background: message.type === "error" ? "#ffcdd2" : "#c8e6c9",
            }}
          >
            {message.text}
          </div>
        )}

        {/* Tabs */}
        <div style={{ padding: "0.5rem 1rem", borderBottom: "1px solid #eee" }}>
          <button
            onClick={() => setActiveTab("restaurants")}
            style={{
              padding: "0.5rem 1rem",
              marginRight: "0.5rem",
              background: activeTab === "restaurants" ? "#e0e0e0" : "white",
              border: "1px solid #ccc",
              borderRadius: 4,
            }}
          >
            Restaurants ({restaurants.length})
          </button>
          <button
            onClick={() => setActiveTab("shame")}
            style={{
              padding: "0.5rem 1rem",
              background: activeTab === "shame" ? "#e0e0e0" : "white",
              border: "1px solid #ccc",
              borderRadius: 4,
            }}
          >
            Wall of Shame ({shamedRestaurants.length})
          </button>
        </div>

        {/* Filters (only for restaurants tab) */}
        {activeTab === "restaurants" && (
          <div style={{ padding: "0.5rem 1rem", borderBottom: "1px solid #eee" }}>
            <select
              value={filter.office}
              onChange={(e) => setFilter((f) => ({ ...f, office: e.target.value }))}
              style={{ marginRight: "0.5rem", padding: "0.25rem" }}
            >
              <option value="">All offices</option>
              <option value="Gbg-office">Gothenburg</option>
              <option value="Jkpg-office">Jönköping</option>
              <option value="Sthlm-office">Stockholm</option>
            </select>
            <select
              value={filter.promoted}
              onChange={(e) => setFilter((f) => ({ ...f, promoted: e.target.value }))}
              style={{ padding: "0.25rem" }}
            >
              <option value="">All status</option>
              <option value="true">Promoted</option>
              <option value="false">Not promoted</option>
            </select>
          </div>
        )}

        {/* Content */}
        <div style={{ flex: 1, overflow: "auto", padding: "1rem" }}>
          {loading ? (
            <p>Loading...</p>
          ) : activeTab === "restaurants" ? (
            <table style={{ width: "100%", borderCollapse: "collapse" }}>
              <thead>
                <tr style={{ borderBottom: "2px solid #ccc", textAlign: "left" }}>
                  <th style={{ padding: "0.5rem" }}>Name</th>
                  <th style={{ padding: "0.5rem" }}>Cuisine</th>
                  <th style={{ padding: "0.5rem" }}>Office</th>
                  <th style={{ padding: "0.5rem" }}>Votes</th>
                  <th style={{ padding: "0.5rem" }}>Status</th>
                  <th style={{ padding: "0.5rem" }}>Actions</th>
                </tr>
              </thead>
              <tbody>
                {restaurants.map((r) => (
                  <tr key={r.id} style={{ borderBottom: "1px solid #eee" }}>
                    {editingId === r.id ? (
                      <>
                        <td style={{ padding: "0.5rem" }}>
                          <input
                            value={editValues.name}
                            onChange={(e) =>
                              setEditValues((v) => ({ ...v, name: e.target.value }))
                            }
                            style={{ width: "100%", padding: "0.25rem" }}
                          />
                        </td>
                        <td style={{ padding: "0.5rem" }}>
                          <input
                            value={editValues.cuisine}
                            onChange={(e) =>
                              setEditValues((v) => ({ ...v, cuisine: e.target.value }))
                            }
                            style={{ width: "100%", padding: "0.25rem" }}
                          />
                        </td>
                        <td style={{ padding: "0.5rem" }}>
                          <select
                            value={editValues.office_name}
                            onChange={(e) =>
                              setEditValues((v) => ({ ...v, office_name: e.target.value }))
                            }
                            style={{ padding: "0.25rem" }}
                          >
                            <option value="Gbg-office">Gbg</option>
                            <option value="Jkpg-office">Jkpg</option>
                            <option value="Sthlm-office">Sthlm</option>
                          </select>
                        </td>
                        <td style={{ padding: "0.5rem" }}>
                          +{r.up_votes} / -{r.down_votes}
                        </td>
                        <td style={{ padding: "0.5rem" }}>
                          <input
                            type="checkbox"
                            checked={editValues.promoted}
                            onChange={(e) =>
                              setEditValues((v) => ({ ...v, promoted: e.target.checked }))
                            }
                          />
                          Promoted
                        </td>
                        <td style={{ padding: "0.5rem" }}>
                          <button
                            onClick={() => saveEdit(r.id)}
                            style={{ marginRight: "0.25rem", padding: "0.25rem 0.5rem" }}
                          >
                            Save
                          </button>
                          <button
                            onClick={cancelEdit}
                            style={{ padding: "0.25rem 0.5rem" }}
                          >
                            Cancel
                          </button>
                        </td>
                      </>
                    ) : (
                      <>
                        <td style={{ padding: "0.5rem" }}>{r.name}</td>
                        <td style={{ padding: "0.5rem" }}>{r.cuisine || "—"}</td>
                        <td style={{ padding: "0.5rem" }}>
                          {r.office_name?.replace("-office", "") || "—"}
                        </td>
                        <td style={{ padding: "0.5rem" }}>
                          +{r.up_votes} / -{r.down_votes}
                        </td>
                        <td style={{ padding: "0.5rem" }}>
                          {r.promoted ? (
                            <span style={{ color: "green" }}>✓ Promoted</span>
                          ) : (
                            <span style={{ color: "#888" }}>Pending</span>
                          )}
                        </td>
                        <td style={{ padding: "0.5rem" }}>
                          <button
                            onClick={() => startEdit(r)}
                            style={{ marginRight: "0.25rem", padding: "0.25rem 0.5rem" }}
                          >
                            Edit
                          </button>
                          <button
                            onClick={() => deleteRestaurant(r.id, r.name)}
                            style={{
                              padding: "0.25rem 0.5rem",
                              background: "#ffdddd",
                            }}
                          >
                            Delete
                          </button>
                        </td>
                      </>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          ) : (
            <table style={{ width: "100%", borderCollapse: "collapse" }}>
              <thead>
                <tr style={{ borderBottom: "2px solid #ccc", textAlign: "left" }}>
                  <th style={{ padding: "0.5rem" }}>Name</th>
                  <th style={{ padding: "0.5rem" }}>Address</th>
                  <th style={{ padding: "0.5rem" }}>Office</th>
                  <th style={{ padding: "0.5rem" }}>Down votes</th>
                  <th style={{ padding: "0.5rem" }}>Actions</th>
                </tr>
              </thead>
              <tbody>
                {shamedRestaurants.map((r) => (
                  <tr key={r.id} style={{ borderBottom: "1px solid #eee" }}>
                    <td style={{ padding: "0.5rem" }}>{r.name}</td>
                    <td style={{ padding: "0.5rem" }}>{r.address || "—"}</td>
                    <td style={{ padding: "0.5rem" }}>
                      {r.office_name?.replace("-office", "") || "—"}
                    </td>
                    <td style={{ padding: "0.5rem" }}>{r.down_votes}</td>
                    <td style={{ padding: "0.5rem" }}>
                      <button
                        onClick={() => deleteShamed(r.id, r.name)}
                        style={{ padding: "0.25rem 0.5rem", background: "#ffdddd" }}
                      >
                        Remove
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>
    </div>
  );
}