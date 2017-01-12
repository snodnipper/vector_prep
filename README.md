## Prepare ##

Please ensure that you set the `DOWNLOAD_URL` and `DOWNLOAD_TOKEN` environmental variables.  For example:
```console
export DOWNLOAD_URL="mapbox://styles/username/cierw1nhu00bi8bnymdqvihrq"
export DOWNLOAD_TOKEN="pk.ezG4Ijoic25vZG5pcHPlciIsImFiOiIwNTUzNgEzNWIxRzk4ODM0NTUxZWIyMzceZjR7MDI1MiJ9.s9T8QPo0GjAV5OBvRdfnzA"
```

We also set the source MBTiles file to download:
```console
export DOWNLOAD_MBTILES="https://download-location.com/OS_data_z15_0_7.mbtiles"
```

We can then execute the workflow:
```console
./InstallDocker.sh
./1_repo_clone/run.sh
./2_build_sdk_containers/run.sh
./3_download_from_endpoint/run.sh
```

Note: the example download url points to a Mapbox endpoint.  Mapbox licensing only permits downloads for use by the device initiating the download - you should therefore ensure that your actions are permitted according to the Mapbox TOS.  Typically, one would use their own download location to obtain their own content (not, say, Streets-V9 etc. - which is Mapbox data!).
