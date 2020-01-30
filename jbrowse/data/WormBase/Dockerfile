# JBrowse
#this should really use the jbrowse dockerfile used for the Alliance and I'm sure it will be refactored to do so after it's completely working
FROM nginx:latest as linux

ARG RELEASE=275

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /usr/share/man/man1 /usr/share/man/man7

RUN apt-get -qq update --fix-missing
RUN apt-get --no-install-recommends -y install vim curl software-properties-common git build-essential zlib1g-dev libpng-dev perl-doc ca-certificates

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get -y install nodejs

#RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh -O ~/miniconda.sh && \
#    /bin/bash ~/miniconda.sh -b -p /conda/ && \
#    rm ~/miniconda.sh

#ENV PATH="/conda/bin:${PATH}"

#this probably isn't jbrowse-dev, so no adding plugins
#RUN conda install -y --override-channels --channel iuc --channel conda-forge --channel bioconda --channel defaults jbrowse=1.16.6

#RUN git clone --single-branch --branch 1.16.6-release https://github.com/GMOD/jbrowse.git
RUN git clone --single-branch --branch 1.16.7-release https://github.com/GMOD/jbrowse.git
#RUN git clone --single-branch --branch wormbase-ws274 https://github.com/alliance-genome/agr_jbrowse_config.git 
#RUN git clone https://github.com/alliance-genome/agr_jbrowse_plugin.git
RUN git clone --single-branch --branch jbrowse-${RELEASE} https://github.com/WormBase/website-genome-browsers.git
RUN git clone --single-branch --branch 1.0 https://github.com/scottcain/MotifSearch.git
RUN git clone https://github.com/bhofmei/jbplugin-hierarchicalcheckbox.git
RUN git clone https://github.com/bhofmei/jbplugin-screenshot.git
RUN git clone https://github.com/scottcain/colorbycds.git
RUN git clone https://github.com/cmdcolin/wigglehighlighter.git
RUN git clone https://github.com/twsaari/FeatureSequence.git

RUN mkdir -p /usr/share/nginx/html/tools/genome/jbrowse
RUN mkdir /usr/share/nginx/html/tools/genome/jbrowse-simple

RUN rm /usr/share/nginx/html/index.html && rm /usr/share/nginx/html/50x.html && \
    cp -r /website-genome-browsers/jbrowse/jbrowse/data /jbrowse/data/ && \
    cp -r /website-genome-browsers/jbrowse/jbrowse/plugins/RemoveGridOption /jbrowse/plugins && \
    cp -r /website-genome-browsers/jbrowse/jbrowse/plugins/SwitchTrackSelector /jbrowse/plugins && \
    cp -r /website-genome-browsers/jbrowse/jbrowse/plugins/wormbase-glyphs /jbrowse/plugins && \
    cp -r /MotifSearch /jbrowse/plugins && \
    cp -r /jbplugin-hierarchicalcheckbox /jbrowse/plugins/HierarchicalCheckboxPlugin && \
    cp -r /jbplugin-screenshot /jbrowse/plugins/ScreenShotPlugin && \
    cp -r /colorbycds /jbrowse/plugins/ColorByCDS && \
    cp -r /wigglehighlighter /jbrowse/plugins/WiggleHighlighter && \
    cp -r /FeatureSequence /jbrowse/plugins/FeatureSequence && \
    cp -r /jbrowse/* /usr/share/nginx/html/tools/genome/jbrowse && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/index.html /usr/share/nginx/html/tools/genome/jbrowse/full.html && \
    cp /website-genome-browsers/jbrowse/jbrowse/jbrowse-simple.conf /usr/share/nginx/html/tools/genome/jbrowse-simple/jbrowse.conf
    



#    ln -s /usr/share/nginx/html/tools/genome/jbrowse/plugins /usr/share/nginx/html/tools/genome/jbrowse-simple/plugins && \
#    ln -s /usr/share/nginx/html/tools/genome/jbrowse-simple/index.html /usr/share/nginx/html/tools/genome/jbrowse-simple/full.html 
 
#    cp /website-genome-browsers/jbrowse/jbrowse/jbrowse-simple.conf /usr/share/nginx/html/tools/genome/jbrowse-simple/jbrowse.conf && \

WORKDIR /usr/share/nginx/html/tools/genome/jbrowse

#RUN npm install yarn
#RUN ./node_modules/.bin/yarn
#RUN JBROWSE_BUILD_MIN=1 ./node_modules/.bin/yarn build

RUN ./setup.sh


FROM nginx:latest as production
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/dist /usr/share/nginx/html/tools/genome/jbrowse/dist
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/browser /usr/share/nginx/html/tools/genome/jbrowse/browser
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/css /usr/share/nginx/html/tools/genome/jbrowse/css
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/data /usr/share/nginx/html/tools/genome/jbrowse/data
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/full.html /usr/share/nginx/html/tools/genome/jbrowse/full.html
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/img /usr/share/nginx/html/tools/genome/jbrowse/img
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/index.html /usr/share/nginx/html/tools/genome/jbrowse/index.html
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/jbrowse_conf.json /usr/share/nginx/html/tools/genome/jbrowse/jbrowse_conf.json
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/jbrowse.conf /usr/share/nginx/html/tools/genome/jbrowse/jbrowse.conf
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/LICENSE /usr/share/nginx/html/tools/genome/jbrowse/LICENSE
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/plugins /usr/share/nginx/html/tools/genome/jbrowse/plugins
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse-simple/jbrowse.conf /usr/share/nginx/html/tools/genome/jbrowse-simple/jbrowse.conf

#the "jbrowse-simple" stuff is required to make the SwitchTrackSelector plugin work
RUN ln -s /usr/share/nginx/html/tools/genome/jbrowse/dist /usr/share/nginx/html/tools/genome/jbrowse-simple/dist && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/browser /usr/share/nginx/html/tools/genome/jbrowse-simple/browser && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/css /usr/share/nginx/html/tools/genome/jbrowse-simple/css && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/data /usr/share/nginx/html/tools/genome/jbrowse-simple/data && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/full.html /usr/share/nginx/html/tools/genome/jbrowse-simple/full.html && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/img /usr/share/nginx/html/tools/genome/jbrowse-simple/img && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/index.html /usr/share/nginx/html/tools/genome/jbrowse-simple/index.html && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/jbrowse_conf.json /usr/share/nginx/html/tools/genome/jbrowse-simple/jbrowse_conf.json && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/LICENSE /usr/share/nginx/html/tools/genome/jbrowse-simple/LICENSE && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/plugins /usr/share/nginx/html/tools/genome/jbrowse-simple/plugins


VOLUME /data
COPY docker-entrypoint.sh /
CMD ["/docker-entrypoint.sh"]
