CREATE TABLE IF NOT EXISTS serial_number
(
    id int PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS account
(
    id       SERIAL PRIMARY KEY,
    login    varchar(255) NOT NULL,
    password varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS buyer
(
    id         SERIAL PRIMARY KEY,
    account_id integer REFERENCES account (id)
);

CREATE TABLE IF NOT EXISTS review
(
    id            SERIAL PRIMARY KEY,
    message       text,
    serial_number integer REFERENCES serial_number (id),
    buyer_id      integer REFERENCES buyer (id)
);


CREATE TABLE IF NOT EXISTS seller
(
    id         SERIAL PRIMARY KEY,
    name       varchar(255) UNIQUE NOT NULL,
    contact    text                NOT NULL,
    account_id integer REFERENCES account (id)
);

CREATE TABLE IF NOT EXISTS shopping_cart
(
    id        SERIAL PRIMARY KEY,
    amount    float NOT NULL CHECK (amount > 0),
    buyer_id  integer REFERENCES buyer (id),
    is_active bool DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS shopping_cart_entry
(
    id               SERIAL PRIMARY KEY,
    serial_number    integer REFERENCES serial_number (id),
    count            integer NOT NULL DEFAULT 1 CHECK (count > 0),
    shopping_cart_id integer REFERENCES shopping_cart (id)
);

CREATE TABLE IF NOT EXISTS buyer_order
(
    buyer_id         integer REFERENCES buyer (id),
    shopping_cart_id integer REFERENCES shopping_cart (id),
    amount           float NOT NULL CHECK (amount > 0),
    PRIMARY KEY (shopping_cart_id)
);


CREATE TABLE IF NOT EXISTS consumable
(
    id            SERIAL PRIMARY KEY,
    photo         varchar(255),
    price         float NOT NULL CHECK (price > 0),
    description   text,
    serial_number integer REFERENCES serial_number (id)
);

CREATE TABLE IF NOT EXISTS seller_consumable
(
    seller_id     integer REFERENCES seller (id),
    consumable_id integer REFERENCES consumable (id),
    count         integer NOT NULL DEFAULT 1 CHECK (count > 0),
    PRIMARY KEY (seller_id, consumable_id)
);

CREATE TABLE IF NOT EXISTS car_brand
(
    id   SERIAL PRIMARY KEY,
    name varchar(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS accessory
(
    id            SERIAL PRIMARY KEY,
    car_brand_id  integer REFERENCES car_brand (id),
    photo         varchar(255),
    price         float NOT NULL CHECK (price > 0),
    description   text,
    serial_number integer REFERENCES serial_number (id)
);

CREATE TABLE IF NOT EXISTS seller_accessory
(
    seller_id    integer REFERENCES seller (id),
    accessory_id integer REFERENCES accessory (id),
    count        integer NOT NULL DEFAULT 1 CHECK (count > 0),
    PRIMARY KEY (seller_id, accessory_id)
);

CREATE TABLE IF NOT EXISTS car
(
    id           SERIAL PRIMARY KEY,
    car_brand_id integer REFERENCES car_brand (id),
    model        varchar(255) unique NOT NULL
);

CREATE TABLE IF NOT EXISTS car_part
(
    id            SERIAL PRIMARY KEY,
    photo         varchar(255),
    price         float NOT NULL CHECK (price > 0),
    description   text,
    serial_number integer REFERENCES serial_number (id)
);

CREATE TABLE IF NOT EXISTS car_to_car_part
(
    car_id      integer REFERENCES car (id),
    car_part_id integer REFERENCES car_part (id),
    PRIMARY KEY (car_id, car_part_id)
);

CREATE TABLE IF NOT EXISTS seller_car_part
(
    seller_id   integer REFERENCES seller (id),
    car_part_id integer REFERENCES car_part (id),
    count       integer NOT NULL DEFAULT 1 CHECK (count > 0),
    PRIMARY KEY (seller_id, car_part_id)
);
