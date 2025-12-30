import { useState, useEffect } from "react";

const API_BASE = process.env.REACT_APP_API_BASE || '';

export default function RestaurantModal({ restaurant, onClose }) {
  const [comments, setComments] = useState([]);
  const [loading, setLoading] = useState(true);
  const [authorName, setAuthorName] = useState(localStorage.getItem("comment_author") || "");
  const [commentText, setCommentText] = useState("");
  const [submitting, setSubmitting] = useState(false);
  const [message, setMessage] = useState(null);

  useEffect(function() {
    async function fetchComments() {
      try {
        var url = API_BASE + "/api/restaurant/" + restaurant.id + "/comments";
        var r = await fetch(url);
        if (r.ok) {
          var data = await r.json();
          setComments(data);
        }
      } catch (e) {
        console.error(e);
      } finally {
        setLoading(false);
      }
    }
    fetchComments();
  }, [restaurant.id]);

  async function submitComment() {
    if (!authorName.trim() || !commentText.trim()) {
      setMessage({ type: "error", text: "Please enter your name and recommendation" });
      return;
    }

    setSubmitting(true);
    try {
      localStorage.setItem("comment_author", authorName.trim());
      var url = API_BASE + "/api/restaurant/" + restaurant.id + "/comments";
      var r = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          author_name: authorName.trim(),
          text: commentText.trim()
        })
      });
      var data = await r.json();
      if (!r.ok) {
        setMessage({ type: "error", text: data.detail || "Failed to add recommendation" });
        return;
      }
      setMessage({ type: "success", text: "Recommendation added!" });
      setCommentText("");
      var cr = await fetch(url);
      if (cr.ok) {
        var newComments = await cr.json();
        setComments(newComments);
      }
    } catch (e) {
      setMessage({ type: "error", text: e.message });
    } finally {
      setSubmitting(false);
    }
  }

  function handleBackdropClick() {
    onClose();
  }

  function handleModalClick(e) {
    e.stopPropagation();
  }

  function handleAuthorChange(e) {
    setAuthorName(e.target.value);
  }

  function handleTextChange(e) {
    setCommentText(e.target.value);
  }

  var mapsUrl = "https://www.google.com/maps/search/?api=1&query=" + encodeURIComponent(restaurant.address || "");

  function renderComments() {
    if (loading) {
      return <p>Loading...</p>;
    }
    if (comments.length === 0) {
      return <p style={{ color: "#888" }}>No recommendations yet.</p>;
    }
    return (
      <ul style={{ listStyle: "none", padding: 0 }}>
        {comments.map(function(c) {
          var dateStr = new Date(c.created_at).toLocaleDateString();
          return (
            <li key={c.id} style={{ padding: "0.75rem", marginBottom: "0.5rem", background: "#f9f9f9", borderRadius: 4 }}>
              <p style={{ margin: 0 }}>{c.text}</p>
              <p style={{ margin: "0.25rem 0 0", fontSize: "0.8rem", color: "#888" }}>
                - {c.author_name}, {dateStr}
              </p>
            </li>
          );
        })}
      </ul>
    );
  }

  function renderMessage() {
    if (!message) return null;
    var bgColor = message.type === "error" ? "#ffcdd2" : "#c8e6c9";
    return (
      <div style={{ padding: "0.5rem", marginBottom: "0.5rem", background: bgColor, borderRadius: 4 }}>
        {message.text}
      </div>
    );
  }

  var buttonText = submitting ? "Adding..." : "Add";

  return (
    <div onClick={handleBackdropClick} style={{ position: "fixed", top: 0, left: 0, right: 0, bottom: 0, background: "rgba(0,0,0,0.5)", display: "flex", justifyContent: "center", alignItems: "center", zIndex: 1000 }}>
      <div onClick={handleModalClick} style={{ background: "white", borderRadius: 8, width: "90%", maxWidth: 500, maxHeight: "80vh", overflow: "auto", padding: "1.5rem" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "1rem" }}>
          <h2 style={{ margin: 0 }}>{restaurant.name}</h2>
          <button onClick={onClose} style={{ padding: "0.25rem 0.5rem" }}>X</button>
        </div>

        <p style={{ color: "#666", margin: "0.5rem 0" }}>{restaurant.address}</p>
        <p style={{ margin: "0.5rem 0" }}><strong>Type:</strong> {restaurant.cuisine}</p>
        <a href={mapsUrl} target="_blank" rel="noopener noreferrer" style={{ color: "#007bff" }}>View on Google Maps</a>

        <hr style={{ margin: "1rem 0" }} />
        <h3>Recommended Dishes</h3>
        {renderComments()}

        <hr style={{ margin: "1rem 0" }} />
        <h4>Recommend a dish</h4>
        {renderMessage()}

        <input type="text" placeholder="Your name" value={authorName} onChange={handleAuthorChange} style={{ width: "100%", padding: "0.5rem", marginBottom: "0.5rem", boxSizing: "border-box" }} />
        <textarea placeholder="What dish do you recommend?" value={commentText} onChange={handleTextChange} rows={3} style={{ width: "100%", padding: "0.5rem", marginBottom: "0.5rem", boxSizing: "border-box", resize: "vertical" }} />
        <button onClick={submitComment} disabled={submitting} style={{ padding: "0.5rem 1rem" }}>{buttonText}</button>
      </div>
    </div>
  );
}