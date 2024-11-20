// Styles & Static Files
import './styles.css';
import { refreshJoke } from './helpers/jokes';
import { refreshCount } from './helpers/visitors';

import { registerHelpersAndPartials } from './helpers/handlebars';

// Templates
import sectionTemplate from './templates/Section.hbs';
import headerTemplate from './templates/Header.hbs';
import footerTemplate from './templates/Footer.hbs';

// Register your helpers
registerHelpersAndPartials();

// Fetch the JSON data
fetch('./data/homepage.json')
  .then((response) => response.json())
  .then((data) => {
    // Set content of each section on the page
    const container = document.getElementById('content');
    const header = document.getElementById('header');
    const footer = document.getElementById('footer');

    header.innerHTML += headerTemplate(data.header);
    for (const key in data.content) {
      if (data.content.hasOwnProperty(key)) {
        const sectionData = data.content[key];
        container.innerHTML += sectionTemplate(sectionData);
      }
    }
    footer.innerHTML += footerTemplate(data.footer);

    // Dispatch an event indicating templates are loaded
    const templatesLoadedEvent = new Event('templatesLoaded');
    document.dispatchEvent(templatesLoadedEvent);
  })
  .catch((error) => console.error('Error loading data:', error));

// Initial joke load
document.addEventListener('templatesLoaded', () => {
  refreshJoke();
  refreshCount();

  // Event listener if you have a button to refresh the joke
  document.querySelectorAll('.refresh').forEach((button) => {
    button.addEventListener('click', refreshJoke);
  });
});
