-- V2__seed_roles.sql
-- Base roles. Flags: can_approve_visitors, can_post_notices. Adjust to your rules.
INSERT INTO role (role_name, can_approve_visitors, can_post_notices) VALUES
    ('ADMIN',     TRUE,  TRUE),
    ('COMMITTEE', TRUE,  TRUE),
    ('RESIDENT',  TRUE,  FALSE),
    ('SECURITY',  FALSE, FALSE);
