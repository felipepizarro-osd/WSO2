const axios = require('axios');
const base64 = require('base64-js');

const tokenEndpoint = 'https://localhost:9443/oauth2/token';
const clientId = 'mkK5w5kj188g86e2vCd8sROCsMca';
const clientSecret = 'j9ljNmJQtfW6ufquUOZhqoNwV1oa';
const username = 'Felipe';
const password = 'Tomas1998';
const scope = 'internal_login';

// Construir las credenciales del cliente en base64
const clientCredentials = base64.fromByteArray(new TextEncoder().encode(`${clientId}:${clientSecret}`));

// Construir las credenciales del usuario en base64
const userCredentials = base64.fromByteArray(new TextEncoder().encode(`${username}:${password}`));


// Configurar la solicitud de token
const config = {
    method: 'post',
    url: tokenEndpoint,
    headers: {
      'Authorization': `Basic ${clientCredentials}`,
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    data: `grant_type=password&username=${username}&password=${password}&scope=${scope}`,
    httpsAgent: new (require('https').Agent)({ rejectUnauthorized: false }),  // Ignorar verificación de certificado SSL (solo para desarrollo)
  };  

// Realizar la solicitud al servidor OAuth2
axios(config)
  .then((response) => {
    console.log('Token de acceso:', response.data.access_token);
  })
  .catch((error) => {
    console.error('Error al obtener el token de acceso:', error.message);
    if (error.response) {
      console.error('Respuesta del servidor:', error.response.data);
    }
  });
