const fs = require('fs');
const dotenv = require('dotenv');
const envConfig = dotenv.parse(fs.readFileSync('.env'));

const file = `
export const environment = {
  production: true,
  ${Object.entries(envConfig)
    .map(([key, val]) => `${key}: "${val}"`)
    .join(',\n  ')}
};
`;

fs.writeFileSync('./src/environments/environment.prod.ts', file);
console.log('✅ Environment file generated.');
