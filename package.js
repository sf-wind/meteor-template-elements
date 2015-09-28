Package.describe({
  name: 'fsun:template-elements',
  version: '0.1.6',
  // Brief, one-line summary of the package.
  summary: 'Common template elements to simplify view design. ',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/sf-wind/meteor-template-elements',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.0.1');
  api.use('coffeescript');
  api.use("templating", "client");
  api.use("blaze", "client");
  api.use("jquery", "client");
  api.use("underscore", "client");
  api.use("less", "client");
  api.use("reactive-var", "client")
  api.use("momentjs:moment@2.10.6", "client")

  api.addFiles('exports.coffee');
  api.export("BElements");

  api.addFiles('client/list/list.html', 'client');
  api.addFiles('client/list/list.coffee', 'client');
  api.addFiles('client/list/list.less', 'client');

  api.addFiles('client/header/header.html', 'client');
  api.addFiles('client/header/header.coffee', 'client');
  api.addFiles('client/header/header.less', 'client');

  api.addFiles('client/footer/footer.html', 'client');
  api.addFiles('client/footer/footer.coffee', 'client');
  api.addFiles('client/footer/footer.less', 'client');

  api.addFiles('client/pagination/pagination.html', 'client');
  api.addFiles('client/pagination/pagination.coffee', 'client');
  api.addFiles('client/pagination/pagination.less', 'client');

  api.addFiles('client/code/code.html', 'client');
  api.addFiles('client/code/code.coffee', 'client');
  api.addFiles('client/code/code.less', 'client');

  api.addFiles('client/calendar/calendar.html', 'client');
  api.addFiles('client/calendar/calendar.coffee', 'client');
  api.addFiles('client/calendar/calendar.less', 'client');

});

Package.onTest(function(api) {
  api.use("sanjo:jasmine@0.18.0")

  api.use('coffeescript');
  api.use("templating", "client");
  api.use("blaze", "client");
  api.use("jquery", "client");
  api.use("fsun:template-elements")

  api.addAssets('tests/client/code/footer-example.txt', 'server')
  api.addFiles('tests/_.coffee', 'client');
  api.addFiles('tests/client/list/list.coffee', 'client');
  api.addFiles('tests/client/header/header.coffee', 'client');
  api.addFiles('tests/client/footer/footer.coffee', 'client');
  api.addFiles('tests/client/pagination/pagination.coffee', 'client');
  api.addFiles('tests/client/code/code.coffee', 'client')
  // should be the last file to add
  api.addFiles('tests/tests.coffee', 'client');

});
