DELETE FROM customers del
WHERE EXISTS (
        SELECT * FROM customers x
        WHERE x.event_type = del.event_type 
		AND x.product_id = del.product_id
		AND x.price = del.price
		AND x.user_id = del.user_id
		AND x.user_session = del.user_session
		AND x.event_time < del.event_time
        AND x.event_time >= del.event_time - '1 sec'::interval
        );
-- Takes 50 min.