# Εγκατάσταση ΥΔΕ Studio G

## 1. Δημιουργία πρώτου χρήστη

Στο Supabase project `promitheies-dimou-rodou`:

1. Authentication → Users.
2. Add user.
3. Email: `vasilis1730@gmail.com`.
4. Ορίστε ισχυρό προσωπικό κωδικό και επιβεβαιώστε τον χρήστη.

## 2. Εγκατάσταση βάσης

1. SQL Editor → New query.
2. Αντιγράψτε ολόκληρο το `supabase/yde_schema.sql`.
3. Πατήστε Run.
4. Βεβαιωθείτε ότι ολοκληρώθηκε χωρίς error.

Το SQL δημιουργεί μόνο αντικείμενα με πρόθεμα `yde_` και δεν τροποποιεί τους πίνακες της εφαρμογής προμηθειών. Αφαιρεί επίσης τυχόν παλιά ανοικτή πολιτική `yde_anon_all`.

## 3. Auth URL Configuration

Authentication → URL Configuration:

- Site URL: `https://vasilis1730-web.github.io/yde-studio-G/`
- Redirect URL: `https://vasilis1730-web.github.io/yde-studio-G/`

## 4. Δημοσίευση

1. Ανεβάστε το `index.html` στη ρίζα του repository.
2. Settings → Pages.
3. Source: Deploy from a branch.
4. Branch: `main`.
5. Folder: `/ (root)`.

## 5. Πρώτος έλεγχος

1. Ανοίξτε την online διεύθυνση.
2. Συνδεθείτε με `vasilis1730@gmail.com`.
3. Δημιουργήστε δοκιμαστικό έργο.
4. Κάντε αποσύνδεση/σύνδεση και ελέγξτε ότι το έργο επανέρχεται από το cloud.
