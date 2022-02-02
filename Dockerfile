FROM heroku/heroku:20

ARG version=21.05.0

RUN apt-get -y update && apt-get -y install build-essential cmake checkinstall libfreetype6-dev libfontconfig1-dev libjpeg-dev libtiff-dev libopenjp2-7-dev libcairo2-dev libnss3-dev
RUN git clone https://github.com/freedesktop/poppler.git && cd poppler && git checkout poppler-${version}
RUN cd poppler && mkdir build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=release -DBUILD_GTK_TESTS=OFF -DBUILD_QT5_TESTS=OFF -DBUILD_CPP_TESTS=OFF -DENABLE_QT5=OFF -DENABLE_LIBOPENJPEG=openjpeg2 -DHAVE_CAIRO=ON -DENABLE_NSS3=ON && make -j2
RUN cd poppler/build && checkinstall -y --install=no --backup=no --fstrans=yes --pkgname=poppler --pkgversion=${version}
