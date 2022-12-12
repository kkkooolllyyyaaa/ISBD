DROP TRIGGER IF EXISTS ON_CONSUMABLE_ACTION ON consumable;
CREATE TRIGGER ON_CONSUMABLE_ACTION
    BEFORE INSERT OR UPDATE
    ON consumable
    FOR EACH ROW
EXECUTE PROCEDURE with_serial_number_trigger();

DROP TRIGGER IF EXISTS ON_ACCESSORY_ACTION ON accessory;
CREATE TRIGGER ON_ACCESSORY_ACTION
    BEFORE INSERT OR UPDATE
    ON accessory
    FOR EACH ROW
EXECUTE PROCEDURE with_serial_number_trigger();

DROP TRIGGER IF EXISTS ON_CAR_PART_ACTION ON car_part;
CREATE TRIGGER ON_CAR_PART_ACTION
    BEFORE INSERT OR UPDATE
    ON car_part
    FOR EACH ROW
EXECUTE PROCEDURE with_serial_number_trigger();