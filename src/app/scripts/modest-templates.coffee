class ModestTemplates

  SPACES_PER_TAB: 4

  constructor: ->
    @codeInElem = $('textarea[name="code-in"]');
    @codeOutElem = $('textarea[name="code-out"]');

    @codeInElem.on 'keydown', =>
      @processTemplate @codeInElem.val()

  processTemplate: (code) =>
    lines = code.split '\n'
    @depth = 0
    @openTags = []
    @processLine line for line in lines

  logError: (lineNo, message) =>
    console.info "Modest templates: error parsing at line #{lineNo}"
    throw message

  maxValidIndentation: (depth, spacesPerTab) =>
    if depth is 0 then 0 else (depth + 1) * spacesPerTab

  processLine: (line) =>

    # No need to parse empty lines or just spaces
    return if line.length is 0
    return if /^\s+$/.test(line)

    # Validating the indentaion
    leadingSpacesCount = line.length - line.trimLeft().length
    unless leadingSpacesCount % @SPACES_PER_TAB is 0
      @logError "indentation should be a multiplication of #{@SPACES_PER_TAB}"
    maxIndentation = @maxValidIndentation @depth, @SPACES_PER_TAB
    if leadingSpacesCount > maxIndentation
      @logError "too much indentation (expected #{maxIndentation} at most)"

    # Extrtacting tan name string out of remainder
    lineRemainder = line.trim()
    tagNameString = lineRemainder.split(' ')[0]
    lineRemainder = lineRemainder.substr(tagNameString.length).trim()

    # Processing the tag name string
    hashCount = (lineRemainder.match(/#/g) || []).length
    if hashCount > 1
      @logError "elements are supposed to have only one ID (#{tagNameString})"
    console.info tagNameString




$ ->
  window.ModestTemplates = new ModestTemplates()
