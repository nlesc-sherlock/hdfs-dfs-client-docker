# hdfs-dfs-client-docker
Docker-based tool capable of interacting with a remote hdfs filesystem

This tool (wrapped in a docker image for convienence) runs the yarn/hadoop "hdfs dfs" client subcommand. It can be used to e.g. upload files to a hdfs instance (usually a cluster).

This image is available on dockerhub as nlesc/hdfs-dfs-client

## Config file

The tool needs the location of your hdfs system. We currently only support the "client configs" format as produced by Ambari (in the web interface under HDFS->Service Actions -> Download Client Configs". This is a .tar.gz archive with standard hadoop configuration files.

Pass the config as a file by mounting it as a volume when running the container: 

```
"-v /home/user/config.tar.gz:/config.tar.gz"
```

## Username

We assume you are using "simple authentication", where the local user on the client side determines the hdfs user (and thus if you have access).

The hdfs user needs to be specified as the first argument of the docker run command

## Build

Build this image as follows.

```
docker build -t nlesc/hdfs-dfs-client .
```
## Examples

### Get help

```
docker run -v <config_file_location>:/config.tar.gz nlesc/hdfs-dfs-client <hdfs_username> 
```
### List a folder

```
docker run -v <config_file_location>:/config.tar.gz nlesc/hdfs-dfs-client <hdfs_username> -ls /
```
### Upload a folder

```
docker run -v <config_file_location>:/config.tar.gz -v <source_folder>:/input nlesc/hdfs-dfs-client <hdfs_username> -put /input <hdfs_target-folder>
```

e.g.

```
docker run -v /home/myuser/config.tar.gz:/config.tar.gz -v /home/myuser/data:/input nlesc/hdfs-dfs-client myuser -put /input /user/myuser/data
```

