create table bidder.delivery_modifiers_terms
(
    delivery_modifier_id integer not null,
    term_id              integer not null,
    primary key (delivery_modifier_id, term_id)
);

alter table bidder.delivery_modifiers_terms
    owner to qacore;

-- grant select on bidder.delivery_modifiers_terms to shopify_user;

-- grant delete, insert, references, select, trigger, truncate, update on bidder.delivery_modifiers_terms to svc_ui_mntn;

