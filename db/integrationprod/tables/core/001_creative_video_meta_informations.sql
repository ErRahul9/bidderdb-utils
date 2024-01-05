CREATE SEQUENCE IF NOT EXISTS core.creative_video_meta_informati_creative_video_meta_informati_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


create table core.creative_video_meta_informations
(
    creative_video_meta_information_id integer   default nextval('creative_video_meta_informati_creative_video_meta_informati_seq'::regclass) not null
        primary key,
    creative_id                        integer,
    job_task_id                        text,
    video_size                         text,
    url                                text,
    width                              integer,
    height                             integer,
    file_type                          text,
    duration                           text,
    bitrate                            text,
    status                             boolean   default false,
    created_at                         timestamp default now(),
    duration_in_sec                    real,
    video_adcode                       json,
    fps                                numeric(6, 3)
);

alter table core.creative_video_meta_informations
    owner to qacore;
