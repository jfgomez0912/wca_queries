.DEFAULT_GOAL := run

export:
	curl  -o ./export/WCA_export.sql.zip -L https://www.worldcubeassociation.org/export/results/WCA_export.sql
	yes | unzip ./export/WCA_export.sql.zip -d ./export
	mv ./export/WCA_export.sql ./sql/WCA_export.sql

./sql/WCA_export.sql:
	$(MAKE) export

run: ./sql/WCA_export.sql clean
	docker run -d --env-file .env -v ./sql/:/docker-entrypoint-initdb.d -p 3306:3306 --name wca-db mariadb:latest

clean:
	docker stop wca-db
	docker rm wca-db

.PHONY: export build run clean
