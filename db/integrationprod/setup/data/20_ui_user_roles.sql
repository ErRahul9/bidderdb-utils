-- --
-- -- PostgreSQL database dump
-- --
--
-- -- Dumped from database version 14.4
-- -- Dumped by pg_dump version 15.2
--
-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;
--
-- --
-- -- Data for Name: user_roles; Type: TABLE DATA; Schema: ui; Owner: qacore
-- --
--
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (1, 'User', NULL);
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (2, 'Admin', NULL);
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (3, 'Sales', NULL);
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (4, 'Performance Analyst', NULL);
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (5, 'Account Manager', NULL);
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (6, 'HOTEL_ADMIN', NULL);
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (7, 'ADVERTISER_ADMIN', NULL);
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (8, 'AGENCY_ADMIN', NULL);
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (9, 'DEACTIVATED', NULL);
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (10, 'ONBOARDING_MANAGER', '2021-10-06 16:27:16.098901');
-- INSERT INTO ui.user_roles (user_role_id, name, create_time) VALUES (11, 'GUEST_REVIEWER', '2022-05-27 00:16:43.412902');
--
--
-- --
-- -- Name: user_roles_user_role_id_seq; Type: SEQUENCE SET; Schema: ui; Owner: qacore
-- --
--
-- SELECT pg_catalog.setval('ui.user_roles_user_role_id_seq', 6, true);
--
--
-- --
-- -- PostgreSQL database dump complete
-- --
