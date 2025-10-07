let notes = [];

    function saveNote() {
      const title = document.getElementById('note-title').value;
      const content = document.getElementById('note-content').value;
      if (!title || !content) return alert("Please fill in both fields.");
      const note = { id: Date.now(), title, content };
      notes.push(note);
      renderNotes();
    }

    function renderNotes() {
      const container = document.getElementById('notes');
      container.innerHTML = '';
      notes.forEach(note => {
        const div = document.createElement('div');
        div.className = 'note';
        div.innerHTML = `
          <h3>${note.title}</h3>
          <p>${note.content}</p>
          <button onclick="editNote(${note.id})">Edit</button>
          <button onclick="deleteNote(${note.id})">Delete</button>
        `;
        container.appendChild(div);
      });
    }

    function editNote(id) {
      const note = notes.find(n => n.id === id);
      if (!note) return;
      document.getElementById('note-title').value = note.title;
      document.getElementById('note-content').value = note.content;
      deleteNote(id);
    }

    function deleteNote(id) {
      notes = notes.filter(n => n.id !== id);
      renderNotes();
    }
