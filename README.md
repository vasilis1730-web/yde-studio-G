# ΥΔΕ Studio G

Online εφαρμογή για μελέτη ηλεκτρικών εγκαταστάσεων, πίνακες και υποπίνακες, δημοτικό φωτισμό, ελέγχους και παραγωγή επίσημων εντύπων ΥΔΕ.

## Υποδομή

- GitHub Pages για τη στατική εφαρμογή.
- Supabase project: `promitheies-dimou-rodou`.
- Supabase Auth με προσωπικό email και κωδικό.
- PostgreSQL με Row Level Security: κάθε μηχανικός βλέπει μόνο τα δικά του έργα ή έργα που του έχουν κοινοποιηθεί.
- Ιδιωτικό Storage bucket `yde-documents`.

## Εγκατάσταση

1. Εκτέλεση του `supabase/yde_schema.sql` στο Supabase SQL Editor.
2. Δημιουργία χρήστη Auth `vasilis1730@gmail.com`, εφόσον δεν υπάρχει.
3. Ανέβασμα του `index.html` στη ρίζα του repository.
4. GitHub Settings → Pages → Deploy from a branch → `main` / root.

## Ασφάλεια

Το publishable key επιτρέπεται να βρίσκεται στον browser. Η προστασία των δεδομένων βασίζεται στο Supabase Auth και στις πολιτικές RLS. Δεν επιτρέπεται να τοποθετηθεί `service_role` ή secret key στο HTML.

- Online/Auth integration: v3.9.0
- Application core: v3.8.3
