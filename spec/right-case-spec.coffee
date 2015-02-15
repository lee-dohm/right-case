RightCase = require '../lib/right-case'

describe 'RightCase', ->
  [activationPromise, editor, editorView] = []

  titleCase = (callback) ->
    atom.commands.dispatch(editorView, 'right-case:title-case')
    waitsForPromise -> activationPromise
    runs(callback)

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open()

    runs ->
      editor = atom.workspace.getActiveTextEditor()
      editorView = atom.views.getView(editor)

      activationPromise = atom.packages.activatePackage('right-case')

  describe 'title case', ->
    describe 'when text is selected', ->
      it 'title cases the selection', ->
        editor.setText 'war: a an the to at in with anyway?'
        editor.selectAll()

        titleCase ->
          expect(editor.getText()).toBe 'War: a an the to at in with Anyway?'

      it 'always upcases the first and last word', ->
        editor.setText 'a an the to at in with'
        editor.selectAll()

        titleCase ->
          expect(editor.getText()).toBe 'A an the to at in With'
