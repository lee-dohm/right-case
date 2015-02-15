module.exports =
  activate: ->
    atom.commands.add 'atom-text-editor',
      'right-case:title-case': ->
        editor = atom.workspace.getActiveTextEditor()
        modifySelections(editor, titleCase)

# Public: Executes the replacement function on each selection in the editor.
#
# * `editor` {TextEditor} to replace selections in.
# * `fn` {Function} to use to replace selected text.
modifySelections = (editor, fn) ->
  editor.mutateSelectedText (selection) ->
    text = fn(selection.getText())
    selection.delete()
    selection.insertText(text)

# Public: Title cases the supplied text.
#
# * `text` {String} text to convert
#
# Returns a {String} containing the title cased text.
titleCase = (text) ->
  text = text.replace /\w\S*/g, (word) ->
    return word if word in titleCaseExceptions
    word.charAt(0).toUpperCase() + word.substr(1).toLowerCase()

  text = text.replace /^(\s*)(\w)/, (_, whitespace, word) ->
    whitespace + word.charAt(0).toUpperCase()

  text.replace /\w\S*$/, (word) ->
    word.charAt(0).toUpperCase() + word.substr(1).toLowerCase()

titleCaseExceptions = [
  'a'
  'an'
  'the'
  'to'
  'at'
  'in'
  'with'
  'of'
]
