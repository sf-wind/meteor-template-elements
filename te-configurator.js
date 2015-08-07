var fs   = Npm.require('fs');
var path = Npm.require('path');

var writeFile = function(compileStep, file, enabled) {
//  console.log (file);
  content = "";
  if (enabled) {
    var src = file + ".be";
    var exists = fs.existsSync(src);
    if (!exists) {
      compileStep.error({
        message: "The file '" + src + "' does not exist.", 
        sourcePath : compileStep.inputPath
      });
    } else {
      content = fs.readFileSync(src, {encoding : 'utf8'});
    }
  }
  fs.writeFileSync(file, content, {encoding : 'utf8'});
}

var handler = function (compileStep, isLiterate) {
  var jsonPath = compileStep.fullInputPath;
//  console.log(__dirname);
//  console.log(compileStep);
//  console.log(Assets);

  // read the configuration of the project
  var userConfiguration = compileStep.read().toString('utf8');
  
  // if empty (and only then) write distributed configuration
  if (userConfiguration === '') {
    userConfiguration = distributedConfiguration;
    fs.writeFileSync(jsonPath, userConfiguration);
  }
  
  // parse configuration
  try {
    userConfiguration = JSON.parse(userConfiguration);
  } catch (e) {
    compileStep.error({
      message: e.message,
      sourcePath: compileStep.inputPath
    });
    return;
  }
  var moduleConfiguration = userConfiguration.modules || {};
//  console.log(moduleConfiguration);
  
  for (var module in moduleConfiguration) {
    var enabled = moduleConfiguration[module];
    var moduleDefinition = moduleDefinitions[module];
    if (moduleDefinition == null) {
      compileStep.error({
        message : "The module'" + module + "' does not exist.",
        sourcePath: compileStep.inputPath
      });
    } else {
      for (var type in moduleDefinition) {
        var oneType = moduleDefinition[type];
        for (var idx in oneType) {
          var file = oneType[idx];
//          writeFile(compileStep, file, enabled);
        }
      }
    }
  }
};

Plugin.registerSourceHandler('be.json', {archMatching: 'web'}, handler);
