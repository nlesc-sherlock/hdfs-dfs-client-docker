# hdfs-ingest-docker
Docker-based tool capable of uploading files to a remote hdfs cluster

This tool (wrapped in a docker image for convienence) can be used to upload files to a remote hdfs instance (usually a cluster).

Example Usage:

docker run -v /home/user/config.tar.gz:/config.tar.gz -v /source/folder:/input nlesc/hdfs-ingest /hdfs/destination/folder

Explanation:

"docker run"

Command to run this image.

"-v /home/user/config.tar.gz:/config.tar.gz"

The tool needs the location of your hdfs system. We currently only support the "client configs" format as produced by Ambari (in the web interface under HDFS->Service Actions -> Download Client Configs". This is a .tar.gz archive with standard hadoop configuration files.

"-v /source/folder:/input"

Folder containing the files you would like to ingest. We only support uploading the entire content of a folder.

"nlesc/hdfs-ingest"

Name of the image. In this case the name of the image on dockerhub.

"/hdfs/destination/folder"

Destination of the files inside of hdfs.
