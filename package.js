Package.describe({
  name: 'fsun:template-elements',
  version: '0.1.1',
  // Brief, one-line summary of the package.
  summary: 'Common template elements to simplify view design. ',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/sf-wind/meteor-template-elements',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.3');
  api.use('coffeescript');
  api.use("templating", "client");
  api.use("blaze", "client");
  api.use("jquery", "client");
  api.use("underscore", "client");
  api.use("less", "client");

  //api.addFiles('exports.js');
  api.addFiles('client/util.coffee')
  api.addFiles('client/list/list.html');
  api.addFiles('client/list/list.coffee');
  api.addFiles('client/list/list.less');
  api.addFiles('client/header/header.html');
  api.addFiles('client/header/header.coffee');
  api.addFiles('client/header/header.less');
  api.addFiles('client/footer/footer.html');
  api.addFiles('client/footer/footer.coffee');
  api.addFiles('client/footer/footer.less');
  api.addFiles('client/pagination/pagination.html');
  api.addFiles('client/pagination/pagination.coffee');
  api.addFiles('client/pagination/pagination.less');
  api.addFiles('client/code/code.html');
  api.addFiles('client/code/code.coffee');
  api.addFiles('client/code/code.less');
  //api.export("BElements");
});

Package.onTest(function(api) {
  api.use("sanjo:jasmine@0.17.0")
  //api.use("simple:highlight.js")

  api.use('coffeescript');
  api.use("templating", "client");
  api.use("blaze", "client");
  api.use("jquery", "client");
  api.use("fsun:template-elements")

  api.addFiles('tests/client/code/footer-example.txt', 'server', {isAsset : true})
  api.addFiles('tests/_.coffee', 'client');
  api.addFiles('tests/client/list/list.coffee', 'client');
  api.addFiles('tests/client/header/header.coffee', 'client');
  api.addFiles('tests/client/footer/footer.coffee', 'client');
  api.addFiles('tests/client/pagination/pagination.coffee', 'client');
  api.addFiles('tests/client/code/code.coffee', 'client')
  // should be the last file to add
  api.addFiles('tests/tests.coffee', 'client');

});
