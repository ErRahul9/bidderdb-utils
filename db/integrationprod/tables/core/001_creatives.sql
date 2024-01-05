CREATE SEQUENCE IF NOT EXISTS core.creatives_creative_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


create table core.creatives
(
    creative_id           integer      default nextval('creatives_creative_id_seq'::regclass) not null
        primary key,
    creative_size_id      integer                                                             not null,
    advertiser_id         integer                                                             not null,
    name                  text,
    media_type_id         integer,
    creative_location     text,
    create_time           timestamp    default now(),
    active                boolean      default true                                           not null,
    approved              boolean      default true,
    update_time           timestamp(6) default now(),
    adcode                text,
    adserver_payload      text,
    is_adcode             boolean      default false                                          not null,
    is_control_creative   boolean      default false,
    fb_headline           text,
    fb_text               text,
    fb_description        text,
    fb_social             boolean      default false,
    a2_version            integer,
    fb_cta                text         default 'NO_BUTTON'::text,
    adbuilder_compatible  boolean      default false,
    static_image_location text,
    fb_display_url        text,
    deleted               boolean      default false                                          not null,
    fb_click_url          text,
    fb_url_prefix         text,
    fb_url_suffix         text,
    video_duration_id     integer,
    user_id               integer,
    length                smallint,
    caas_video_id         uuid
);

alter table core.creatives
    owner to qacore;
