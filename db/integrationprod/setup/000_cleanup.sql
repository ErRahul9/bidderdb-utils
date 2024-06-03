drop table if exists bidder.advertiser_settings;
drop table if exists bidder.beeswax_segment_mapping;
drop table if exists bidder.block_list_transaction_history;
drop table if exists bidder.budget_messages;
drop sequence  if exists  bidder.campaign_budget_by_device_seq;
drop table if exists bidder.campaign_budget_by_device;
drop table if exists bidder.campaign_budget_by_device_log;
drop table if exists bidder.campaign_settings;
drop table if exists bidder.campaign_settings_log;
drop table if exists bidder.creative_approval;
drop table if exists bidder.creative_approval_log_events;
drop table if exists bidder.creative_metadata_qa;
drop table if exists bidder.deal_volume_log;
drop table if exists bidder.delivery_modifier_targets;
drop table if exists bidder.delivery_modifier_terms;
drop table if exists bidder.delivery_modifiers;
drop table if exists bidder.flight_campaign_budgets;
drop table if exists bidder.flights;
drop table if exists bidder.frequency_caps;
drop table if exists bidder.pmp_deal_allow_list;
drop table if exists bidder.recency_mappings;
drop table if exists bidder.recency_types;
drop table if exists bidder.segment_mapping;
drop table if exists bidder.segment_mapping_transaction_logs;
drop table if exists bidder.targeting;
drop table if exists bidder.term_targets;
drop table if exists bidder.terms;








-- CREATE ROLE postgres WITH LOGIN NOCREATEDB;
-- ALTER ROLE postgres SET PASSWORD TO '<password>';
-- GRANT CONNECT ON DATABASE < databasename > TO postgres;
-- -- Grant All Permissions to DCO User
-- GRANT USAGE ON SCHEMA bidder TO postgres;
-- GRANT SELECT, INSERT, DELETE, UPDATE ON ALL TABLES IN SCHEMA bidder TO postgres;
---
-- Creating DCO Read Only User (Run in each environment)
-- CREATE ROLE dco_read_only WITH LOGIN NOSUPERUSER NOCREATEDB;
-- ALTER ROLE dco_read_only SET PASSWORD TO '<password>';
-- GRANT CONNECT ON DATABASE < databasename > TO dco_read_only;
-- -- Grant SELECT Permissions to DCO Read Only User
-- GRANT USAGE ON SCHEMA public, archives, dso, core, ui TO dco_read_only;
-- GRANT SELECT ON ALL TABLES IN SCHEMA public TO dco_read_only;
-- GRANT SELECT ON ALL TABLES IN SCHEMA archives TO dco_read_only;
-- GRANT SELECT ON ALL TABLES IN SCHEMA dso TO dco_read_only;
-- GRANT SELECT ON ALL TABLES IN SCHEMA core TO dco_read_only;
-- GRANT SELECT ON ALL TABLES IN SCHEMA ui TO dco_read_only;