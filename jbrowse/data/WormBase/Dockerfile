# JBrowse
#this should really use the jbrowse dockerfile used for the Alliance and I'm sure it will be refactored to do so after it's completely working
FROM nginx:latest
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
RUN git clone --single-branch --branch fix_lower_casing_in_name_store https://github.com/GMOD/jbrowse.git
#RUN git clone --single-branch --branch wormbase-ws274 https://github.com/alliance-genome/agr_jbrowse_config.git 
#RUN git clone https://github.com/alliance-genome/agr_jbrowse_plugin.git
RUN git clone --single-branch --branch jbrowse-275 https://github.com/WormBase/website-genome-browsers.git
RUN git clone --single-branch --branch 1.0 https://github.com/scottcain/MotifSearch.git
RUN git clone https://github.com/bhofmei/jbplugin-hierarchicalcheckbox.git
RUN git clone https://github.com/bhofmei/jbplugin-screenshot.git
RUN git clone https://github.com/scottcain/colorbycds.git
RUN git clone https://github.com/cmdcolin/wigglehighlighter.git
RUN git clone https://github.com/twsaari/FeatureSequence.git

RUN mkdir /usr/share/nginx/html/jbrowse
RUN mkdir /usr/share/nginx/html/jbrowse-simple

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
    cp -r /jbrowse/* /usr/share/nginx/html/jbrowse && \
    cp -r /jbrowse/* /usr/share/nginx/html/jbrowse-simple && \
    cp /website-genome-browsers/jbrowse/jbrowse/jbrowse.conf /usr/share/nginx/html/jbrowse && \
    cp /website-genome-browsers/jbrowse/jbrowse/jbrowse-simple.conf /usr/share/nginx/html/jbrowse-simple/jbrowse.conf && \
    rm -rf /usr/share/nginx/html/jbrowse-simple/plugins && \
    ln -s /usr/share/nginx/html/jbrowse/plugins /usr/share/nginx/html/jbrowse-simple/plugins && \
    ln -s /usr/share/nginx/html/jbrowse/index.html /usr/share/nginx/html/jbrowse/full.html && \
    ln -s /usr/share/nginx/html/jbrowse-simple/index.html /usr/share/nginx/html/jbrowse-simple/full.html 
 


WORKDIR /usr/share/nginx/html/jbrowse

#RUN npm install yarn
#RUN ./node_modules/.bin/yarn
#RUN JBROWSE_BUILD_MIN=1 ./node_modules/.bin/yarn build

RUN ./setup.sh

RUN cp -r /usr/share/nginx/html/jbrowse/dist /usr/share/nginx/html/jbrowse-simple/dist/

VOLUME /data
COPY docker-entrypoint.sh /
CMD ["/docker-entrypoint.sh"]
