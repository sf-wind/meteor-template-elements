Package.describe({
  name: 'fsun:bootstrap-elements',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use(['coffeescript', 'tinytest']);
  api.use("templating", "client");
  api.use("blaze", "client");
  api.use("jquery", "client");
  api.use("underscore", "client");
  api.use("less", "client");

//  api.imply('nemo64:bootstrap@3.3.5', 'client')
  api.use('fortawesome:fontawesome@4.3.0', 'client')
  api.addFiles('exports.js');
  api.addFiles('client/list/list.html');
  api.addFiles('client/list/list.coffee');
  api.addFiles('client/list/list.less');
  api.addFiles('client/header/header.html');
  api.addFiles('client/header/header.coffee');
  api.addFiles('client/header/header.less');
  api.addFiles('client/footer/footer.html');
  api.addFiles('client/footer/footer.coffee');
  api.addFiles('client/footer/footer.less');
  api.export("BElements");
});

