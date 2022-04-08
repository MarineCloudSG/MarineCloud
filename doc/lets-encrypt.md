# Cert renewal procedure

- `brew install certbot`
- Get ACME challenge
  - `sudo certbot certonly --server https://acme-v02.api.letsencrypt.org/directory --manual --preferred-challenges dns -d "*.marinecloud.pro"`
- [Go to DNS config](https://ap.www.namecheap.com/Domains/DomainControlPanel/marinecloud.pro/advancedns)
- Add a TXT record as requested ([manual](https://medium.com/@cubxi/add-wildcard-lets-encrypt-certifications-with-namecheap-6a466df0886f))
  - Verify if it was deployed [here](https://toolbox.googleapps.com/apps/dig/#TXT/_acme-challenge.marinecloud.pro.) before proceeding
- Proceed with certbot so it can pull the certificate
- Upload custom certificate to [Heroku app](https://dashboard.heroku.com/apps/smarter-coach/settings)
  - `sudo cp /etc/letsencrypt/live/marinecloud.pro/fullchain.pem ./`
  - `sudo cp /etc/letsencrypt/live/marinecloud.pro/privkey.pem ./`
- Ensure the wildcard domain is configured with added certificate
