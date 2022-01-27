### How to execute test file on local machine

```
robot --outputdir Result_With_CSV Test_Suites/dropdown_with_csv.robot
```

### How to build Docker image on Intel machines
```
docker build -t rds .
```

### How to run Docker container on Intel machines
```
docker run \
	-v /Users/mukeshtiwari/Documents/shastra/ncore_app/robotframework-dropdown-sample/reports:/opt/robotframework/reports: \
	-v /Users/mukeshtiwari/Documents/shastra/ncore_app/robotframework-dropdown-sample:/opt/robotframework/tests: \
	rds
```
### How Docker image on ARM machines
```
docker buildx build --platform=linux/amd64 -t rds .
```

### How to run Docker container on ARM machines
```
docker run \
	--platform=linux/amd64 \
	-v /Users/mukeshtiwari/Documents/shastra/ncore_app/robotframework-dropdown-sample/reports:/opt/robotframework/reports: \
	-v /Users/mukeshtiwari/Documents/shastra/ncore_app/robotframework-dropdown-sample:/opt/robotframework/tests: \
	rds
```
```
docker run \
	--platform=linux/amd64 \
	-v /Users/mukeshtiwari/Documents/shastra/ncore_app/robotframework-dropdown-sample/reports:/opt/robotframework/reports: \
	-v /Users/mukeshtiwari/Documents/shastra/ncore_app/robotframework-dropdown-sample:/opt/robotframework/tests: \
    -e hub_url=192.168.53.5 \
	-e ROBOT_TESTS_SPECIFIC=selenium_grid_example.robot \
	rds
```
```
docker run \
	--platform=linux/amd64 \
	-v /Users/mukeshtiwari/Documents/shastra/ncore_app/robotframework-dropdown-sample/reports:/opt/robotframework/reports: \
	-v /Users/mukeshtiwari/Documents/shastra/ncore_app/robotframework-dropdown-sample:/opt/robotframework/tests: \
    -e hub_url=192.168.53.5 \
	rds
```