FROM python:3.7.4-stretch

# [ Mono: 5.20.1 ]
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb http://download.mono-project.com/repo/debian stretch/snapshots/5.20.1/. main" > /etc/apt/sources.list.d/mono-official.list \
  && apt-get update \
  && apt-get install -y clang \
  && apt-get install -y mono-complete=5.20.1\* \
  && rm -rf /var/lib/apt/lists/* /tmp/*

# [ pythonnet 2.4.0 ]
RUN pip install pycparser \
  && git clone https://github.com/pythonnet/pythonnet \
  && python pythonnet/setup.py bdist_wheel \
  && pip install --no-index --find-links=./pythonnet/dist/ pythonnet
