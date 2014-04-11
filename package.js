Package.describe({
  summary: "Meteor UI Tabs - Tab navigation component that can render Blaze UI Templates in tabs and optionally works with iron-router."
});

Package.on_use(function (api, where) {
  api.use(['ui',  'underscore', 'deps', 'templating'], 'client');

  api.use('coffeescript',['client']);
  api.add_files([
    'tabs.html',
    'tabs.coffee'
  ], 'client');
});
