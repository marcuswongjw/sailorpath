-- Enforce valid scoring inputs for all future inserts and updates.
-- NOT VALID keeps deployment safe if historical imports contain bad values;
-- PostgreSQL still enforces these constraints for new or changed rows.
ALTER TABLE regattas
  ADD CONSTRAINT regattas_total_fleet_size_positive
  CHECK (total_fleet_size >= 1) NOT VALID;

ALTER TABLE regatta_results
  ADD CONSTRAINT regatta_results_rank_positive
  CHECK (rank >= 1) NOT VALID;
