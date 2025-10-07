const note = require('./script');
describe('saveNotes',()=>{
    let notes;
})
test('save notes',()=>{
    let title = '1964';
    let content = 'How the world was cooked in 1964';
    expect(()=>{
       notey.saveNote(title).toBe('1964');
       notey.saveNote(content).toBe('How the world was cooked in 1964')
    })    
})