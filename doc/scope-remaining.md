# Top-level scope items

1. PDF Export of training plan 🌟 (goes next)
   1. https://github.com/blocknotes/prawn-html
   2. https://github.com/mileszs/wicked_pdf
   3. https://github.com/Studiosity/grover
2. Subscriptions handling
3. Shop / Offer
   - Static assets (link or file) -> No survey followup
   - Dynamic assets (dedicated training plan, dedicated diet) -> Survey followup
   - Accepting payments as trainer (implement flow) 🌟
4. Surveys - @JC
5. Tracked metrics - @KP
   1. Goals
6. SSO (FB/Google)
7. Training creator
   - Tailwind ✅
   - Exercise selection
8. Translations (PL, EN) 🌟
9. Translations (ES)
10. Staging environment
11. Secure sidekiq
12. Admin Interface 🌟
13. Cypress -> CI/CD 🌟
14. app/www/subdomains separation
15. Landing page
  - Details
    - O mnie, zdjęcie + tekst
    - Social Media - facebook, instagram, youtube
    - Logo lub Title/Subtitle
  - Kontakt / wyślij wiadomość, email na który ma iść
  - Metamorfozy, 2 zdjęcia, tytuł (imię), opis
    - Managed the same way as FAQ -> need to parametrize identifier (id vs position)
    - Use acts_as_list or something of this sort -> RubyToolbox (linked-list vs positions)
    - Possible need to use FormObject to pass new_position
    - Extras: Crop
    - Extras: Click to edit
  - Kontakt / wyślij wiadomość, email na który ma iść
    - Opinie -> treść, podpis
    - Oferta -> tytuł, opis WYSIWYG
    - Newsletter
    - Hero
    - Galeria
    - Video
    - Cookies
    - FAQ
  - Cookies notification

## Experimental

- Explore cloudflare to generate certs automatically
- Hotwire / Stimulus
  - https://docs.stimulusreflex.com/
  - Adding metrics -> Turbo
  - Previewing full domain -> Stimulus
- Importmaps
- Scrape TrueCoach for exercises ✅
- Screpe LepszyTrener for trainers ✅
- QR Code in PDF export
