-- Generated from docs/card-image-verified.csv.
-- Only rows marked as verified are mapped to card_catalog.image_url.

UPDATE card_catalog
SET image_url = NULL
WHERE image_url IS NOT NULL;

