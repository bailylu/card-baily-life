-- Reset unverified automated card-face matches.
-- Only manually confirmed files in static/images/cards/verified/ should be mapped to card_catalog.image_url.

UPDATE card_catalog
SET image_url = NULL
WHERE image_url IS NOT NULL;
