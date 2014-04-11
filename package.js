Package.describe({
  summary: "Meteor UI Tabs"
});

Package.on_use(function (api, where) {
  api.use(['ui',  'underscore', 'deps', 'templating'], 'client');
  api.use('coffeescript',['client']);
  api.add_files(['tabs.coffee'], 'client');
});