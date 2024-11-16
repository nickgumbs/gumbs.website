import Handlebars from 'handlebars/runtime';

export const registerHelpersAndPartials = () => {

  // Automatically register all partials
  const context = require.context('../templates/partials', true, /\.hbs$/);
  context.keys().forEach((key) => {
    const partialName = key.replace(/^\.\/(.*)\.hbs$/, '$1');
    console.log(`Registering partial: ${partialName}`);  // Debug line to ensure partials are being registered
    Handlebars.registerPartial(partialName, context(key));
  });

  // Add attributes to template object
  Handlebars.registerHelper('attr', function (options) {
    const attributes = [];

    for (const [key, value] of Object.entries(options.hash)) {
      if (value) {
        attributes.push(`${key}="${Handlebars.escapeExpression(value)}"`);
      }
    }

    return new Handlebars.SafeString(attributes.join(' '));
  });

  // Helper to handle missing partials
  Handlebars.registerHelper('helperMissing', function () {
    var options = arguments[arguments.length - 1];
    var args = Array.prototype.slice.call(arguments, 0, arguments.length - 1)
    return new Handlebars.SafeString("Missing: " + options.name + "(" + args + ")")
  })
};

