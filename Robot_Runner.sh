#!/bin/bash

echo hub_url = ${hub_url}
echo outputdir = ${ROBOT_REPORTS_DIR}
echo Test_path = ${ROBOT_TESTS_DIR}
echo ROBOT_TESTS_SPECIFIC = ${ROBOT_TESTS_SPECIFIC}
echo ${Test_path}${ROBOT_TESTS_SPECIFIC}

pabot --removekeywords wuks --suitestatlevel 3 --variable hub_url:${hub_url} --outputdir ${outputdir} ${Test_path}

pabot --testlevelsplit --processes 12 -i bike -d Result_With_Grid/ Test_Suites/selenium_grid_example.robot 