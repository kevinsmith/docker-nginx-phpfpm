# klsmith/nginx-phpfpm

A reliable, highly-configurable nginx + php-fpm web server, available for PHP 5.6 and 7.1.

## Simple Example

Run the following in the command line:

```
docker run -d -p 8080:80 -e NGINX_ENABLE_AUTH=false klsmith/nginx-phpfpm:5.6-fpm
```

Point your browser to [http://localhost:8080](http://localhost:8080). You should see [a simple "Hello world!" page](#hello-world) that notes the container hostname and any environment variables.

## Usage

### Docker Compose

This one is just a simple example to show how it works and is accessible at [https://localhost:4433](https://localhost:4433) (and you'll need to bypass the self-signed SSL cert warning).

```
version: '2'

services:
  web:
    image: klsmith/nginx-phpfpm:7.1-fpm
    environment:
      - NGINX_ENABLE_SSL=true
      - NGINX_ENABLE_AUTH=false
      - NGINX_HTTPS_PORT=4433
    ports:
      - '4433:4433'
    restart: always

    volumes:
      - '/persistent/storage/uploads:/var/files/uploads'
```

### Environment Variables

| Environment Variable | Default | Description |
|----------------------|-----------|-------------|
| NGINX_TRAILING_SLASH |  | Enforce trailing slash conformity for URLs ending without a file extension. e.g. _http://example.com/no/trailing/slash_ Possible values: `ensure`, `remove` |
| NGINX_ABSOLUTE_REDIRECT | `on` | If disabled, redirects issued by nginx will be relative. Maps directly to [absolute_redirect nginx directive](http://nginx.org/en/docs/http/ngx_http_core_module.html#absolute_redirect). |
| NGINX_PORT_IN_REDIRECT | `on` | When enabled, HTTP(S) ports are included in absolute redirects issued by nginx. Maps directly to [absolute_redirect nginx directive](http://nginx.org/en/docs/http/ngx_http_core_module.html#port_in_redirect). |
| NGINX_ENABLE_ACCESS_LOG | `false` | Enable nginx access log. Set access log location with `NGINX_ACCESS_LOG_LOCATION`. |
| NGINX_ACCESS_LOG_LOCATION | `/var/log/nginx/access.log` | Set nginx's [access_log path](http://nginx.org/en/docs/http/ngx_http_log_module.html#access_log). |
| NGINX_ENABLE_AUTH | `true` | Enable basic access authentication for URLs served up by nginx. This setting is enabled by default to keep sites from being unknowingly made public. |
| NGINX_AUTH_WHITELIST |  | Comma-delimited list of IP addresses to whitelist for basic access authentication. |
| NGINX_ENABLE_FASTCGI_CACHE | `false` | Enable FastCGI caching. |
| NGINX_CACHE_TTL | `10m` | FastCGI cache time-to-live. The length of time a cached page will continue to be served up before going stale. Maps directly to the inactive _inactive_ parameter of nginx's [fastcgi_cache_path directive](http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html#fastcgi_cache_path). |
| NGINX_ENABLE_SSL | `false` | Serve up URLs via secure protocol (HTTPS). |
| NGINX_HTTP_PORT | `80` | Set the port used when connecting over HTTP. |
| NGINX_HTTPS_PORT | `443` | Set the port used when connecting over HTTPS. |
| NGINX_LOCATION | `/` | Set the main nginx location block's uri. Especially useful when running a separate Docker container for a site's subfolder, e.g. `/blog/`. |
| NGINX_NOINDEX | `false` | Send noindex, nofollow, nosnippet, and noarchive directives in **X-Robots-Tag** HTTP header. [More info.](https://developers.google.com/search/reference/robots_meta_tag) |
| NGINX_NON_CANONICAL |  | A comma-delimited list of hostnames that should be 301 redirected to the canonical hostname. e.g. `www.example.com` if your site is meant to be accessed as http://example.com. Commonly phrased as "redirect www to non-www" or vice-versa. This will redirect the full URL path. (Requires `NGINX_SERVER_NAME` be explicitly set.) |
| NGINX_CANONICAL_SCHEME | `http` (`https` if NGINX_ENABLE_SSL is enabled) | URL scheme to use for destination URLs that are the result of `NGINX_NON_CANONICAL`. (Requires `NGINX_SERVER_NAME` be explicitly set.) |
| NGINX_SERVER_NAME | `_` | Explicitly declare [nginx server name](http://nginx.org/en/docs/http/server_names.html). Must be set for `NGINX_NON_CANONICAL` and `NGINX_CANONICAL_SCHEME` to have any effect. Practically-speaking, that's the only reason this would need to be set anyway since it's the destination hostname for 301 redirect triggered by `NGINX_NON_CANONICAL`. |
| NGINX_SSL_CERT | `/etc/nginx/ssl/self-signed.crt` | Self-signed SSL cert for localhost. FOR USE IN DEVELOPMENT ENVIRONMENTS ONLY. |
| NGINX_SSL_CERT_KEY | `/etc/nginx/ssl/self-signed.key` | Self-signed SSL key for localhost. FOR USE IN DEVELOPMENT ENVIRONMENTS ONLY. |

## Hello world!

The single "Hello world!" `index.php` in this image is used to show a given container is working properly, and it's borrowed and heavily modified from [Docker Cloud's hello-world](https://github.com/docker/dockercloud-hello-world).

## Bug Reports

If you think you've found a bug, please post a good quality bug report in [this project's GitHub Issues](https://github.com/kevinsmith/docker-nginx-phpfpm/issues). Quoting from [Coen Jacobs](https://coenjacobs.me/2013/12/06/effective-bug-reports-on-github/), this is how you can best help me understand and fix the issue:

- The title **explains the issue** in just a couple words
- The description **is detailed enough** and contains at least:
  - **steps to reproduce** the issue
  - what the expected result is and **what actually happens**
  - the **version** of the software being used
  - versions of **relevant external software** (e.g. hosting platform, orchestrator, etc.)
- Explain **what you’ve already done** trying to fix this issue
- The report is **written in proper English**

## License

Copyright 2017 Kevin Smith

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
