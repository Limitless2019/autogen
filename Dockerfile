# basic setup
FROM python:3.10
RUN apt-get update && apt-get -y update
RUN apt-get install -y sudo git npm

# Setup user to not run as root
RUN adduser --disabled-password --gecos '' autogen-dev
RUN adduser autogen-dev sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER autogen-dev

# Pull repo
RUN cd /home/autogen-dev && git clone https://github.com/microsoft/autogen.git
WORKDIR /home/autogen-dev/autogen

# Install autogen (Note: extra components can be installed if needed)
RUN sudo pip install -e .[test]

# Install precommit hooks
RUN pre-commit install

# For docs
RUN sudo npm install --global yarn
RUN sudo pip install pydoc-markdown
RUN cd website
RUN yarn install --frozen-lockfile --ignore-engines

# override default image starting point
CMD /bin/bash
ENTRYPOINT []

ENV VTIGER_API_KEY=Bm0x9ubAwwfblW3I
ENV OPENAI_API_KEY=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
ENV AZURE_API_KEY=aec94f1f2fb64ea1bbf8ddc15d20babe
ENV AZURE_AI_URL=https://limitlessopenai.openai.azure.com/
ENV ZAPIER_API_KEY=sk-ak-nVPlPE829v78MykpOsbn774ZZl

