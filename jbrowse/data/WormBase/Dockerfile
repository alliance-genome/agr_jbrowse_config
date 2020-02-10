# JBrowse

#this docker file uses a build arg to indicate the release version, so the typical command to build is

#   docker build --no-cache -t wb_jbrowse  WormBase/ --build-arg RELEASE=275

# and it uses multistage builds, so after the build is done, the first image can be deleted and the second, usually much
# smaller (200MB or so) can be used for production

FROM nginx:latest as linux

ARG RELEASE=275

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /usr/share/man/man1 /usr/share/man/man7

RUN apt-get -qq update --fix-missing
RUN apt-get --no-install-recommends -y install vim curl software-properties-common git build-essential zlib1g-dev libpng-dev perl-doc ca-certificates

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get -y install nodejs

# JBrowse source
RUN git clone --single-branch --branch 1.16.8-release https://github.com/GMOD/jbrowse.git

#this pulls in several things:
#  * the config files for all of the species
#  * two include files (one with functions and one that contains the species locations for jbrowse.conf
#  * the jbrowse.conf files for both jbrowse and jbrowse-simple
#  * Three plugins:
#    * SwitchTrackSelector - provides a button to switch between faceted and hierarchical selectors
#    * RemoveGridOption    - provides a menu item to remove the background grid lines
#    * wormbase-glyphs     - provides some glyphs and places a logo in the page
RUN git clone --single-branch --branch jbrowse-${RELEASE} https://github.com/WormBase/website-genome-browsers.git

# Provides the PWM motif search plugin
RUN git clone --single-branch --branch 1.0 https://github.com/scottcain/MotifSearch.git

# Provides the all on/off checkboxes in the hierarchical selector
RUN git clone https://github.com/bhofmei/jbplugin-hierarchicalcheckbox.git

# Provides the phantomJS powered screenshot plugin
RUN git clone https://github.com/WormBase/jbplugin-screenshot.git

# Provides the "usage by frame" plugin with WB specific colors
RUN git clone https://github.com/scottcain/colorbycds.git

# Provides the vistaplot-like glyph that takes a bigbed file to highlight peak calls in a BigWig
RUN git clone https://github.com/cmdcolin/wigglehighlighter.git

# Provides the View Sequence right click menu option
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
    cp -r /jbrowse/.htaccess /usr/share/nginx/html/tools/genome/jbrowse/.htaccess && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/index.html /usr/share/nginx/html/tools/genome/jbrowse/full.html && \
    cp /website-genome-browsers/jbrowse/jbrowse/jbrowse-simple.conf /usr/share/nginx/html/tools/genome/jbrowse-simple/jbrowse.conf
    
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
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/site.webmanifest /usr/share/nginx/html/tools/genome/jbrowse/site.webmanifest
COPY --from=linux /usr/share/nginx/html/tools/genome/jbrowse/.htaccess /usr/share/nginx/html/tools/genome/jbrowse/.htaccess
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
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/plugins /usr/share/nginx/html/tools/genome/jbrowse-simple/plugins && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/site.webmanifest /usr/share/nginx/html/tools/genome/jbrowse-simple/site.webmanifest && \
    ln -s /usr/share/nginx/html/tools/genome/jbrowse/.htaccess /usr/share/nginx/html/tools/genome/jbrowse-simple/.htaccess


VOLUME /data
COPY docker-entrypoint.sh /
CMD ["/docker-entrypoint.sh"]
