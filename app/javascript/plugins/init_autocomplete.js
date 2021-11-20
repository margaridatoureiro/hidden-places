import places from 'places.js';

const initAutocomplete = () => {
  console.log("hello hoe");
  const addressInput = document.getElementById('place_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
