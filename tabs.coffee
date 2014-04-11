###
  Tabs
###
UI.registerHelper 'tabs', ->
  Template['tabs']

###
  JQuery Tabs Plugin
###
do ($ = jQuery, window, document) ->

  # Settings
  pluginName = "tabs"
  defaults =
    type: "horizontal"

  # Plugin
  class Plugin
    constructor: (@element, options) ->
      @settings = $.extend {}, defaults, options
      @_defaults = defaults
      @_name = pluginName
      @init()

    ###
      Init
    ###
    init: ->

      settings = @settings

      # Associate the tabs with paths
      $(@element).find(".tabs-container > div").addClass "tab-content"

      tab = 0
      $(@element).find(".tab-content").each ->
        $(this).addClass "content-id-" + settings.tabs[tab].path
        tab++

      # Events
      $(@element).find(".tab-item").on "click", (e) =>
        @open e.target.dataset.path

      # Open default path
      @open @settings.defaultPath

    ###
      Open Tab
    ###
    open: (path) ->

      # Find the tab matching the path
      tab = _.find @settings.tabs, (tab) ->
        tab.path == path

      # Update the route
      history.pushState {}, '', tab.path

      # Remove previus active class
      $(@element).find(".tab-item.active").removeClass 'active'
      $(@element).find(".tab-content.active").removeClass 'active'

      # Add current active class
      $(@element).find(".tab-id-" + tab.path).addClass 'active'
      $(@element).find(".content-id-" + tab.path).addClass 'active'

      # If the tab has a template render it
      if tab.template

        # Check if there is a yield class
        if $(@element).find(".tab-content.active .yield").length > 0
          tabContent = $(@element).find(".tab-content.active .yield")
        else
          tabContent = $(@element).find(".tab-content.active")

        # Check if there is a data attribute
        if tab.data
          data = if _.isFunction tab.data then tab.data() else tab.data
          renderedTemplate = UI.renderWithData(Template[tab.template], data)
        else
          renderedTemplate = UI.render(Template[tab.template])

        # Insert the rendered template
        UI.insert(renderedTemplate, tabContent.html('').get(0))

      ###
        On After Action
      ###
      if tab.onAfterAction
        tab.onAfterAction()

  # Wrapper
  $.fn[pluginName] = (options) ->
    @each ->
      unless $.data @, "plugin_#{pluginName}"
        $.data @, "plugin_#{pluginName}", new Plugin @, options

###
  Rendered
###
Template['tabs'].rendered = ->
  @element = $('#' + @data.id)
  @element.tabs @data.settings