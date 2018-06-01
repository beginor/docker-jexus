# Jexus in docker

## Version Info:

- Jexus 5.8.3.10
- Mono 5.10.1.47
- Ubuntu 16.04 (TimeZone set to Asia/Shanghai)

## Usage:

1. Get the image with command:

  ```sh
  docker pull beginor/jexus:5.8.3.10
  ```

2. Prepare the directors for volumes:

  ```sh
  mkdir -p "$(pwd)/jexus/conf"
  mkdir -p "$(pwd)/jexus/www"
  mkdir -p "$(pwd)/jexus/log"
  ```

3. Copy your website config file to `$(pwd)/jexus/conf` folder, Copy your websites to `$(pwd)/jexus/www` folder

4. Run the image with command:

  ```sh
  docker run \
      --detach \
      --name jexus \
      --restart unless-stopped \
      --publish 9999:80 \
      --volume $(pwd)/jexus/www:/var/www \
      --volume $(pwd)/jexus/conf:/usr/jexus/siteconf \
      --volume $(pwd)/jexus/log:/usr/jexus/log \
      beginor/jexus:5.8.3.10
  ```

5. Then browse [http://127.0.0.1:9999/info](http://127.0.0.1:9999/info) with your faverite borwser, see what happens.

> You can change the port 9999 as your like.
