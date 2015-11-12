
build:
	docker build --rm -t guillaumebreton/taskd .

ti:
	docker run --rm -ti -v "$$(pwd)/temp/:/var/taskdata" guillaumebreton/taskd bash

run:
	docker run -d --name "taskd" -v "$$(pwd)/temp/:/var/taskdata" guillaumebreton/taskd

exec-ti:
	docker exec -ti "taskd" bash

