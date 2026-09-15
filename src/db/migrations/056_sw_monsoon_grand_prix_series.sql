-- Migration 056: Clean up legacy Southwest Monsoon placeholder and ensure 2026 SW Monsoon GP Series structure
DELETE FROM public.wingfoil_regattas WHERE id = 'sw-monsoon-gp-2026';
