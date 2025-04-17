DO $$
DECLARE
	tab text;
	qry text := '';
BEGIN
	FOR tab IN (SELECT table_name FROM information_schema.tables WHERE table_name LIKE 'data_202_\_%')
	LOOP
		IF qry <> '' THEN
			qry := qry || ' UNION ALL ';
		END IF;
		qry := qry || format('SELECT * FROM %I', tab) ;
	END LOOP;
	RAISE NOTICE 'Query: %', qry;
	EXECUTE format('CREATE TABLE customers AS %s', qry) ;
END $$