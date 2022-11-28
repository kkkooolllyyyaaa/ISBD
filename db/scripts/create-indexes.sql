CREATE UNIQUE INDEX accessory_serial_number on accessory (serial_number);
CREATE INDEX accessory_price on accessory (price);


CREATE UNIQUE INDEX car_part_serial_number on car_part (serial_number);
CREATE INDEX car_part_price on car_part (price);

CREATE UNIQUE INDEX consumable_serial_number on consumable (serial_number);
CREATE INDEX consumable_price on consumable (price);
