create table core.creative_sizes
(
    creative_size_id integer not null
        primary key,
    width            integer not null,
    height           integer not null,
    description      text    not null,
    video            boolean not null,
    approve          boolean not null,
    web              boolean,
    mobile           boolean not null,
    ctv              boolean not null
);

alter table core.creative_sizes
    owner to qacore;

