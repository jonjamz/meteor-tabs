Tabs
=================================
Meteor UI Tabs - Blaze UI tab navigation component that allows for simple html tabs or rendered templates per tab with data and routes

Installation
=========
```bash
mrt add tabs
```

Usage
=========

### Template
```html
<template name="myapp">
  {{#tabs id="myapp-tabs" settings=tabSettings}}

    <!--  First Tab -->
    <div></div>

    <!--  Yield Tab Example -->
    <div>
      <button class="btn">Button not in rendered template</button>
      <div class="yield"></div>
    </div>

    <!--  Simple HTML Tab -->
    <div>
      <h1>Hey this is an HTML tab with out a template</h1>
    </div>

  {{/tabs}}
</template>
```

### Controller
```coffeescript

Template['myapp'].helpers

  tabSettings: ->
    defaultPath: @tab || "first"
    type: 'horizontal'
    tabs:  [

      ###
        First Tab
      ###
      path: 'first'
      name: 'First'
      template: 'users'
      data:
        users: Meteor.users.find().fetch()
    ,

      ###
        Yield Tab
      ###
      path: 'yield'
      name: 'Yield'
      template: 'other'
    ,

      ###
        HTML Tab
      ###
      path: 'html'
      name: 'HTML'
      onAfterAction: ->
        console.log 'html tab rendered'
    ,

```

### Router Example
```coffeescript

Router.map ->

  @route "myapp",
    path: "/myapp/:tab?"
    template: 'myapp'
    data: ->
      return
        tab: @params.tab

```