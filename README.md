Tabs
=================================
Meteor UI Tabs - Blaze UI tab navigation component that allows for simple html tabs or rendered templates per tab with data and routes

![demo](http://cl.ly/Uwda/Screenshot%202014-04-11%2004.33.21.png)

Installation
=========
```bash
mrt add tabs
```
*The styles are not injected in to your application by default. There are Stylus styles which can be imported into your app if you use Stylus or a CSS style sheet that you can copy in. It is my experience that most people like to customize style anyway so I try not to inject styl with components.*


Usage
=========

### Template
*The tabs component is a block helper that wraps children divs which become the tab contents*
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

### Helper
*This is where the component is configured. The names of the tabs become the navigation buttons, the paths become the routes, the tabs can be vertical or horizontal.  If there is an element in the tab with the class "yield" the template will be rendered into it. The data property is optional and can be an object, array, or function. You may also specify an onAfterAction function like in iron-router*
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

### Router (Optional)
*Optionally you can pass a route parameter to the tabs component and it will update the route when switching tabs*
```coffeescript

Router.map ->

  @route "myapp",
    path: "/myapp/:tab?"
    template: 'myapp'
    data: ->
      return
        tab: @params.tab

```