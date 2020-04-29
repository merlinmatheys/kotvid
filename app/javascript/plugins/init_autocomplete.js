import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('adresse_recherche');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
