#==========================
# SeleniumBase Docker Image
#==========================
FROM ubuntu:20.04
LABEL description Robot Framework in Docker.

#===============================================
# Set the reports directory environment variable
#===============================================
ENV ROBOT_REPORTS_DIR /opt/robotframework/reports

#=============================================
# Set the tests directory environment variable
#=============================================
ENV ROBOT_TESTS_DIR /opt/robotframework/tests

#===============================================
# Set the working directory environment variable
#===============================================
ENV ROBOT_WORK_DIR /opt/robotframework

#===========================================
# Setup the timezone to use, defaults to UTC
#===========================================
ENV TZ UTC

#=============================================
# Set number of threads for parallel execution
# By default, no parallelisation
#=============================================
ENV ROBOT_THREADS 1

#=============================================
# Define the default user who'll run the tests
#=============================================
ENV ROBOT_UID 1000
ENV ROBOT_GID 1000

#=======================================
# Install Python and Basic Python Tools
#=======================================
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update
RUN apt-get install -y python3 python3-pip python3-setuptools python3-dev python-distribute
RUN alias python=python3
RUN echo "alias python=python3" >> ~/.bashrc

#=================================
# Install Bash Command Line Tools
#=================================
RUN apt-get -yqq --no-install-recommends install \
    sudo \
    unzip \
    wget \
    curl \
    libxi6 \
    libgconf-2-4 \
    vim \
    xvfb \
    build-essential \
    libssl-dev \
    libffi-dev \
    ca-certificates \
    gnupg \
  && rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates
#===========================
# Configure Virtual Display
#===========================
RUN set -e
RUN echo "Starting X virtual framebuffer (Xvfb) in background..."
RUN Xvfb -ac :99 -screen 0 1280x1024x16 > /dev/null 2>&1 &
RUN export DISPLAY=:99
RUN exec "$@"

#=============================================
# Allow Special Characters in Python Programs
#=============================================
RUN export PYTHONIOENCODING=utf8
RUN echo "export PYTHONIOENCODING=utf8" >> ~/.bashrc

#========================
# Set up NewSDKAutomation
#========================
COPY App_Variables /NewSDKAutomation/App_Variables
COPY Assets /NewSDKAutomation/Assets
COPY OR_Keywords /NewSDKAutomation/OR_Keywords
COPY Test_Data /NewSDKAutomation/Test_Data
COPY TestSuites /NewSDKAutomation/TestSuites
COPY Utils /NewSDKAutomation/Utils
COPY PCloudy_Runner.py /NewSDKAutomation/PCloudy_Runner.py
COPY PCloudy_Runner.sh /NewSDKAutomation/PCloudy_Runner.sh
COPY requirements.txt /NewSDKAutomation/requirements.txt
RUN find . -name '*.pyc' -delete
RUN find . -name __pycache__ -delete
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools
RUN pip3 install --upgrade setuptools-scm
RUN cd /NewSDKAutomation && ls && pip3 install -r requirements.txt --upgrade

#=============================================================================================
# Create the default report and work folders with the default user to avoid runtime issues
# These folders are writeable by anyone, to ensure the user can be changed on the command line.
#=============================================================================================
RUN mkdir -p ${ROBOT_REPORTS_DIR} \
  && mkdir -p ${ROBOT_WORK_DIR} \
  && chown ${ROBOT_UID}:${ROBOT_GID} ${ROBOT_REPORTS_DIR} \
  && chown ${ROBOT_UID}:${ROBOT_GID} ${ROBOT_WORK_DIR} \
  && chmod ugo+w ${ROBOT_REPORTS_DIR} ${ROBOT_WORK_DIR}

#=============================
# Allow any user to write logs
#=============================
RUN chmod ugo+w /var/log \
  && chown ${ROBOT_UID}:${ROBOT_GID} /var/log

#==========================================
# Set up a volume for the generated reports
#==========================================
VOLUME ${ROBOT_REPORTS_DIR}

USER ${ROBOT_UID}:${ROBOT_GID}

#=====================================================================
# A dedicated work folder to allow for the creation of temporary files
#=====================================================================
WORKDIR ${ROBOT_WORK_DIR}

#==========================================
# Create entrypoint and grab example tests
#==========================================
CMD ["/bin/bash","/NewSDKAutomation/Robot_Runner.sh"]