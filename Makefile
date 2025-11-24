.DEFAULT_GOAL := run

export:
	curl  -o ./export/WCA_export.sql.zip -L https://www.worldcubeassociation.org/export/results/WCA_export.sql
	yes | unzip ./export/WCA_export.sql.zip -d ./export
	cp ./export/WCA_export.sql ./sql/WCA_export.sql

./sql/WCA_export.sql:
	$(MAKE) export

run: clean ./sql/WCA_export.sql
	docker run -d --env-file .env -v ./sql/:/docker-entrypoint-initdb.d -p 3306:3306 --name wca-db mariadb:latest

clean:
	rm -rf ./export/* ./output/* ./sql/*
	docker stop wca-db || true
	docker rm wca-db || true

.PHONY: export run clean
