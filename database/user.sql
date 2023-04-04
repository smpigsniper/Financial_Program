CREATE TABLE Users (
    username varchar(255) not null UNIQUE,
    password varchar(255) not null,
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by varchar(255),
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);