CREATE OR REPLACE FUNCTION with_serial_number_trigger()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
$$
DECLARE
    rows_affected int := 0;

BEGIN
    insert into serial_number (id) values (NEW.id) ON CONFLICT DO NOTHING;
    get diagnostics rows_affected = row_count;
    if (rows_affected = 0)
    then
        return NULL;
    end if;
    return NEW;
END;
$$;


CREATE OR REPLACE FUNCTION calculate_shopping_cart_amount(integer)
    RETURNS float
    LANGUAGE plpgsql AS
$$
BEGIN
    RETURN (select COALESCE(sum(shopping_cart_entry.count * calculate_amount(serial_number)), 0.0)
            from shopping_cart_entry
            where shopping_cart_entry.shopping_cart_id = $1);
END;
$$;

CREATE OR REPLACE FUNCTION calculate_amount(integer)
    RETURNS float
    LANGUAGE plpgsql AS
$$
BEGIN
    RETURN amount_accessory($1) + amount_car_part($1) + amount_consumable($1);
END;
$$;

CREATE OR REPLACE FUNCTION amount_accessory(int)
    RETURNS float
    LANGUAGE plpgsql AS
$$
BEGIN
    RETURN (select COALESCE(sum(price), 0.0) from accessory where serial_number = $1);
END;
$$;

CREATE OR REPLACE FUNCTION amount_car_part(int)
    RETURNS float
    LANGUAGE plpgsql AS
$$
BEGIN
    RETURN (select COALESCE(sum(price), 0.0) from car_part where serial_number = $1);
END;
$$;

CREATE OR REPLACE FUNCTION amount_consumable(int)
    RETURNS float
    LANGUAGE plpgsql AS
$$
BEGIN
    RETURN (select COALESCE(sum(price), 0.0) from consumable where serial_number = $1);
END;
$$;
