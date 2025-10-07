# 🧪 Functional Testing Report

## 👤 Student Information
- **Full Name**: Emily Awuor]  
- **Cohort**: [July 2025]  
- **Date**: [7/10//2025]  

---

## 🧪 What I Tested

| Test Type        | Description                                                                 |
|------------------|------------------------------------------------------------------------------|
| **Unit Test**       i tested on the save note.Ensures that both the title and content fields are filled before a note is saved. whether a new note is correctly created and added to the notes. |
| **Integration Test** |  Click the "Edit" button next to a note to modify its content.               |
| **System Test**   | Simulated full note lifecycle: create → edit → delete.                      |

---

## 🐛 Bugs / Issues Identified

| Type             | Description                                                                 |
|------------------|------------------------------------------------------------------------------|
| Unit             | After saving a note, there’s no confirmation message or feedback to the user indicating that the note has been successfully saved.when editing a note, the existing values are repopulated correctly in the input fields but there's no confirmation or message indicating that the note has been removed from the list upon selection for editing.
                     |
| Integration      | [After editing a note, there was no confirmation that the note was updated.]|
| System           | If a user tries to save a note with empty fields, after the alert is shown, the input fields remain empty, which may be misleading.sThe functionality to write a note and save it worked correctly. The notes were stored in the array and displayed immediately after saving.       |
| 
*GitHub Issues Filed: [List links to the 3 required issues, with labels]*

---

## 💬 Reflection

### 1. What did you learn from testing this app?
> [ I learned how User Expectations: Testing allowed me to gain insights into how users interact with the app. .]

### 2. Which part of the app had the most bugs or problems?
>  Users did not receive sufficient feedback after performing actions, such as saving changes or submitting forms, leading to uncertainty about whether their actions were successful.

### 3. What testing strategy worked best for you?
> [e.g., Starting with exploratory clicks helped me find visible bugs before writing code-level tests.]

### 4. What was challenging during this lab?
> [ Setting up Jest for DOM-based tests was tricky at first.]

---

## ✅ Checklist

- [ ] I wrote and ran unit, integration, and system tests using Jest  
- [ ] I filed 3 functional GitHub Issues with clear descriptions  
- [ ] I completed this Test Report and reflected on the process  