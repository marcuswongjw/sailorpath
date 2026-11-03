-- Migration 177: Import YAI Junior National Sailing Championship 2023
--
-- Imports the official national championship results for:
-- Event: YAI Junior National Sailing Championship 2023
-- Venue: Colaba, Mumbai, India
-- Dates: 06 – 12 October 2023
-- Authority: Yachting Association of India (YAI)
-- Scope: 6 Fleets (82 total entries across 29er, 420, ILCA 4, ILCA 6, Optimist), 10 races, 1 discard
--
-- Source: https://www.yai.org.in / Official PDF: youth_nationals_2023.pdf
-- Corroborated visually against official YAI PDF pages rendered to high-resolution PNG screenshots in scripts/imports/india-2023/screenshots/
--
-- All operations execute in a single atomic transaction.

BEGIN;

-- 1. Insert New Verified Sailor Profiles
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '745f5d98-5f87-55f5-b859-fbca3967e51a', 'Sunil Mudavath', 'sunil-mudavath-1bf8f1', 'IND 88', 'NBSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c239d874-d349-509e-9970-ad296063d431', 'Satyam Jha', 'satyam-jha-742ebc', 'IND 88', 'NBSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'df6ea2f4-115a-5f4f-a954-754ca72087f8', 'Nikhil Dilip Mandavkar', 'nikhil-dilip-mandavkar-781f42', 'IND 38', 'NBSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '35a44f19-8c9e-5c6d-9b21-a7b6685217fd', 'Karrolla Karthik', 'karrolla-karthik-30f263', 'IND 38', 'NBSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4246d57f-f295-5d18-b636-4b02ef32bccb', 'Vikram Singh Bhati', 'vikram-singh-bhati-b0e6e5', 'IND 2501', 'NBSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '02e164ea-fc0f-5b0a-8fec-4062ccbbe587', 'Shivam Waimiki', 'shivam-waimiki-73c905', 'IND 2501', 'NBSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '02554633-79ed-57ea-a700-b310ebc2f15b', 'Laveti Dharani', 'laveti-dharani-bb8f7b', 'IND 55426', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2aef5a59-403d-52e2-8be8-11f72c8dd947', 'Vadla Mallesh', 'vadla-mallesh-020dd0', 'IND 55426', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '921d8704-688c-5561-8d1d-562bb7e78420', 'Kameshwar Thanuja', 'kameshwar-thanuja-70e843', 'IND 54657', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '40c74def-6c0c-5985-a42b-a1e4064bbc3a', 'Akhil Pilli', 'akhil-pilli-2b90e6', 'IND 54657', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4d4f65b6-cb72-5665-b991-427a6f366a95', 'V Vaishnavi', 'v-vaishnavi-48cc91', 'IND 54658', 'YCH', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fc48eca4-6512-5419-b24d-a467d53d049b', 'Ittamalla Pranay', 'ittamalla-pranay-8ebe97', 'IND 54658', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '739179be-4c34-5be7-b788-b2e31b538808', 'Akshat Kumar Dohare', 'akshat-kumar-dohare-99b6ab', 'IND 210444', 'NSS', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ea2ee90c-6754-5b42-9c0a-75913a8edcb1', 'Padidala Vishwanath', 'padidala-vishwanath-f45b68', 'IND 222622', 'NBSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0dfd0784-1bca-5040-933c-b8ad1bd6c7b1', 'Shashank Batham', 'shashank-batham-6c0ebb', 'IND 210439', 'NSS', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ad1d4917-aefc-51fc-bbaa-b873e2f0e5cc', 'Ajay Yadav', 'ajay-yadav-89d401', 'IND 210440', 'NSS', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '48aa3e25-de82-5150-8da6-b05712dd48af', 'Sravan Katravath', 'sravan-katravath-1f52a2', 'IND 209822', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '822782c6-7d91-5f83-8349-7dbfe4cb6fc3', 'Ramakant', 'ramakant-6dcfda', 'IND 222649', 'NBSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f331f5f5-3437-5b24-82c3-7d8443afe997', 'M S Daniel', 'm-s-daniel-c275c0', 'IND 163225', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0d1750f4-405d-55de-89d9-8dd1c0d574c7', 'I Pranay', 'i-pranay-889b94', 'IND 147865', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1edd53ac-c4a7-5538-8119-c901e7a2e2c2', 'Peerkatla Ganesh', 'peerkatla-ganesh-403d3e', 'IND 197841', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9356d53e-42e7-5324-af15-2caf616e6b7f', 'M Deepak Kumar', 'm-deepak-kumar-bb64ea', 'IND 152064', 'TNSA', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8dd01420-2656-549c-b76b-ed8f5ec57476', 'Krishna Govinda Ashyanth', 'krishna-govinda-ashyanth-bf6af0', 'IND 185629', 'TNSA', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5a6ab7be-18c0-5841-b1a8-8f18b4ab775b', 'Veera Vamasham Vaishnavi', 'veera-vamasham-vaishnavi-f8eb4e', 'IND 197847', 'YCH', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'eff0fe49-b3da-5a1c-a71b-f997f26b3e48', 'Alia Sabreen Faisal', 'alia-sabreen-faisal-c6b40a', 'IND 214786', 'TNSA', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3f952097-bd0a-501d-aaff-0c3e7c6a6e74', 'Divyanshi Mishra', 'divyanshi-mishra-1200d9', 'IND 210438', 'NSS', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '29d29e46-bea6-5bcc-a14f-b898629e9646', 'Somya Singh Patel', 'somya-singh-patel-801cfe', 'IND 210431', 'NSS', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '144b7c3f-1992-593c-b156-fa6e4954f5af', 'Aarya Roate', 'aarya-roate-edbffe', 'IND 197403', 'RBYC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bd2ddfca-1ddb-5172-a272-edf48685e611', 'Sikhansu Singh', 'sikhansu-singh-7ec07a', 'IND 212153', 'TSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a716d83e-5551-5761-8cd0-e2b8218a7dec', 'Rammilan Yadav', 'rammilan-yadav-61ab4b', 'IND 210441', 'NSS', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '853c502f-5b33-50fe-a8e7-7ee78f905ed8', 'Sachin', 'sachin-461f70', 'IND 222622', 'NBSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '372767de-f4a5-5ac2-9a74-38cdfd7fdd86', 'Aryan Harshayana', 'aryan-harshayana-19b24b', 'IND 207336', 'CESC/TSC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '89b21fbd-44e8-5c2e-a1c3-f679bf415eb4', 'Kalaimuthu C', 'kalaimuthu-c-bc4bd0', 'IND 212674', 'INWTC(M)', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4169ee8d-16da-57a3-b36d-e4961251a34d', 'Sumant Arunachalam', 'sumant-arunachalam-66a60d', 'IND 138437', 'TNSA', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ab6a8ecb-a0dd-5460-ae23-14f9171e6f1c', 'Mandeep', 'mandeep-a93c62', 'IND 210448', 'YAM', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd3cee486-e212-55da-a651-a9f268c665ed', 'Luv Sakpal', 'luv-sakpal-a701d6', 'IND 200430', 'RBYC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '84183f52-8b49-524f-8360-d3d21296af5e', 'Pareekshit Nair', 'pareekshit-nair-400180', 'IND 202013', 'CESC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a7a93e31-4175-52c5-8c06-465fc1825719', 'Ritika Dangi', 'ritika-dangi-83c4d7', 'IND 210442', 'NSS', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '984587f3-ef91-53ad-9924-ec1b10d13d4c', 'Aakash Tangai', 'aakash-tangai-2517d1', 'IND 1674', 'CESC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5b44e5a5-c1c5-5288-a10b-7a4163cc2325', 'MD Riziwan', 'md-riziwan-98f59d', 'IND 1497', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6d759e50-2fcc-5224-90ba-7e250783614f', 'Palerrla Govardhan', 'palerrla-govardhan-45983e', 'IND 4002', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '12eea3c7-a3f1-52e0-a805-156f9fe959a6', 'Anshu Yadav', 'anshu-yadav-b4ff62', 'IND 1119', 'NSS', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '54171aa7-0d57-5a89-8494-788e8a7ae268', 'Aarti Verma', 'aarti-verma-420375', 'IND 1627', 'CESC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '79c504af-d2f8-5d7c-be5b-2b568d79aafa', 'Parth Singh Chouhan', 'parth-singh-chouhan-e51fb8', 'IND 1116', 'NSS', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ff0c5e0e-a62e-57f7-90fe-cbccc02216b8', 'Akshay Kumar Narayan', 'akshay-kumar-narayan-a82aa3', 'IND 1598', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4cdb0d0e-8efc-562d-bcb9-563bed0079eb', 'Kommaravelly Lahari', 'kommaravelly-lahari-f818f0', 'IND 1494', 'YCH', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ae8a7ace-e53c-5819-9bf0-a4eb7f03dac2', 'Dhruva S Marathe', 'dhruva-s-marathe-d94a92', 'IND 2302', 'CESC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'dffc73da-efec-5a02-bdb5-1d95a7607ecc', 'Vivan Kudale', 'vivan-kudale-08862a', 'IND 1635', 'RBYC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '98b02ce5-6ecd-5cf6-99e1-d66e78c0f9ac', 'Freyana Driver', 'freyana-driver-8baf90', 'IND 2113', 'RBYC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '25b634be-2ebc-54d9-bfa6-3b2b38bc63cf', 'Sanjana Bhasin', 'sanjana-bhasin-3f2c24', 'IND 1815', 'RBYC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f7ee9c46-2640-5a20-839e-18d0cc3c4c9a', 'Rudhresh Singh Patel', 'rudhresh-singh-patel-7b174c', 'IND 1557', 'NSS', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a9fe20b8-d1c2-5288-aced-a6d5db0a4ec4', 'Bindu Rathlawath', 'bindu-rathlawath-5fb464', 'IND 1690', 'YCH', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'cdaccd8d-fdc2-5833-acbe-f7ac18d418e0', 'D Sathwik', 'd-sathwik-d0c5bb', 'IND 1691', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '32bdbc2f-2215-5554-9ba0-d9746e6dfb33', 'Samaira Chanda', 'samaira-chanda-197392', 'IND 1455', 'RBYC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0df11c37-a105-509b-a443-38ed87cb9b92', 'D Vinod', 'd-vinod-9aa8ef', 'IND 1600', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8e75283e-7dcc-57b2-b087-e1f651809ad9', 'M Jeevankumar', 'm-jeevankumar-26b9ec', 'IND 1457', 'TNSA', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7a484f50-d34b-531d-a004-b86c7b0b59f8', 'Bandaram Sahith', 'bandaram-sahith-782297', 'IND 4001', 'YCH', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '46da83a6-e46b-5c98-992b-e493747f67d1', 'Thaneesha J', 'thaneesha-j-034ef4', 'IND 1181', 'TNSA', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a22341c9-2e7b-5530-8c69-f12ee8815413', 'Krithika Vishwanathan', 'krithika-vishwanathan-014294', 'IND 1584', 'SSC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '50256b4d-909d-5016-bda7-8cd6548f0a2a', 'Krishna Venkitachalam R', 'krishna-venkitachalam-r-77a386', 'IND 1665', 'RMYC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1086f572-4d3c-5707-926a-1f89c1684cf9', 'Tattari Chandralekha', 'tattari-chandralekha-35b21b', 'IND 4003', 'YCH', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b038d5d0-1017-50f5-bc1d-831649d9572b', 'Agastya Damisetty', 'agastya-damisetty-ba6c90', 'IND 1588', 'EMESA', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ed84f1ed-2e5e-527b-ba8b-3fd90ba90c16', 'Diya Patel', 'diya-patel-38c23e', 'IND 1587', 'SSC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '68264e0b-54d4-5475-9f06-8d1dcaa3256c', 'Aadya Sachdeva', 'aadya-sachdeva-5428fa', 'IND 2109', 'RBYC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c6b8041c-e57c-5a46-b765-5eca5fb128b3', 'Kshitij Sharma', 'kshitij-sharma-21c65f', 'IND 1818', 'INWTC(M)', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b3080664-91e0-5fa5-b1d2-dd40df9ab891', 'Arjun S Marathe', 'arjun-s-marathe-991b62', 'IND 1626', 'CESC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2e2b0b39-611e-5b08-9de6-753dfdf87ab5', 'Prateek Pal', 'prateek-pal-dd1359', 'IND 1514', 'INWTC(M)', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '74fe0973-488a-5981-9f54-d48d35a4eb25', 'Darayus JKaranjia', 'darayus-jkaranjia-28e781', 'IND 2101', 'RBYC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a41305c2-1e79-599a-9ead-bee0926e49aa', 'Shravan Jadhav', 'shravan-jadhav-f578af', 'IND 2301', 'CESC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0174d45a-000d-5176-90fc-c0dcd92badf9', 'Shriya Kothari', 'shriya-kothari-bbc46f', 'IND 2111', 'RBYC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0bb587a1-e220-5ce4-b2ec-c6eeadc17ba3', 'Jagrav Kumar', 'jagrav-kumar-442046', 'IND 1563', 'NSS', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9ac68cb3-a59d-5e92-9d58-01f4cca97f22', 'Sarthak Pilane', 'sarthak-pilane-c328f5', 'IND 1630', 'CESC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '67d70a56-664a-5111-9c3b-3fe9adc995ca', 'Samaira Tandon', 'samaira-tandon-026ca3', 'IND 1515', 'CESC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a7488395-0299-52a4-9a1f-02af0e3fbc4f', 'Shivansh Pandya', 'shivansh-pandya-25f36f', 'IND 1233', 'RBYC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '378ddb93-2062-544c-ab39-a23ddebc9f86', 'M K Pragathi', 'm-k-pragathi-0620b0', 'IND 1478', 'TNSA', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd65b165e-0304-5443-aa22-547381da8bbb', 'Lakshya C', 'lakshya-c-6a00c9', 'IND 1583', 'RBYC', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3d5983cf-3670-55a9-bd5a-103948dc8828', 'Amya Kumar', 'amya-kumar-328b77', 'IND 1306', 'NSS', 'IND', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '92851a0b-1840-5bca-88a8-513db7a417ab', 'Jehan Hansotia', 'jehan-hansotia-5dee9e', 'IND 2106', 'RBYC', 'IND', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);

-- 2. Create Parent Regatta Event
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer,
    classes, nor_url, created_at, updated_at
) VALUES (
    '93e96191-c247-5264-9b88-1d21dc4b61ef',
    'YAI Junior National Sailing Championship 2023',
    'yai-junior-national-championship-2023',
    '2023-10-06',
    '2023-10-12',
    'Colaba, Mumbai, India',
    'Yachting Association of India (YAI)',
    '["29er", "420", "ILCA 4", "ILCA 6", "optimist"]'::jsonb,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    updated_at = clock_timestamp();

-- Sheet: YAI Junior National Sailing Championship 2023 — 29er
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '1ac98c0d-a61b-5da3-88f0-278294b8845d',
    '93e96191-c247-5264-9b88-1d21dc4b61ef',
    'YAI Junior National Sailing Championship 2023 — 29er',
    'yai-junior-national-championship-2023-29er-c5f506',
    '2023-10-12',
    '2023-10-12',
    3,
    'Open',
    10,
    'IND',
    '29er',
    'crew',
    2,
    2,
    false,
    'Colaba, Mumbai, India',
    'Yachting Association of India (YAI)',
    'published',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Official Results youth_nationals_2023.pdf',
    'YAI Junior National Sailing Championship 2023 at Colaba, Mumbai. 10 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', '745f5d98-5f87-55f5-b859-fbca3967e51a', '1ac98c0d-a61b-5da3-88f0-278294b8845d', 'Sunil Mudavath & Satyam Jha', '88', 'crew', 1,
    13.0, 9.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Helm: Sunil Mudavath, Crew: Satyam Jha. Club: NBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '72c1ac8d-63f4-5896-bdea-4ef4621670b3', '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', '745f5d98-5f87-55f5-b859-fbca3967e51a', 'Sunil Mudavath', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '313f745a-a284-5135-a6ae-64642f07218c', '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 'c239d874-d349-509e-9970-ad296063d431', 'Satyam Jha', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 8, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 9, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03cf12cc-a6bc-5fc9-89e4-07b5c054976f', 10, 4.0, 'DNC', true, '(4.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 'df6ea2f4-115a-5f4f-a954-754ca72087f8', '1ac98c0d-a61b-5da3-88f0-278294b8845d', 'Nikhil Dilip Mandavkar & Karrolla Karthik', '38', 'crew', 2,
    26.0, 22.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Helm: Nikhil Dilip Mandavkar, Crew: Karrolla Karthik. Club: NBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4a2ad130-ae98-5d59-a1d3-9641131fa2dc', '93654966-d868-5a4d-831f-ce544c1e4328', 'df6ea2f4-115a-5f4f-a954-754ca72087f8', 'Nikhil Dilip Mandavkar', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '56cce0e1-b66e-5469-afe0-0fd34357c772', '93654966-d868-5a4d-831f-ce544c1e4328', '35a44f19-8c9e-5c6d-9b21-a7b6685217fd', 'Karrolla Karthik', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 8, 4.0, 'DNS', true, '(4.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 9, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93654966-d868-5a4d-831f-ce544c1e4328', 10, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', '4246d57f-f295-5d18-b636-4b02ef32bccb', '1ac98c0d-a61b-5da3-88f0-278294b8845d', 'Vikram Singh Bhati & Shivam Waimiki', 'IND 2501', 'crew', 3,
    37.0, 33.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Helm: Vikram Singh Bhati, Crew: Shivam Waimiki. Club: NBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f06bb957-3912-5161-b217-9104fb34cab6', 'ada9f1f5-7930-58f9-83b3-4ef27289d635', '4246d57f-f295-5d18-b636-4b02ef32bccb', 'Vikram Singh Bhati', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '328a9844-fe94-5f80-8229-7d6118f09549', 'ada9f1f5-7930-58f9-83b3-4ef27289d635', '02e164ea-fc0f-5b0a-8fec-4062ccbbe587', 'Shivam Waimiki', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', 3, 4.0, 'RET', true, '(4.0 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', 4, 4.0, 'DNS', false, '4.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', 5, 4.0, 'DNF', false, '4.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', 7, 4.0, 'RET', false, '4.0 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', 8, 4.0, 'DNS', false, '4.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', 9, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ada9f1f5-7930-58f9-83b3-4ef27289d635', 10, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: YAI Junior National Sailing Championship 2023 — 420
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '6cf5f7a0-13a4-5c0d-9691-d2130f7caa92',
    '93e96191-c247-5264-9b88-1d21dc4b61ef',
    'YAI Junior National Sailing Championship 2023 — 420',
    'yai-junior-national-championship-2023-420-433742',
    '2023-10-12',
    '2023-10-12',
    3,
    'Open',
    10,
    'IND',
    '420',
    'crew',
    2,
    2,
    false,
    'Colaba, Mumbai, India',
    'Yachting Association of India (YAI)',
    'published',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Official Results youth_nationals_2023.pdf',
    'YAI Junior National Sailing Championship 2023 at Colaba, Mumbai. 10 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', '02554633-79ed-57ea-a700-b310ebc2f15b', '6cf5f7a0-13a4-5c0d-9691-d2130f7caa92', 'Laveti Dharani & Vadla Mallesh', 'IND 55426', 'crew', 1,
    13.0, 11.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Helm: Laveti Dharani, Crew: Vadla Mallesh. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5c06ceb1-8712-5284-a69a-981c3939ccf2', '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', '02554633-79ed-57ea-a700-b310ebc2f15b', 'Laveti Dharani', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e78377af-56b5-5531-a450-7a17dee9b982', '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', '2aef5a59-403d-52e2-8be8-11f72c8dd947', 'Vadla Mallesh', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', 1, 2.0, NULL, true, '(2.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', 8, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', 9, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66462fb9-88dd-5dd1-b7dd-f1fb5ecea73a', 10, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', '921d8704-688c-5561-8d1d-562bb7e78420', '6cf5f7a0-13a4-5c0d-9691-d2130f7caa92', 'Kameshwar Thanuja & Akhil Pilli', 'IND 54657', 'crew', 2,
    17.0, 15.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Helm: Kameshwar Thanuja, Crew: Akhil Pilli. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1ca77cd3-cd00-52c2-b3cd-0d2e8985438b', '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', '921d8704-688c-5561-8d1d-562bb7e78420', 'Kameshwar Thanuja', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5d8a2085-b947-55e0-a75d-d44e0916429b', '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', '40c74def-6c0c-5985-a42b-a1e4064bbc3a', 'Akhil Pilli', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', 4, 2.0, NULL, true, '(2.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', 8, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', 9, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44d4dd12-e0b5-5bdf-b6a4-fa7d1c88e915', 10, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', '4d4f65b6-cb72-5665-b991-427a6f366a95', '6cf5f7a0-13a4-5c0d-9691-d2130f7caa92', 'V Vaishnavi & Ittamalla Pranay', 'IND 54658', 'crew', 3,
    40.0, 36.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Helm: V Vaishnavi, Crew: Ittamalla Pranay. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e9d9b22b-4489-56d6-b6fe-79febd85f3aa', '9e696b27-66de-5ff7-af87-9385962fcd60', '4d4f65b6-cb72-5665-b991-427a6f366a95', 'V Vaishnavi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '61fde4d1-a680-546d-b5d3-38089bd70928', '9e696b27-66de-5ff7-af87-9385962fcd60', 'fc48eca4-6512-5419-b24d-a467d53d049b', 'Ittamalla Pranay', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', 1, 4.0, 'DNC', true, '(4.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', 2, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', 3, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', 4, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', 5, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', 6, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', 7, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', 8, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', 9, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9e696b27-66de-5ff7-af87-9385962fcd60', 10, 4.0, 'DNC', false, '4.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: YAI Junior National Sailing Championship 2023 — ILCA 4 (Boys)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '84caf766-3cce-502a-aacd-cd6451ee0c5a',
    '93e96191-c247-5264-9b88-1d21dc4b61ef',
    'YAI Junior National Sailing Championship 2023 — ILCA 4 (Boys)',
    'yai-junior-national-championship-2023-ilca-4-boys-32db73',
    '2023-10-12',
    '2023-10-12',
    11,
    'Boys',
    10,
    'IND',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Colaba, Mumbai, India',
    'Yachting Association of India (YAI)',
    'published',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Official Results youth_nationals_2023.pdf',
    'YAI Junior National Sailing Championship 2023 at Colaba, Mumbai. 10 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', '739179be-4c34-5be7-b788-b2e31b538808', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'Akshat Kumar Dohare', '210444', 'individual', 1,
    25.0, 20.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Akshat Kumar Dohare. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5c50b25d-6e0f-5281-a957-0e8f499b2afb', 'cd304aae-8f32-5ab5-bc49-99133523187a', '739179be-4c34-5be7-b788-b2e31b538808', 'Akshat Kumar Dohare', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', 6, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', 7, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', 8, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', 9, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd304aae-8f32-5ab5-bc49-99133523187a', 10, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 'ea2ee90c-6754-5b42-9c0a-75913a8edcb1', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'Padidala Vishwanath', '222622', 'individual', 2,
    25.0, 20.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Padidala Vishwanath. Club: NBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0138e55e-329b-5189-8c29-95e62c18383d', '4b0a452c-5ee2-504d-9075-052fde12d810', 'ea2ee90c-6754-5b42-9c0a-75913a8edcb1', 'Padidala Vishwanath', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 8, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 9, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b0a452c-5ee2-504d-9075-052fde12d810', 10, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', '0dfd0784-1bca-5040-933c-b8ad1bd6c7b1', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'Shashank Batham', 'IND 210439', 'individual', 3,
    27.0, 23.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Shashank Batham. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1592e816-ccc0-5cda-ac40-0cdd1a4d7528', '808dc9df-ef85-5dbe-b8d0-95812301d02f', '0dfd0784-1bca-5040-933c-b8ad1bd6c7b1', 'Shashank Batham', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', 1, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', 7, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', 8, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', 9, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '808dc9df-ef85-5dbe-b8d0-95812301d02f', 10, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 'ad1d4917-aefc-51fc-bbaa-b873e2f0e5cc', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'Ajay Yadav', '210440', 'individual', 4,
    34.0, 27.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Ajay Yadav. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f1a95d7e-c551-5fe1-8d44-2bc6aa529e66', 'a36d1df9-613e-557d-a295-ff1748234ed7', 'ad1d4917-aefc-51fc-bbaa-b873e2f0e5cc', 'Ajay Yadav', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 3, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 8, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 9, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a36d1df9-613e-557d-a295-ff1748234ed7', 10, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', '48aa3e25-de82-5150-8da6-b05712dd48af', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'Sravan Katravath', '209822', 'individual', 5,
    52.0, 45.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Sravan Katravath. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '73fe1a65-4013-5426-b2bd-a2e044b79b9b', '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', '48aa3e25-de82-5150-8da6-b05712dd48af', 'Sravan Katravath', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', 7, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', 8, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', 9, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dc9aa38-3c86-5816-91cf-2efbc65d3a6f', 10, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', '822782c6-7d91-5f83-8349-7dbfe4cb6fc3', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'Ramakant', '222649', 'individual', 6,
    61.0, 49.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Ramakant. Club: NBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fab34c25-bcd5-5df0-a24c-bb9d152aa216', 'd728d770-6f05-583f-a56e-f2b113e7ee4f', '822782c6-7d91-5f83-8349-7dbfe4cb6fc3', 'Ramakant', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', 2, 12.0, 'DSQ', true, '(12.0 DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', 7, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', 8, 9.0, 'SCP', false, '9.0 SCP'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', 9, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd728d770-6f05-583f-a56e-f2b113e7ee4f', 10, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 'f331f5f5-3437-5b24-82c3-7d8443afe997', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'M S Daniel', 'IND 163225', 'individual', 7,
    67.0, 59.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: M S Daniel. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2a449af8-1aab-5f71-825a-c108df985206', 'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 'f331f5f5-3437-5b24-82c3-7d8443afe997', 'M S Daniel', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 1, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 7, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 8, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 9, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f729185f-c4d9-5212-b1e0-78eb3ea99c92', 10, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', '0d1750f4-405d-55de-89d9-8dd1c0d574c7', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'I Pranay', 'IND 147865', 'individual', 8,
    86.0, 76.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: I Pranay. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '66c851f0-9547-53f8-a008-d62bd8f00cf7', 'a733a94c-da72-519d-92ab-0c5b7d872a3f', '0d1750f4-405d-55de-89d9-8dd1c0d574c7', 'I Pranay', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', 6, 10.0, NULL, true, '(10.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', 7, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', 8, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', 9, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a733a94c-da72-519d-92ab-0c5b7d872a3f', 10, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', '1edd53ac-c4a7-5538-8119-c901e7a2e2c2', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'Peerkatla Ganesh', 'IND 197841', 'individual', 9,
    88.0, 78.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Peerkatla Ganesh. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6a2cca1a-e2d4-5cad-a476-ae07ec3380c5', '8ea1ce3e-d18d-597e-81d3-f24954b60c37', '1edd53ac-c4a7-5538-8119-c901e7a2e2c2', 'Peerkatla Ganesh', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', 1, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', 3, 10.0, NULL, true, '(10.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', 7, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', 8, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', 9, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ea1ce3e-d18d-597e-81d3-f24954b60c37', 10, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', '9356d53e-42e7-5324-af15-2caf616e6b7f', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'M Deepak Kumar', 'IND 152064', 'individual', 10,
    91.0, 80.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: M Deepak Kumar. Club: TNSA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2b5362f1-df17-585b-9793-b72d8c53557d', 'cef435b8-c512-5a95-a950-89393b2eceb9', '9356d53e-42e7-5324-af15-2caf616e6b7f', 'M Deepak Kumar', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', 1, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', 7, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', 8, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', 9, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cef435b8-c512-5a95-a950-89393b2eceb9', 10, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', '8dd01420-2656-549c-b76b-ed8f5ec57476', '84caf766-3cce-502a-aacd-cd6451ee0c5a', 'Krishna Govinda Ashyanth', 'IND 185629', 'individual', 11,
    112.0, 100.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Krishna Govinda Ashyanth. Club: TNSA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ccaf9489-a281-5d1f-b164-71b4d042a658', '8c2a8a26-7259-53b8-b33f-5fef262205ca', '8dd01420-2656-549c-b76b-ed8f5ec57476', 'Krishna Govinda Ashyanth', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', 1, 12.0, 'DNF', true, '(12.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', 3, 12.0, 'NSC', false, '12.0 NSC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', 4, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', 5, 12.0, 'DNF', false, '12.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', 7, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', 8, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', 9, 12.0, 'DNF', false, '12.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c2a8a26-7259-53b8-b33f-5fef262205ca', 10, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: YAI Junior National Sailing Championship 2023 — ILCA 4 (Girls)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '97477e3c-73f4-51b0-92b8-45fccca04eb0',
    '93e96191-c247-5264-9b88-1d21dc4b61ef',
    'YAI Junior National Sailing Championship 2023 — ILCA 4 (Girls)',
    'yai-junior-national-championship-2023-ilca-4-girls-b9b16c',
    '2023-10-12',
    '2023-10-12',
    6,
    'Girls',
    10,
    'IND',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Colaba, Mumbai, India',
    'Yachting Association of India (YAI)',
    'published',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Official Results youth_nationals_2023.pdf',
    'YAI Junior National Sailing Championship 2023 at Colaba, Mumbai. 10 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', '5a6ab7be-18c0-5841-b1a8-8f18b4ab775b', '97477e3c-73f4-51b0-92b8-45fccca04eb0', 'Veera Vamasham Vaishnavi', 'IND 197847', 'individual', 1,
    21.0, 17.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Veera Vamasham Vaishnavi. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8b736d34-e8c0-5b11-a409-9064e35df598', 'de3816d9-a02a-5eb8-97cf-848044ce626d', '5a6ab7be-18c0-5841-b1a8-8f18b4ab775b', 'Veera Vamasham Vaishnavi', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', 8, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', 9, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de3816d9-a02a-5eb8-97cf-848044ce626d', 10, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48', '97477e3c-73f4-51b0-92b8-45fccca04eb0', 'Alia Sabreen Faisal', 'IND 214786', 'individual', 2,
    23.0, 20.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Alia Sabreen Faisal. Club: TNSA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7aef69c4-1d2a-5e6a-83cb-fd3fb7459d6c', 'f486cdc3-c999-5ee1-a022-dd8c01331309', 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48', 'Alia Sabreen Faisal', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 6, 3.0, NULL, true, '(3.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 8, 7.0, 'DNE', false, '7.0 DNE'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 9, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f486cdc3-c999-5ee1-a022-dd8c01331309', 10, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', '3f952097-bd0a-501d-aaff-0c3e7c6a6e74', '97477e3c-73f4-51b0-92b8-45fccca04eb0', 'Divyanshi Mishra', 'IND 210438', 'individual', 3,
    27.0, 22.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Divyanshi Mishra. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f1ddd119-ae0b-5846-a78e-981b9bd8c684', '2b682389-b114-5654-9ea0-06e111b13774', '3f952097-bd0a-501d-aaff-0c3e7c6a6e74', 'Divyanshi Mishra', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', 7, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', 8, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', 9, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b682389-b114-5654-9ea0-06e111b13774', 10, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', '29d29e46-bea6-5bcc-a14f-b898629e9646', '97477e3c-73f4-51b0-92b8-45fccca04eb0', 'Somya Singh Patel', 'IND 210431', 'individual', 4,
    42.0, 36.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Somya Singh Patel. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '03faf172-b099-5054-9e03-965bab3b21a4', 'c7ed6e63-cb37-58aa-a83a-2b322cf13120', '29d29e46-bea6-5bcc-a14f-b898629e9646', 'Somya Singh Patel', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', 7, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', 8, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', 9, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7ed6e63-cb37-58aa-a83a-2b322cf13120', 10, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 'a7b69130-87f2-59ad-a0bb-c8f5bcd3f4c8', '97477e3c-73f4-51b0-92b8-45fccca04eb0', 'Maanya Reddy', '209906', 'individual', 5,
    43.0, 37.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Maanya Reddy. Club: SSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '618aed37-dc8d-56d5-8268-31be366cac47', 'e9f54928-9890-53df-ab0b-e53215e6c7eb', 'a7b69130-87f2-59ad-a0bb-c8f5bcd3f4c8', 'Maanya Reddy', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 4, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 7, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 8, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 9, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e9f54928-9890-53df-ab0b-e53215e6c7eb', 10, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', '144b7c3f-1992-593c-b156-fa6e4954f5af', '97477e3c-73f4-51b0-92b8-45fccca04eb0', 'Aarya Roate', 'IND 197403', 'individual', 6,
    55.0, 49.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Aarya Roate. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '89bbb866-9512-5a7b-8edf-3ac69d53b545', 'cf275572-106e-5411-9a62-6d1f298cf10a', '144b7c3f-1992-593c-b156-fa6e4954f5af', 'Aarya Roate', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', 1, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', 7, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', 8, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', 9, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf275572-106e-5411-9a62-6d1f298cf10a', 10, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: YAI Junior National Sailing Championship 2023 — ILCA 6
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '4acebbb3-d519-5646-afa3-a9f0ae5ecee3',
    '93e96191-c247-5264-9b88-1d21dc4b61ef',
    'YAI Junior National Sailing Championship 2023 — ILCA 6',
    'yai-junior-national-championship-2023-ilca-6-eafa39',
    '2023-10-12',
    '2023-10-12',
    10,
    'Open',
    10,
    'IND',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Colaba, Mumbai, India',
    'Yachting Association of India (YAI)',
    'published',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Official Results youth_nationals_2023.pdf',
    'YAI Junior National Sailing Championship 2023 at Colaba, Mumbai. 10 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 'bd2ddfca-1ddb-5172-a272-edf48685e611', '4acebbb3-d519-5646-afa3-a9f0ae5ecee3', 'Sikhansu Singh', '212153', 'individual', 1,
    24.0, 13.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Sikhansu Singh. Club: TSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bcdd3f4d-d252-5f4d-ad42-e7b29bfaa426', 'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 'bd2ddfca-1ddb-5172-a272-edf48685e611', 'Sikhansu Singh', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 8, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 9, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff47e010-5ec6-573c-8a39-c8f9e7a9aefa', 10, 11.0, 'DNC', true, '(11.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 'a716d83e-5551-5761-8cd0-e2b8218a7dec', '4acebbb3-d519-5646-afa3-a9f0ae5ecee3', 'Rammilan Yadav', 'IND 210441', 'individual', 2,
    28.0, 17.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Rammilan Yadav. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fbfcce5f-f4ac-5b42-8392-cd6477fc5d78', 'c5a54870-0e11-53ad-995d-1d721b5ea23e', 'a716d83e-5551-5761-8cd0-e2b8218a7dec', 'Rammilan Yadav', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 8, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 9, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5a54870-0e11-53ad-995d-1d721b5ea23e', 10, 11.0, 'DNC', true, '(11.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', '853c502f-5b33-50fe-a8e7-7ee78f905ed8', '4acebbb3-d519-5646-afa3-a9f0ae5ecee3', 'Sachin', 'IND 222622', 'individual', 3,
    34.0, 29.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Sachin. Club: NBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c8a54217-e9c1-5212-a866-d6b61ab97c05', '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', '853c502f-5b33-50fe-a8e7-7ee78f905ed8', 'Sachin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', 2, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', 7, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', 8, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', 9, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eba6fb3-d58b-50bf-ab6a-3f84453b82fe', 10, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', '372767de-f4a5-5ac2-9a74-38cdfd7fdd86', '4acebbb3-d519-5646-afa3-a9f0ae5ecee3', 'Aryan Harshayana', '207336', 'individual', 4,
    35.0, 30.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Aryan Harshayana. Club: CESC/TSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '37a5e110-48c9-58dc-9adf-a684520f8a20', '75bf4f85-5743-5c7b-b204-e6feb3c094a8', '372767de-f4a5-5ac2-9a74-38cdfd7fdd86', 'Aryan Harshayana', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', 1, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', 7, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', 8, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', 9, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75bf4f85-5743-5c7b-b204-e6feb3c094a8', 10, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', '89b21fbd-44e8-5c2e-a1c3-f679bf415eb4', '4acebbb3-d519-5646-afa3-a9f0ae5ecee3', 'Kalaimuthu C', '212674', 'individual', 5,
    51.0, 45.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Kalaimuthu C. Club: INWTC(M).', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c1af0b4c-f45d-5060-893b-7d8e16031904', '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', '89b21fbd-44e8-5c2e-a1c3-f679bf415eb4', 'Kalaimuthu C', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', 1, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', 7, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', 8, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', 9, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a6a6e2b-62b3-5780-bab2-f6cf8403bf99', 10, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', '4169ee8d-16da-57a3-b36d-e4961251a34d', '4acebbb3-d519-5646-afa3-a9f0ae5ecee3', 'Sumant Arunachalam', 'IND 138437', 'individual', 6,
    59.0, 52.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Sumant Arunachalam. Club: TNSA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9820e802-cf98-55c3-8ed5-0ab1d6edc507', 'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', '4169ee8d-16da-57a3-b36d-e4961251a34d', 'Sumant Arunachalam', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', 1, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', 7, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', 8, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', 9, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b8ff8e8d-4829-5f3b-a0c3-85f6f87fcff0', 10, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 'ab6a8ecb-a0dd-5460-ae23-14f9171e6f1c', '4acebbb3-d519-5646-afa3-a9f0ae5ecee3', 'Mandeep', '210448', 'individual', 7,
    74.0, 65.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Mandeep. Club: YAM.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f2dc213b-e80a-5b66-a2f7-5f21bffc88f9', '00d79a58-3c57-5835-9b4b-078300c6429a', 'ab6a8ecb-a0dd-5460-ae23-14f9171e6f1c', 'Mandeep', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 3, 9.0, NULL, true, '(9.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 7, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 8, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 9, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d79a58-3c57-5835-9b4b-078300c6429a', 10, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 'd3cee486-e212-55da-a651-a9f268c665ed', '4acebbb3-d519-5646-afa3-a9f0ae5ecee3', 'Luv Sakpal', '200430', 'individual', 8,
    83.0, 72.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Luv Sakpal. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '54bac065-609a-5b3f-8dfa-5c1241b52c96', '3063f490-8382-544c-8b93-5c082c829ea3', 'd3cee486-e212-55da-a651-a9f268c665ed', 'Luv Sakpal', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 7, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 8, 11.0, 'RET', true, '(11.0 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 9, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3063f490-8382-544c-8b93-5c082c829ea3', 10, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', '84183f52-8b49-524f-8360-d3d21296af5e', '4acebbb3-d519-5646-afa3-a9f0ae5ecee3', 'Pareekshit Nair', '202013', 'individual', 9,
    84.0, 74.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Pareekshit Nair. Club: CESC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '79ac9104-4445-53f4-90e7-b9055d555fbf', '4202ccc4-5bae-5573-99ea-396cc6a1a420', '84183f52-8b49-524f-8360-d3d21296af5e', 'Pareekshit Nair', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', 1, 10.0, NULL, true, '(10.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', 7, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', 8, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', 9, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4202ccc4-5bae-5573-99ea-396cc6a1a420', 10, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 'a7a93e31-4175-52c5-8c06-465fc1825719', '4acebbb3-d519-5646-afa3-a9f0ae5ecee3', 'Ritika Dangi', 'IND 210442', 'individual', 10,
    93.0, 82.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Ritika Dangi. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cc28fd86-858a-5b79-8686-650f8fba8fbf', 'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 'a7a93e31-4175-52c5-8c06-465fc1825719', 'Ritika Dangi', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 3, 11.0, 'DNC', true, '(11.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 4, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 5, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 6, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 7, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 8, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 9, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd0b9a96-60ca-5c05-b441-8c3250b9248e', 10, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: YAI Junior National Sailing Championship 2023 — Optimist
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'b02f0463-dd38-5814-b204-6931b22cb62c',
    '93e96191-c247-5264-9b88-1d21dc4b61ef',
    'YAI Junior National Sailing Championship 2023 — Optimist',
    'yai-junior-national-championship-2023-optimist-b2c50e',
    '2023-10-12',
    '2023-10-12',
    49,
    'Open',
    10,
    'IND',
    'optimist',
    'individual',
    1,
    1,
    false,
    'Colaba, Mumbai, India',
    'Yachting Association of India (YAI)',
    'published',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Official Results youth_nationals_2023.pdf',
    'YAI Junior National Sailing Championship 2023 at Colaba, Mumbai. 10 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 'a455659e-591a-4932-8a2b-61f559a45a96', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Eklavya Batham', 'IND 1302', 'individual', 1,
    31.0, 18.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Eklavya Batham. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e75e3a06-ac0f-58b6-9ba0-d73e66b8a4ef', 'bffb0d49-8654-57ac-aa5f-f720b117ce60', 'a455659e-591a-4932-8a2b-61f559a45a96', 'Eklavya Batham', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 6, 13.0, NULL, true, '(13.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 8, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 9, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bffb0d49-8654-57ac-aa5f-f720b117ce60', 10, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', '81b1a95a-45c8-4299-a05d-7aeddd0ca6c2', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Sharanya Yuvaraj Jadhav', 'IND 2501', 'individual', 2,
    28.0, 20.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Sharanya Yuvaraj Jadhav. Club: NBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '56fd02e8-f2d1-51cf-9913-47c35a8644b4', '527bc044-8570-5f6b-b9cf-2a6124751a0f', '81b1a95a-45c8-4299-a05d-7aeddd0ca6c2', 'Sharanya Yuvaraj Jadhav', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', 8, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', 9, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '527bc044-8570-5f6b-b9cf-2a6124751a0f', 10, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', '4dbef3ea-81af-429e-9231-615cd1193d1c', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Ajay Gajji', 'IND 2504', 'individual', 3,
    37.0, 29.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Ajay Gajji. Club: NBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '49dddeda-1c3a-5260-a906-ef1da469b375', '238ccfa3-444b-5d59-8c50-0a23144d96f9', '4dbef3ea-81af-429e-9231-615cd1193d1c', 'Ajay Gajji', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', 3, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', 7, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', 8, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', 9, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '238ccfa3-444b-5d59-8c50-0a23144d96f9', 10, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', '984587f3-ef91-53ad-9924-ec1b10d13d4c', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Aakash Tangai', 'IND 1674', 'individual', 4,
    72.0, 58.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Aakash Tangai. Club: CESC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8a6e43c2-af81-590e-908c-333c3e31dc77', 'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', '984587f3-ef91-53ad-9924-ec1b10d13d4c', 'Aakash Tangai', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', 6, 14.0, NULL, true, '(14.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', 7, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', 8, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', 9, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb6492f8-9d86-5661-9e05-c4ccc5e822ae', 10, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 'c17c8a95-4c06-4544-8b84-e789466ecf36', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Bongur Banny', 'IND 1489', 'individual', 5,
    87.0, 66.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Bongur Banny. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '470dc41d-e2a3-55ab-8bbc-263bbbbfaa01', '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 'c17c8a95-4c06-4544-8b84-e789466ecf36', 'Bongur Banny', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 6, 21.0, NULL, true, '(21.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 7, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 8, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 9, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4adc33a3-aabf-541b-a3cd-a276d18c46f3', 10, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 'ff26b05c-8ff8-4175-83cb-82cce1817d7c', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Shagun Jha', 'IND 1114', 'individual', 6,
    106.0, 83.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Shagun Jha. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'db2034b4-57ce-5a7b-8c5c-ef08765e46d1', '75083be6-fa9e-561b-824b-078754f2b0e7', 'ff26b05c-8ff8-4175-83cb-82cce1817d7c', 'Shagun Jha', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 3, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 6, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 7, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 8, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 9, 23.0, NULL, true, '(23.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75083be6-fa9e-561b-824b-078754f2b0e7', 10, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', '5b44e5a5-c1c5-5288-a10b-7a4163cc2325', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'MD Riziwan', 'IND 1497', 'individual', 7,
    139.0, 89.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: MD Riziwan. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c60634df-aeaa-5061-974a-4bb38a1aadbc', '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', '5b44e5a5-c1c5-5288-a10b-7a4163cc2325', 'MD Riziwan', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', 1, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', 2, 50.0, 'DSQ', true, '(50.0DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', 5, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', 6, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', 7, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', 8, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', 9, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a0b8a69-f2d8-560d-b0c0-03457e31e62c', 10, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 'ae136587-161d-4a4b-8240-8c9f04c85eed', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Samriddhi Batham', 'IND 1305', 'individual', 8,
    119.0, 94.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Samriddhi Batham. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1fb37a0c-b34b-5cc3-bcd7-d7945a4bac71', '4a0f4e03-85af-59d2-bed6-7185bec87e52', 'ae136587-161d-4a4b-8240-8c9f04c85eed', 'Samriddhi Batham', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 1, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 5, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 7, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 8, 25.0, NULL, true, '(25.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 9, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a0f4e03-85af-59d2-bed6-7185bec87e52', 10, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', '6d759e50-2fcc-5224-90ba-7e250783614f', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Palerrla Govardhan', 'IND 4002', 'individual', 9,
    117.0, 97.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Palerrla Govardhan. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4aee4506-f119-5d65-9b7b-c79383dd9c46', '2cb122ba-bc56-5170-a878-34516f7f1ce1', '6d759e50-2fcc-5224-90ba-7e250783614f', 'Palerrla Govardhan', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', 1, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', 2, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', 3, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', 4, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', 5, 20.0, NULL, true, '(20.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', 7, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', 8, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', 9, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cb122ba-bc56-5170-a878-34516f7f1ce1', 10, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', '12eea3c7-a3f1-52e0-a805-156f9fe959a6', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Anshu Yadav', 'IND 1119', 'individual', 10,
    152.0, 102.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Anshu Yadav. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1e066a22-d263-56d2-b692-26cf5da1eb9b', 'da26d6f6-3fae-5482-9c13-ba3af92beba0', '12eea3c7-a3f1-52e0-a805-156f9fe959a6', 'Anshu Yadav', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', 1, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', 3, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', 4, 50.0, 'RET', true, '(50.0RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', 6, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', 7, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', 8, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', 9, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'da26d6f6-3fae-5482-9c13-ba3af92beba0', 10, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', '54171aa7-0d57-5a89-8494-788e8a7ae268', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Aarti Verma', 'IND 1627', 'individual', 11,
    131.0, 107.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Aarti Verma. Club: CESC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '467e7754-4ca3-558b-bff2-fab4be4b84cb', '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', '54171aa7-0d57-5a89-8494-788e8a7ae268', 'Aarti Verma', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', 1, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', 3, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', 4, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', 5, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', 7, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', 8, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', 9, 24.0, NULL, true, '(24.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a8507ec-22bb-5dbf-aff3-52666e3aee7d', 10, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', '79c504af-d2f8-5d7c-be5b-2b568d79aafa', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Parth Singh Chouhan', 'IND 1116', 'individual', 12,
    135.0, 113.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Parth Singh Chouhan. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bfc38a87-8e57-52fb-b62a-a7768d4953da', '82b2cf47-0154-5f49-a718-266787139b11', '79c504af-d2f8-5d7c-be5b-2b568d79aafa', 'Parth Singh Chouhan', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', 1, 22.0, NULL, true, '(22.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', 2, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', 3, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', 6, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', 7, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', 8, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', 9, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b2cf47-0154-5f49-a718-266787139b11', 10, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 'ff0c5e0e-a62e-57f7-90fe-cbccc02216b8', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Akshay Kumar Narayan', 'IND 1598', 'individual', 13,
    144.0, 122.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Akshay Kumar Narayan. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3f0deab0-9382-55f8-aa1f-ea6c44a1b1c1', '63a5d782-1ea9-5547-95a3-637d5307960d', 'ff0c5e0e-a62e-57f7-90fe-cbccc02216b8', 'Akshay Kumar Narayan', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 1, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 2, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 4, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 7, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 8, 22.0, NULL, true, '(22.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 9, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a5d782-1ea9-5547-95a3-637d5307960d', 10, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', '4cdb0d0e-8efc-562d-bcb9-563bed0079eb', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Kommaravelly Lahari', 'IND 1494', 'individual', 14,
    157.0, 125.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Kommaravelly Lahari. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '75f40a45-e209-56cb-a644-e71275a85e5d', '53b926c8-597a-5d44-a532-f5ba3e878a72', '4cdb0d0e-8efc-562d-bcb9-563bed0079eb', 'Kommaravelly Lahari', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', 2, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', 4, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', 5, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', 6, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', 7, 32.0, NULL, true, '(32.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', 8, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', 9, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53b926c8-597a-5d44-a532-f5ba3e878a72', 10, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Shreya Krishna Lakshminarayanan', 'IND 1632', 'individual', 15,
    165.0, 129.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Shreya Krishna Lakshminarayanan. Club: RMYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4e35bbfb-6c92-539d-b9e5-8583fcccec85', 'f60e5fe2-46ce-57ef-98c2-99f2f480e015', '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc', 'Shreya Krishna Lakshminarayanan', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', 1, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', 2, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', 5, 36.0, 'SCP', true, '(36.0SCP)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', 6, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', 7, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', 8, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', 9, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f60e5fe2-46ce-57ef-98c2-99f2f480e015', 10, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 'ae8a7ace-e53c-5819-9bf0-a4eb7f03dac2', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Dhruva S Marathe', 'IND 2302', 'individual', 16,
    163.0, 136.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Dhruva S Marathe. Club: CESC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7023411f-06d8-5279-b19b-f7474dfde672', 'bdd31db4-a616-5036-9a3d-3857fa240b83', 'ae8a7ace-e53c-5819-9bf0-a4eb7f03dac2', 'Dhruva S Marathe', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 1, 27.0, NULL, true, '(27.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 2, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 3, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 4, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 5, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 7, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 8, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 9, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdd31db4-a616-5036-9a3d-3857fa240b83', 10, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', '03c7c2ab-41fc-4896-befa-bbeb1aa6ab44', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Narasimha Vutla', 'IND 1466', 'individual', 17,
    191.0, 141.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Narasimha Vutla. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6159cbee-b86c-51fd-a02b-bf66b88ce2a9', '17b67294-602d-5c8c-aa95-c8b999b2d254', '03c7c2ab-41fc-4896-befa-bbeb1aa6ab44', 'Narasimha Vutla', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', 3, 50.0, 'DNC', true, '(50.0DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', 4, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', 5, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', 7, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', 8, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', 9, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '17b67294-602d-5c8c-aa95-c8b999b2d254', 10, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 'dffc73da-efec-5a02-bdb5-1d95a7607ecc', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Vivan Kudale', 'IND 1635', 'individual', 18,
    164.0, 142.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Vivan Kudale. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1f5106be-c006-554d-9c39-a22260c34306', '98f69fd0-64d0-5fa3-baef-7281d496923c', 'dffc73da-efec-5a02-bdb5-1d95a7607ecc', 'Vivan Kudale', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 1, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 2, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 3, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 4, 22.0, NULL, true, '(22.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 5, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 7, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 8, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 9, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '98f69fd0-64d0-5fa3-baef-7281d496923c', 10, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', '98b02ce5-6ecd-5cf6-99e1-d66e78c0f9ac', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Freyana Driver', 'IND 2113', 'individual', 19,
    169.0, 145.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Freyana Driver. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '94829219-7a4a-5161-a3f2-ece74b045f55', '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', '98b02ce5-6ecd-5cf6-99e1-d66e78c0f9ac', 'Freyana Driver', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', 1, 24.0, NULL, true, '(24.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', 2, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', 3, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', 4, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', 5, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', 6, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', 7, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', 8, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', 9, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59d3f89e-e9e2-5b1c-889c-90c0fa11389d', 10, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', '25b634be-2ebc-54d9-bfa6-3b2b38bc63cf', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Sanjana Bhasin', 'IND 1815', 'individual', 20,
    172.0, 146.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Sanjana Bhasin. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9bc9505b-90c1-55bd-a2ac-0385d1310ee8', '1216c831-38b0-50d1-9161-7d0fce18a0e4', '25b634be-2ebc-54d9-bfa6-3b2b38bc63cf', 'Sanjana Bhasin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', 1, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', 3, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', 4, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', 5, 26.0, NULL, true, '(26.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', 6, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', 7, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', 8, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', 9, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1216c831-38b0-50d1-9161-7d0fce18a0e4', 10, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 'f7ee9c46-2640-5a20-839e-18d0cc3c4c9a', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Rudhresh Singh Patel', 'IND 1557', 'individual', 21,
    208.0, 158.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Rudhresh Singh Patel. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fd3f6c7f-8c06-50a5-9759-7e05adf4523a', '50b66b22-d020-5859-b48d-5655ea5159e4', 'f7ee9c46-2640-5a20-839e-18d0cc3c4c9a', 'Rudhresh Singh Patel', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 1, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 2, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 3, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 4, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 6, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 7, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 8, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 9, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50b66b22-d020-5859-b48d-5655ea5159e4', 10, 50.0, 'DSQ', true, '(50.0DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 'a9fe20b8-d1c2-5288-aced-a6d5db0a4ec4', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Bindu Rathlawath', 'IND 1690', 'individual', 22,
    244.0, 194.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Bindu Rathlawath. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f36782f0-4234-5c81-a85e-640745fc20a5', 'ade13488-801c-5c49-9f3e-7a4959d4f49d', 'a9fe20b8-d1c2-5288-aced-a6d5db0a4ec4', 'Bindu Rathlawath', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 2, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 3, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 4, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 5, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 6, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 7, 37.0, NULL, false, '37.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 8, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 9, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ade13488-801c-5c49-9f3e-7a4959d4f49d', 10, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 'cdaccd8d-fdc2-5833-acbe-f7ac18d418e0', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'D Sathwik', 'IND 1691', 'individual', 23,
    237.0, 207.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: D Sathwik. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd55b155e-8eb5-541c-b675-c7520d1c0c0c', 'e441563d-47c8-528b-8bb6-6c704079a029', 'cdaccd8d-fdc2-5833-acbe-f7ac18d418e0', 'D Sathwik', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 1, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 2, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 3, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 4, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 5, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 6, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 7, 30.0, NULL, true, '(30.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 8, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 9, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e441563d-47c8-528b-8bb6-6c704079a029', 10, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', '32bdbc2f-2215-5554-9ba0-d9746e6dfb33', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Samaira Chanda', 'IND 1455', 'individual', 24,
    275.0, 225.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Samaira Chanda. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '491d7ee2-ef33-5dc8-bcbc-d7a17277c393', '381fc567-52ad-50cf-b893-0dd64192e5d3', '32bdbc2f-2215-5554-9ba0-d9746e6dfb33', 'Samaira Chanda', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', 1, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', 2, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', 3, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', 4, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', 5, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', 6, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', 7, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', 8, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', 9, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '381fc567-52ad-50cf-b893-0dd64192e5d3', 10, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', '0df11c37-a105-509b-a443-38ed87cb9b92', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'D Vinod', 'IND 1600', 'individual', 25,
    276.0, 226.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: D Vinod. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9301e449-7255-5a94-ab64-b52d99af0f12', '40633675-d5e7-54bd-9d69-b67a08a9ff57', '0df11c37-a105-509b-a443-38ed87cb9b92', 'D Vinod', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', 1, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', 2, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', 3, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', 4, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', 5, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', 6, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', 7, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', 8, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', 9, 50.0, 'DSQ', true, '(50.0DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40633675-d5e7-54bd-9d69-b67a08a9ff57', 10, 50.0, 'DNE', false, '50.0DNE'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', '8e75283e-7dcc-57b2-b087-e1f651809ad9', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'M Jeevankumar', 'IND 1457', 'individual', 26,
    278.0, 228.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: M Jeevankumar. Club: TNSA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3a87e667-d4e7-5652-9843-c4da3891cafa', 'dcb7c111-790e-5903-b173-0b5e7e112199', '8e75283e-7dcc-57b2-b087-e1f651809ad9', 'M Jeevankumar', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', 1, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', 2, 50.0, 'RET', true, '(50.0RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', 3, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', 4, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', 5, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', 6, 45.0, NULL, false, '45.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', 7, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', 8, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', 9, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcb7c111-790e-5903-b173-0b5e7e112199', 10, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', '7a484f50-d34b-531d-a004-b86c7b0b59f8', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Bandaram Sahith', 'IND 4001', 'individual', 27,
    291.0, 241.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Bandaram Sahith. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '03b81595-f15f-5519-b9c3-4a1222072dcc', '265b83ad-c573-5835-9db4-734f4c55506f', '7a484f50-d34b-531d-a004-b86c7b0b59f8', 'Bandaram Sahith', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', 1, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', 2, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', 3, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', 4, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', 5, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', 6, 38.0, NULL, false, '38.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', 7, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', 8, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', 9, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '265b83ad-c573-5835-9db4-734f4c55506f', 10, 50.0, 'RET', false, '50.0RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', '46da83a6-e46b-5c98-992b-e493747f67d1', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Thaneesha J', 'IND 1181', 'individual', 28,
    291.0, 241.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Thaneesha J. Club: TNSA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1d01894d-2814-57da-a13a-0cdf4adcb11b', '16129244-238b-54c4-afcc-506467d80d87', '46da83a6-e46b-5c98-992b-e493747f67d1', 'Thaneesha J', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', 1, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', 2, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', 3, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', 4, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', 5, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', 6, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', 7, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', 8, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', 9, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16129244-238b-54c4-afcc-506467d80d87', 10, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 'a22341c9-2e7b-5530-8c69-f12ee8815413', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Krithika Vishwanathan', 'IND 1584', 'individual', 29,
    296.0, 246.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Krithika Vishwanathan. Club: SSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '96930338-0d1e-55b9-ba97-4cfc11d29642', 'c2c14732-8120-5378-b754-4b3a50a0ad44', 'a22341c9-2e7b-5530-8c69-f12ee8815413', 'Krithika Vishwanathan', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 1, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 2, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 3, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 4, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 5, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 6, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 7, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 8, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 9, 39.0, NULL, false, '39.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2c14732-8120-5378-b754-4b3a50a0ad44', 10, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', '50256b4d-909d-5016-bda7-8cd6548f0a2a', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Krishna Venkitachalam R', 'IND 1665', 'individual', 30,
    311.0, 261.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Krishna Venkitachalam R. Club: RMYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e226852c-306c-57fd-a755-7147f29dd91a', '74c1c8d3-3133-580a-a386-ce641338c552', '50256b4d-909d-5016-bda7-8cd6548f0a2a', 'Krishna Venkitachalam R', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', 1, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', 2, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', 3, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', 4, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', 5, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', 6, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', 7, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', 8, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', 9, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74c1c8d3-3133-580a-a386-ce641338c552', 10, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', '1086f572-4d3c-5707-926a-1f89c1684cf9', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Tattari Chandralekha', 'IND 4003', 'individual', 31,
    324.0, 274.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Tattari Chandralekha. Club: YCH.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '223bf074-a74d-5172-9561-1f714ea8bd72', '7a376972-7498-5d4e-9a08-5e99bc3d2945', '1086f572-4d3c-5707-926a-1f89c1684cf9', 'Tattari Chandralekha', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', 1, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', 2, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', 3, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', 4, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', 5, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', 6, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', 7, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', 8, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', 9, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a376972-7498-5d4e-9a08-5e99bc3d2945', 10, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 'b038d5d0-1017-50f5-bc1d-831649d9572b', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Agastya Damisetty', 'IND 1588', 'individual', 32,
    341.0, 291.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Agastya Damisetty. Club: EMESA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4cf33a95-01c8-58ea-99e6-c27e92c4a9fd', 'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 'b038d5d0-1017-50f5-bc1d-831649d9572b', 'Agastya Damisetty', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 1, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 2, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 3, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 5, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 6, 36.0, NULL, false, '36.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 7, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 8, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 9, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a23dc01e-dcff-5f12-86b2-0e559173d3ff', 10, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 'ed84f1ed-2e5e-527b-ba8b-3fd90ba90c16', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Diya Patel', 'IND 1587', 'individual', 33,
    347.0, 297.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Diya Patel. Club: SSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a98cd08b-6dff-5cf2-ad24-548a10d7d1b6', '9c038645-865e-5db4-9dcc-fc98a0df6577', 'ed84f1ed-2e5e-527b-ba8b-3fd90ba90c16', 'Diya Patel', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 1, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 2, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 3, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 4, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 5, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 6, 40.0, NULL, false, '40.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 7, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 8, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 9, 41.0, NULL, false, '41.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c038645-865e-5db4-9dcc-fc98a0df6577', 10, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', '68264e0b-54d4-5475-9f06-8d1dcaa3256c', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Aadya Sachdeva', 'IND 2109', 'individual', 34,
    357.0, 307.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Aadya Sachdeva. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '36d6e019-002d-5422-b1b9-e8bb50fa6525', '7e54070d-4e23-540d-9512-028553225a6f', '68264e0b-54d4-5475-9f06-8d1dcaa3256c', 'Aadya Sachdeva', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', 1, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', 2, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', 3, 50.0, 'DNS', true, '(50.0DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', 5, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', 7, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', 8, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', 9, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e54070d-4e23-540d-9512-028553225a6f', 10, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 'c6b8041c-e57c-5a46-b765-5eca5fb128b3', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Kshitij Sharma', 'IND 1818', 'individual', 35,
    378.0, 328.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Kshitij Sharma. Club: INWTC(M).', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '915e71ec-54e2-5cb2-8e36-69c664175342', '4f8f6589-2a9f-5f90-8101-70c5363aa936', 'c6b8041c-e57c-5a46-b765-5eca5fb128b3', 'Kshitij Sharma', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 1, 38.0, NULL, false, '38.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 2, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 3, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 4, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 5, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 6, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 7, 50.0, 'DSQ', false, '50.0DSQ'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 8, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 9, 38.0, NULL, false, '38.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f8f6589-2a9f-5f90-8101-70c5363aa936', 10, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 'b3080664-91e0-5fa5-b1d2-dd40df9ab891', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Arjun S Marathe', 'IND 1626', 'individual', 36,
    393.0, 343.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Arjun S Marathe. Club: CESC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1303e310-6eea-59fa-b1b5-2a68add6e693', 'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 'b3080664-91e0-5fa5-b1d2-dd40df9ab891', 'Arjun S Marathe', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 1, 42.0, NULL, false, '42.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 2, 36.0, NULL, false, '36.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 3, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 5, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 6, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 7, 36.0, NULL, false, '36.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 8, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 9, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bff7dfb9-bfd6-5e0b-a5c7-73521e663e77', 10, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', '2e2b0b39-611e-5b08-9de6-753dfdf87ab5', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Prateek Pal', 'IND 1514', 'individual', 37,
    402.0, 352.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Prateek Pal. Club: INWTC(M).', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '33bd03d6-6f7f-5aac-b4b9-ef15620b208b', '6ced08fc-5634-580a-9e67-6c7981b1ddd9', '2e2b0b39-611e-5b08-9de6-753dfdf87ab5', 'Prateek Pal', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', 1, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', 2, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', 3, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', 4, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', 5, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', 6, 43.0, NULL, false, '43.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', 7, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', 8, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', 9, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ced08fc-5634-580a-9e67-6c7981b1ddd9', 10, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', '74fe0973-488a-5981-9f54-d48d35a4eb25', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Darayus JKaranjia', 'IND 2101', 'individual', 38,
    420.0, 370.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Darayus JKaranjia. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1bc6b4dc-fb98-5eae-93e1-cf853b52d678', '3a414f2f-8468-53d9-8bf5-23574d1dae99', '74fe0973-488a-5981-9f54-d48d35a4eb25', 'Darayus JKaranjia', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', 1, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', 2, 50.0, 'DNS', true, '(50.0DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', 3, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', 5, 50.0, 'NSC', false, '50.0NSC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', 6, 41.0, NULL, false, '41.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', 7, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', 8, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', 9, 40.0, NULL, false, '40.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a414f2f-8468-53d9-8bf5-23574d1dae99', 10, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 'a41305c2-1e79-599a-9ead-bee0926e49aa', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Shravan Jadhav', 'IND 2301', 'individual', 39,
    421.0, 371.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Shravan Jadhav. Club: CESC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '840abfc1-98f6-52a2-ae59-e424597d542b', 'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 'a41305c2-1e79-599a-9ead-bee0926e49aa', 'Shravan Jadhav', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 1, 36.0, NULL, false, '36.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 2, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 3, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 5, 50.0, 'NSC', false, '50.0NSC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 6, 39.0, NULL, false, '39.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 7, 38.0, NULL, false, '38.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 8, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 9, 42.0, NULL, false, '42.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9393db4-d0b6-5a17-bad6-974f9c0ac2c7', 10, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', '0174d45a-000d-5176-90fc-c0dcd92badf9', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Shriya Kothari', 'IND 2111', 'individual', 40,
    426.0, 376.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Shriya Kothari. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9f8f4459-06dd-5f4a-be23-706eff7ffb6b', '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', '0174d45a-000d-5176-90fc-c0dcd92badf9', 'Shriya Kothari', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', 1, 41.0, NULL, false, '41.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', 2, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', 3, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', 5, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', 6, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', 7, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', 8, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', 9, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d5cb73c-2652-5188-8cac-cf1b1f228cdf', 10, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', '0bb587a1-e220-5ce4-b2ec-c6eeadc17ba3', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Jagrav Kumar', 'IND 1563', 'individual', 41,
    427.0, 377.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Jagrav Kumar. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1f8f8d41-fa99-5420-b085-51723ec994c9', 'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', '0bb587a1-e220-5ce4-b2ec-c6eeadc17ba3', 'Jagrav Kumar', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', 1, 37.0, NULL, false, '37.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', 2, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', 3, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', 5, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', 6, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', 7, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', 8, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', 9, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e3690d56-2e5d-55bd-ad0b-e03c049c13f6', 10, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', '9ac68cb3-a59d-5e92-9d58-01f4cca97f22', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Sarthak Pilane', 'IND 1630', 'individual', 42,
    443.0, 393.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Sarthak Pilane. Club: CESC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '641aaeae-db31-5a9e-91e3-6c6724f37243', '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', '9ac68cb3-a59d-5e92-9d58-01f4cca97f22', 'Sarthak Pilane', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', 1, 40.0, NULL, false, '40.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', 2, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', 3, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', 5, 50.0, 'NSC', false, '50.0NSC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', 6, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', 7, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', 8, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', 9, 36.0, NULL, false, '36.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6bc3dd04-1ec6-579d-ac45-0a87aacd4a19', 10, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', '67d70a56-664a-5111-9c3b-3fe9adc995ca', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Samaira Tandon', 'IND 1515', 'individual', 43,
    456.0, 406.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Samaira Tandon. Club: CESC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3b86e189-8587-5b83-8002-b600231e1d98', '25434f41-e6bc-5dee-a040-5a3ca0b65111', '67d70a56-664a-5111-9c3b-3fe9adc995ca', 'Samaira Tandon', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', 1, 44.0, NULL, false, '44.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', 2, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', 3, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', 4, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', 5, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', 6, 46.0, NULL, false, '46.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', 7, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', 8, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', 9, 43.0, NULL, false, '43.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25434f41-e6bc-5dee-a040-5a3ca0b65111', 10, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 'a7488395-0299-52a4-9a1f-02af0e3fbc4f', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Shivansh Pandya', 'IND 1233', 'individual', 44,
    458.0, 408.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Shivansh Pandya. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '76ddf01c-825a-5e16-8a09-8bc1dab287a3', '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 'a7488395-0299-52a4-9a1f-02af0e3fbc4f', 'Shivansh Pandya', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 1, 50.0, 'DSQ', true, '(50.0DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 2, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 3, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 5, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 6, 37.0, NULL, false, '37.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 7, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 8, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 9, 37.0, NULL, false, '37.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a5383a8-6e51-5cb0-972d-0b1785a63d0b', 10, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', '980021fb-887b-4445-9db6-c1f3f431fa33', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Vantava Raguraman', 'IND 1148', 'individual', 45,
    461.0, 411.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Vantava Raguraman. Club: TNSA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dcf8854c-ae85-5896-9c42-4acc2cc333f6', 'ef8be6d2-0104-55ac-8cc7-91d81b97a363', '980021fb-887b-4445-9db6-c1f3f431fa33', 'Vantava Raguraman', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', 1, 39.0, NULL, false, '39.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', 2, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', 3, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', 5, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', 6, 42.0, NULL, false, '42.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', 7, 50.0, 'RET', false, '50.0RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', 8, 50.0, 'RET', false, '50.0RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', 9, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef8be6d2-0104-55ac-8cc7-91d81b97a363', 10, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', '378ddb93-2062-544c-ab39-a23ddebc9f86', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'M K Pragathi', 'IND 1478', 'individual', 46,
    475.0, 425.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: M K Pragathi. Club: TNSA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '159924b0-0c18-5d7f-85dc-0bca46ae5974', '00d4f95c-e86c-5761-ae88-44dcda4ebf91', '378ddb93-2062-544c-ab39-a23ddebc9f86', 'M K Pragathi', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', 1, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', 2, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', 3, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', 5, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', 6, 44.0, NULL, false, '44.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', 7, 50.0, 'RET', false, '50.0RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', 8, 50.0, 'RET', false, '50.0RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', 9, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00d4f95c-e86c-5761-ae88-44dcda4ebf91', 10, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 'd65b165e-0304-5443-aa22-547381da8bbb', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Lakshya C', 'IND 1583', 'individual', 47,
    478.0, 428.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Lakshya C. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b9bdb8d0-07b0-562f-a0ef-380a1a9dee69', 'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 'd65b165e-0304-5443-aa22-547381da8bbb', 'Lakshya C', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 1, 43.0, NULL, false, '43.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 2, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 3, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 5, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 6, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 7, 50.0, 'DNS', false, '50.0DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 8, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 9, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c9aab12c-6d73-5e4d-b08f-84b11d91e935', 10, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', '3d5983cf-3670-55a9-bd5a-103948dc8828', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Amya Kumar', 'IND 1306', 'individual', 48,
    500.0, 450.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Amya Kumar. Club: NSS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd16fa978-b34b-5656-90ad-0278e94fed26', '00657d8f-e23c-5f75-beb4-462c4333f0a4', '3d5983cf-3670-55a9-bd5a-103948dc8828', 'Amya Kumar', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', 1, 50.0, 'DNF', true, '(50.0DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', 2, 50.0, 'RET', false, '50.0RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', 3, 50.0, 'DNS', false, '50.0DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', 5, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', 6, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', 7, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', 8, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', 9, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00657d8f-e23c-5f75-beb4-462c4333f0a4', 10, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', '92851a0b-1840-5bca-88a8-513db7a417ab', 'b02f0463-dd38-5814-b204-6931b22cb62c', 'Jehan Hansotia', 'IND 2106', 'individual', 48,
    500.0, 450.0, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    'YAI Junior Nationals 2023. Sailor: Jehan Hansotia. Club: RBYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '079c178c-9476-5526-a5c7-4573c890f5a1', 'd0b08cdd-b3dd-5143-a681-ae1da22a8541', '92851a0b-1840-5bca-88a8-513db7a417ab', 'Jehan Hansotia', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', 1, 50.0, 'DNC', true, '(50.0DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', 2, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', 3, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', 4, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', 5, 50.0, 'DNF', false, '50.0DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', 6, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', 7, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', 8, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', 9, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b08cdd-b3dd-5143-a681-ae1da22a8541', 10, 50.0, 'DNC', false, '50.0DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

COMMIT;
